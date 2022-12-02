package com.gdu.semi.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi.domain.AttachDTO;
import com.gdu.semi.domain.UploadDTO;
import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.mapper.UploadMapper;
import com.gdu.semi.util.MyFileUtil;
import com.gdu.semi.util.PageUtil;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class UploadServiceImpl implements UploadService {
	
	
	// # 빈

		PageUtil pageUtil;				// * 페이징 처리
		UploadMapper uploadMapper;		// * 맵핑
		MyFileUtil fileUtil;			// * 파일명처리
		
		// # 게시글 목록
		// (1) 페이징 처리			: selectUploadCount
		// (2) 목록 list로 가져오기 : selectUploadList
		@Override
		public void getUploadList(HttpServletRequest request, Model model) {
			
			
		// * 임시아이디 : 추후에 지우기
		// => 앞으로 호출하는 모든 id는 admin으로 통일
		
		/*
		 * HttpSession sessionLogin = request.getSession();
		 * sessionLogin.setAttribute("loginUser", "admin");
		 */
		 
		// sessionLogin.removeAttribute("loginUser");
		// sessionLogin.getAttribute("loginUser");		// => 합쳤을때 사용될 코드
		
		// & 문제발생 : session에 저장된 계정을 주석처리해도 aop가 작동 안됨	------------------------------
		// - 이유 : 쓰겠다는 기능을 pom.xml에 갖다 붙여서 사용한것이 문제
		// * session : 브라우저영역에 저장, 해당 브라우저가 하나라도 켜져있으면 기존의 값을 유지
		// ---------------------------------------------------------------------------------------------------
			
		// & 문제 : ip를 조회에서 사용?		------------------------------------------------------------------
		// - 답 : 조회는 단지 db에 저장된 ip칼럼의 값을 가져오기 떄문에, ip 생성에 관한 코드를 사용하지않는다
		// ---------------------------------------------------------------------------------------------------
			
		// 1. 페이징 처리
		// 1) page 파라미터
		// - 첫 요청 : list.jsp가 컨텍스트 패스기 때문에 전달된 page 파라미터값이 없다
		// => 해결 : optional로 null값을 1로 처리(맨처음에 apping상에는 보이지않음, 그저 맨 처음에 보여주는 페이지를 결정한다)
		// - 이후의 요청 : pageutil을 통해 a링크에 page 태그가 존재하기 때문에 파라미터값을 전달받는다
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));	
		// - 시작페이지는 1페이지부터
		
		
		// 2) 전체 게시글 수 : (1) list.jsp에 보여주기, (2) pageutil에 사용
		int totalUploadCnt = uploadMapper.selectUploadCount();
		int recordPerPage = 10;
		// 3) 페이징 유틸 : 페이지 처리에 필요한 변수 계산
		pageUtil.setPageUtil(page, recordPerPage, totalUploadCnt);
		
		// 4) 게시글의 시작글, 끝글 번호 정하기(3번에서 계산해온)
		Map<String, Object> map = new HashMap<>();				// - db에 보낼 map
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
			
		// 5) 뷰로 전달할 데이터를 model에 저장 
		// (1) paging : 페이지 블록 태그 반환
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/upload/list"));	
		// 2)  totalRecord : 전체 게시글 수 반환
		model.addAttribute("totalUploadCnt", totalUploadCnt);	
		// 3) beginNo : 게시글의 시작번호
		// * 용도 : jsp로 전달하여 인덱스를 생성하는데 사용 ***
		model.addAttribute("beginNo", totalUploadCnt - (page-1) * pageUtil.getRecordPerPage());	
		
		// * 게시글의 시작번호가 큰 번호부터 시작되는 이유 : 쿼리떄문이 아니다!
		// (1) 서비스 : 서비스에서 게시글의 최상단 시작값을 전달해줌
		// (2) jsp : 전달된 beginNo에 index를 반복문을 이용해서 뺌
		
		//  2. 목록 list를 model에 저장
		// - map(begin, end를 전달) : 한 페이지당 보여줄 게시글 수를 정한다
		model.addAttribute("uploadList", uploadMapper.selectUploadList(map));
		
		// + 상세서비스 조회수 : list.jsp로 돌아갈때 updateHit 속성값을 null값으로 만들기
		HttpSession session = request.getSession();
		//System.out.println(session.getAttribute("updateHit"));
		if(session.getAttribute("updateHit") != null) {
			session.removeAttribute("updateHit");
		}
		
		//System.out.println(session.getAttribute("updateHit"));

		
		
		}
		
		// # 게시글 상세 : 두 테이블 조회는 model에 속성 저장, hit 처리
		@Override
		public void getUploadByNo(HttpServletRequest request, Model model) {
			
			// & 문제발생		---------------------------------------------------------------------
			// (1) 매개변수로 boardNo, model을 전달받아,
			// (2) model에서 request를 꺼내 조회수 처리를 위해 header영역의 referer을 참조하고자 했다
			// - 문제 : referer의 값이 null값이 떨어졌다
			// - 이유 : request는 http요청으로 넘어온게 아닌, 서비스에서 만들었기 때문인듯
			// - 해결방법 : 매개변수를 HttpServletRequest로 하여 처리한다
			// --------------------------------------------------------------------------------------
			
			// & 문제발생		---------------------------------------------------------------------
			// - 문제 : 상세화면 요청시 내가 누른 조회수까지 최신 반영 시켜야함
			// - 해결 : 조회수 쿼리를 먼저 신청하고, 이후에 조회문을 실시
			// --------------------------------------------------------------------------------------
			
			// 1. 파라미터
			Optional<String> opt = Optional.ofNullable(request.getParameter("uploadNo"));
			int uploadNo = Integer.parseInt(opt.orElse("0"));

			
			// 2. 게시글 hit 처리
			// - hit 조건 : 이전페이지가 list.jsp 였을 경우에만 조회수 증가시키기
			HttpSession session = request.getSession();
			String referer = request.getHeader("referer");	
			
			if(referer.endsWith("upload/list") && session.getAttribute("updateHit") == null) {	// <= 요기 /를 list로 수정안해서 오류발생
				uploadMapper.updateHit(uploadNo);
				session.setAttribute("updateHit", "done");
			}
			
			// 3. upload 테이블 조회
			model.addAttribute("upload", uploadMapper.selectUploadByNo(uploadNo));
			// 4. attach 테이블 조회
			model.addAttribute("attachList", uploadMapper.selectAttachList(uploadNo));
			

			
			
		}
		
		
		// # 게시글 추가
		@Transactional	// 트랜잭션 처리
		@Override
		public void addRead(MultipartHttpServletRequest multipartServletRequest, HttpServletResponse response) {
			
			// [1] upload 테이블 추가
			
			// 1. 파라미터
			// 1) 파라미터
			String title = multipartServletRequest.getParameter("title");
			String content = multipartServletRequest.getParameter("content");
		
			
			// 2) ip 가져오기 : 경유지가 없는
			
			Optional<String> opt = Optional.ofNullable(multipartServletRequest.getHeader("X-Forward-For"));
			String ip = opt.orElse(multipartServletRequest.getRemoteAddr());
			// System.out.println(ip);
			
			// -------------------------------------------------------------------------------------------------------
			
			// 3) id 가져오기 : users 테이블에서(또는 session영역에서)
			HttpSession sessionLogin = multipartServletRequest.getSession();
			
			
			UserDTO user = (UserDTO)sessionLogin.getAttribute("loginUser");
			
			String id = user.getId();
			// System.out.println(id);	// admin
			
			// 2. dto 생성
			UploadDTO upload = UploadDTO.builder()
					.uploadTitle(title)
					.uploadContent(content)
					.id(id)
					.ip(ip)
					.build();
			
			// 3. 게시글 삽입 
			
			int uploadResult = uploadMapper.insertUpload(upload);
			
			
			// [2] Attach 테이블 추가
			
			// 1. 파라미터 : 첨부된 파일목록
			List<MultipartFile> files = multipartServletRequest.getFiles("files");
			
			// 2.1 첨부파일이 없는 경우
			// * 첨부파일이 없는경우, MultipartFile는 size값이 0이다 
			int attachResult;
			if(files.get(0).getSize() == 0) {
				attachResult = 1;
			} else {
				attachResult = 0;
			}
			
			
			// 2.2 첨부파일이 있는 경우 
			// 1) 첨부파일 순회
			for(MultipartFile multipartFile : files) {
				try {
					if(multipartFile != null && multipartFile.isEmpty() == false) {
						
					
					// (1) 원래이름
					// ie : 인터넷 익스플로러는 본래 파일명에 // 전체경로가 붙는다
					String origin = multipartFile.getOriginalFilename();
					origin = origin.substring(origin.lastIndexOf("\\") + 1);
					// - 해석 : 마지막 \\ 보다 인덱스 1을 추가한 다음부터의 문자열이 origin
					
					// (2) 저장할 이름 : db에 저장시 중복되지않게 uuid처리
					String filesystem = fileUtil.getFilename(origin);
					
					// (3) 저장경로: 오늘날짜를 경로로 사용
					// * 별도의 설정이 없어 sts 폴더 안에 생성될것
					String path = fileUtil.getTodayPath();
					
					// (4) 저장할 경로 만들기
					File dir = new File(path);
					if(dir.exists() == false) {
						dir.mkdirs();
					}
					
					// (5) 첨부할 파일 객체
					File file = new File(dir, filesystem);
					
					// (6) 서버에 파일 저장 
					// multipartFile에 저장된 데이터를 생성한 file에 주입
					multipartFile.transferTo(file);
					
					// (7) db에 저장할 attachDTO 생성
					AttachDTO attach = AttachDTO.builder()
							.path(path)
							.origin(origin)
							.filesystem(filesystem)
							.uploadNo(upload.getUploadNo())
							.build();
					
					// (8) db에 저장 : 첨부파일의 성공여부에 따라 값이 달라짐
					// & list가 아닌 dto인 이유 : 어자피 for 반복문으로 첨부파일수만큼 실행되기때문
					attachResult += uploadMapper.insertAttach(attach);
					// ex) 첨부파일 3개, 성공 3개 = 3
				
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			// [4] point처리 + 응답
			// 1) id를 매개변수로 하여 point를 증가시켜주는 update 쿼리문 생성
			// (테이블은 users테이블 사용)
			// 2) 조건 : 두개의 result가 모두 1일 경우실행가능
			try {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				
				if(uploadResult > 0 && attachResult == files.size()) {
				// * multipartfile은 첨부파일이 없으면 size가 0, 있으면 size가 1이다
					uploadMapper.updatePoint(id);
					out.println("<script>");
					out.println("alert('업로드 되었습니다.');");
					out.println("location.href='" + multipartServletRequest.getContextPath() + "/upload/list'");
					out.println("</script>");
				} else {
					out.println("<script>");
					out.println("alert('업로드 실패했습니다.');");
					out.println("history.back();");
					out.println("</script>");
				}
				out.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
			
			// # 첨부 개별 다운로드
			@Override
			public ResponseEntity<Resource> download(String agent, HttpServletRequest request) {
				
			// & 수정 : 포인트 감소를 먼저해야, 실패시 다운로드되는 처리를 막을 수 있음
			// [1] 포인트 감소 : 다운받은 사람의 id의 포인트를 줄여아하기 때문에 session 영역의 id가 필요
			// 1) session 영역에서 id 가져오기
			HttpSession sessionLogin = request.getSession();
			UserDTO user = (UserDTO)sessionLogin.getAttribute("loginUser");
			
			String id = user.getId();
			
			//	(2) 포인트 감소시키기	: 포인트 부족 응답처리는 aop에서!
			uploadMapper.deletePoint(id);
		
			
				
			// [2] 해당 다운로드 파일 조회	
			// 1. 특정한 첨부파일 조회
			//	1) 파라미터
			Optional<String> opt = Optional.ofNullable(request.getParameter("attachNo"));
			int attachNo = Integer.parseInt(opt.orElse("0"));

			// 	2) db로 전송
				AttachDTO attach = uploadMapper.selectAttachByNo(attachNo);
				
			// 2. db에 저장된 파일의 경로와 변환이름 가져오기
			File file = new File(attach.getPath(), attach.getFilesystem());
			
			// 3. 반환할 resource 객체 생성
			// * file객체 : db에서 받은 정보로 서버(하드)에 저장된 파일 객체를 의미
			// * file객체를 다운로드할 수 있도록 resource에 저장하였다
			Resource resource = new FileSystemResource(file);
			
			// 4. 파일이 없을경우 실패처리
			if(resource.exists() == false) {
				return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
			}
			
			// 5. 다운로드 되는 파일명 처리
			// 1) 원래 파일명 : 다운로드는 원래 파일명으로 다운로드
			String origin = attach.getOrigin();
			
			// 2) 브라우저에 따른 파일명 인코딩 처리(컴퓨터가 읽을 수 있도록)
			try {
				
				// (1) IE
					if(agent.contains("Trident")) {
						origin = URLEncoder.encode(origin, "utf-8").replaceAll("[+]", " ");
					}
				// (2) Edge
					else if (agent.contains("Edg")) {
						origin = URLEncoder.encode(origin, "utf-8");
				// (3) 나머지
					} else {
						origin = new String(origin.getBytes("utf-8"), "ISO-8859-1");
					}
				// * new String(바이트배열, 캐릭터셋)
				// - 기능 : 바이트배열을 주어진 캐릭터셋으로 스트링을 만든다
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			// 6. 다운로드 헤더 만들기
			// * Content-Disposition 
			// - 헤더의 일종
			// - 기능 : 설정에 따라 파일을 로컬에 다운로드할지, 브라우저에 띄울지, 파일이름을 지정할지
			// 		선택가능하다
			// * Content-Length
			// - 헤더의 일종으로, 파일의 크기를 결정
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Disposition", "attachment; filename=" + origin);
			header.add("Content-Length", file.length() + "");	// ""는 문자열처리하기위해 붙임
			
			 
			// [3] 첨부파일 다운로드 수 증가
			// 1) 다운로드 수 증가시키기
			uploadMapper.updateDownloadCnt(attachNo);
			
			// 2) jsp화면에 다운로드수 띄우기
			// => 별도의 처리없이 그냥 detail.jsp에서 띄우면될듯
			
			
			
			
			// & 문제 : 만약 동일한 파일을 다른 게시물에 올렸을경우 그 파일의 전체 조회수가
			// 			오르는거아닌지?
			// 	해결 : 문제없음, 애초에 파일이 같든 말든, db에는 다른 attachNo로 등록된다
			// * 게시글마다 attachNo가 같을 수 없다
			
			return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
		}
			
			
			// # 첨부파일 전체 다운로드
			@Override
			public ResponseEntity<Resource> downloadAll(String agent, HttpServletRequest request) {
				
				// [1] 첨부파일 다운로드
				// 1. 다운로드할 첨부파일 조회 : list로 조회
				// 1) 파라미터  
				Optional<String> opt = Optional.ofNullable(request.getParameter("uploadNo"));
				int uploadNo = Integer.parseInt(opt.orElse("0"));
				
				// 2) db조회
				List<AttachDTO> attachList = uploadMapper.selectAttachList(uploadNo);
				
				// 2. zip파일을 생성해  주입
				FileOutputStream fout = null;		// 파일생성, 출력
				ZipOutputStream zout = null;		// zip파일에 첨부파일 출력
				FileInputStream fin = null;			// 데이터 입력
				
				// 1) 폴더생성 및 zip 경로생성
				String zipPath = "storage" + File.separator + "temp";
				File zipDir = new File(zipPath);
				if(zipDir.exists() == false) {
					zipDir.mkdirs();
				}
				
				// 2) zip파일명 : 타임스탬프값
				String zipName = System.currentTimeMillis() + ".zip";
				
				// 3) zip 파일 생성 및 파일객체 저장
				try {
					
					fout = new FileOutputStream(new File(zipPath, zipName));
					zout = new ZipOutputStream(fout);
				
				// 4) 첨부가 있는지 확인후 
					if(attachList != null && attachList.isEmpty() == false) {
						for(AttachDTO attach : attachList) {
							
							// (1) zip파일에 들어갈 각각의 첨부파일 객체 : 파일 원래 이름으로 첨부
							ZipEntry zipEntry = new ZipEntry(attach.getOrigin());
							// (2) putNextEntry : 압축파일 지정
							zout.putNextEntry(zipEntry);
							
							// (3) 입력 : 서버(하드)에 있는 파일객체의 내용을 zip 객체에 입력
							
							fin = new FileInputStream(new File(attach.getPath(), attach.getFilesystem()));
							byte[] buffer = new byte[1024];
							int length;
							while((length = fin.read(buffer)) != -1) {
								zout.write(buffer, 0, length);
							}
							zout.closeEntry();
							fin.close();
							
							
							// [2] 첨부파일 다운로드 수 증가 : 기존의 증가쿼리문 사용, 반복문사용?
							// * 다운로드받는 첨부파일 수만큼 증가해야한다
							uploadMapper.updateDownloadCnt(attach.getAttachNo());
							
							// [3] 포인트 감소 : 다운받은 사람의 id의 포인트를 줄여아하기 때문에 session 영역의 id가 필요
							// 1) session 영역에서 id 가져오기
							HttpSession sessionLogin = request.getSession();
							UserDTO user = (UserDTO)sessionLogin.getAttribute("loginUser");
							
							String id = user.getId();
							
							// 2) 포인트 감소시키기
							uploadMapper.deletePoint(id);
						
						}
						zout.close();
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				// 3. 반환할 resource 생성 : 생성된 zip파일을 resource로 주입
				// * 여기서 file은 위에서 생성된 zip파일을 의미
				File file  = new File(zipPath, zipName);
				Resource resource = new FileSystemResource(file);
				
				// 4. 첨부파일이 없는 경우 
				if(resource.exists() == false) {
					return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
				}
				
				// 5. 다운로드 헤더 만들기
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Disposition", "attachment; filename=" + zipName);
				header.add("Content-Length", file.length() + "");
				
				
				return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
				
			}
			
			
			// # 수정
			@Override
			public void modifyUpload(MultipartHttpServletRequest multipartServletRequest, HttpServletResponse response) {
				
				// [1] upload 테이블 수정
				// 1. 파라미터
				int uploadNo = Integer.parseInt(multipartServletRequest.getParameter("uploadNo"));
				String title = multipartServletRequest.getParameter("title");
				String content = multipartServletRequest.getParameter("content");
				
				// 2. dto 생성
				UploadDTO upload = UploadDTO.builder()
						.uploadNo(uploadNo)
						.uploadTitle(title)
						.uploadContent(content)
						.build();
				
				// 3. db 수정
				int uploadResult = uploadMapper.updateUpload(upload);
				
				
				// 1. 파라미터 : 첨부된 파일목록										<= 게시글 추가의 attach 첨부를 그대로 재활용
				List<MultipartFile> files = multipartServletRequest.getFiles("files");
				
				// 2.1 첨부파일이 없는 경우
				// * 첨부파일이 없는경우, MultipartFile는 size값이 0이다 
				int attachResult;
				if(files.get(0).getSize() == 0) {
					attachResult = 1;
				} else {
					attachResult = 0;
				}
				
				
				// 2.2 첨부파일이 있는 경우 
				// 1) 첨부파일 순회
				for(MultipartFile multipartFile : files) {
					try {
						if(multipartFile != null && multipartFile.isEmpty() == false) {
							
						
						// (1) 원래이름
						// ie : 인터넷 익스플로러는 본래 파일명에 // 전체경로가 붙는다
						String origin = multipartFile.getOriginalFilename();
						origin = origin.substring(origin.lastIndexOf("\\") + 1);
						// - 해석 : 마지막 \\ 보다 인덱스 1을 추가한 다음부터의 문자열이 origin
						
						// (2) 저장할 이름 : db에 저장시 중복되지않게 uuid처리
						String filesystem = fileUtil.getFilename(origin);
						
						// (3) 저장경로: 오늘날짜를 경로로 사용
						// * 별도의 설정이 없어 sts 폴더 안에 생성될것
						String path = fileUtil.getTodayPath();
						
						// (4) 저장할 경로 만들기
						File dir = new File(path);
						if(dir.exists() == false) {
							dir.mkdirs();
						}
						
						// (5) 첨부할 파일 객체
						File file = new File(dir, filesystem);
						
						// (6) 서버에 파일 저장 
						// multipartFile에 저장된 데이터를 생성한 file에 주입
						multipartFile.transferTo(file);
						
						// (7) db에 저장할 attachDTO 생성
						AttachDTO attach = AttachDTO.builder()
								.path(path)
								.origin(origin)
								.filesystem(filesystem)
								.uploadNo(upload.getUploadNo())
								.build();
						
						// (8) db에 저장 : 첨부파일의 성공여부에 따라 값이 달라짐
						// & list가 아닌 dto인 이유 : 어자피 for 반복문으로 첨부파일수만큼 실행되기때문
						attachResult += uploadMapper.insertAttach(attach);
						// ex) 첨부파일 3개, 성공 3개 = 3
					
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				// [4}  응답
				// 1) id를 매개변수로 하여 point를 증가시켜주는 update 쿼리문 생성
				// (테이블은 users테이블 사용)
				// 2) 조건 : 두개의 result가 모두 1일 경우실행가능
				try {
					response.setContentType("text/html; charset=utf-8");
					PrintWriter out = response.getWriter();
					
					if(uploadResult > 0 && attachResult == files.size()) {
						out.println("<script>");
						out.println("alert('업로드 되었습니다.');");
						out.println("location.href='" + multipartServletRequest.getContextPath() + "/upload/list'");
						out.println("</script>");
					} else {
						out.println("<script>");
						out.println("alert('업로드 실패했습니다.');");
						out.println("history.back();");
						out.println("</script>");
					}
					out.close();
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			// # 첨부파일 삭제
			// 1) 개별삭제
			@Override
			public void removeAttach(int attachNo) {
				
				// 1. db에 조회 : attach 테이블을 조회해 해당 첨부파일 삭제
				AttachDTO attach = uploadMapper.selectAttachByNo(attachNo);
				
				// 2. db에 저장된 첨부파일 정보 삭제
				int result = uploadMapper.deleteAttach(attachNo);
				
				// 3. 파일 객체로 만들어 서버(하드)에 저장되어있는 첨부파일도 삭제
				if(result > 0) {
					File file = new File(attach.getPath(), attach.getFilesystem());
					if(file.exists()) {
						file.delete();
					}
				}
				
				
			}
			
			// 2) 전부삭제
			@Override
			public void removeAttachAll(int uploadNo) {
				
				// 1. db에 조회 : attach 테이블을 조회해 해당 첨부파일 삭제
							List<AttachDTO> attachList = uploadMapper.selectAttachList(uploadNo);
							
							// 2. db에 저장된 첨부파일 정보 삭제
							int result = uploadMapper.deleteAttachAll(uploadNo);
							
							// 3. 파일 객체로 만들어 서버(하드)에 저장되어있는 첨부파일도 삭제
							if(result > 0) {
								for(AttachDTO attach : attachList) {
									File file = new File(attach.getPath(), attach.getFilesystem());
									if(file.exists()) {
										file.delete();
								}
							}
						}
			}
			

			// # 게시글 삭제 
			// * upload 테이블의 값을 지우면 참조하던 attach 테이블의 값들도 지워진다
			@Override
			public void removeUpload(HttpServletRequest multipartRequest, HttpServletResponse response) {
				
				// 1. 파라미터
				int uploadNo = Integer.parseInt(multipartRequest.getParameter("uploadNo"));
				
				// 2. db에서 첨부된 파일정보 조회, list로 받아오기
				List<AttachDTO> attachList = uploadMapper.selectAttachList(uploadNo);
				
				// 3. 게시글 삭제
				int result = uploadMapper.deleteUpload(uploadNo);
				
				// 4. 서버(하드)에 저장된 첨부파일 삭제
				if(result > 0) {
					if(attachList != null && attachList.isEmpty() == false) {
						// 순회하면서 하나씩 삭제
						for(AttachDTO attach : attachList) {
							// 삭제할 첨부 파일의 File 객체 생성
							File file = new File(attach.getPath(), attach.getFilesystem());
							// 삭제
							if(file.exists()) {
								file.delete();
							}
						}
					}
				}
				try {
					
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					
					if(result > 0) {
						out.println("<script>");
						out.println("alert('삭제 되었습니다.');");
						out.println("location.href='" + multipartRequest.getContextPath() + "/upload/list'");
						out.println("</script>");
					} else {
						out.println("<script>");
						out.println("alert('삭제 실패했습니다.');");
						out.println("history.back();");
						out.println("</script>");
					}
					out.close();
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			// # 검색 조회
			@Override
			public void selectUploadSearch(HttpServletRequest request, Model model) {
				
				// [1] 페이징 처리
				// 1. 파라미터
				Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
				int page = Integer.parseInt(opt.orElse("1"));
				String column = request.getParameter("column");
				String query = request.getParameter("query");
				
				Map<String, Object> map = new HashMap<>();	
				map.put("column", column);
				map.put("query", query);
				map.put("begin", pageUtil.getBegin());
				map.put("end", pageUtil.getEnd());
				int recordPerPage = 10;
				
				// 2. 조건에 따른 게시글 수 조회
				int totalUploadCnt = uploadMapper.searchUploadCnt(map);
				
				// 3. 페이징 처리
				pageUtil.setPageUtil(page, recordPerPage, totalUploadCnt);
			
				// 4. 보내기
				model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/upload/list"));	
				model.addAttribute("totalUploadCnt", totalUploadCnt);	
				model.addAttribute("beginNo", totalUploadCnt - (page-1) * pageUtil.getRecordPerPage());	
				
				// [2] 검색 조회
				List<UploadDTO> list = uploadMapper.searchUpload(map);
				
				model.addAttribute("uploadList", list);
				
			
				
			}
			
		
		

		
	
}