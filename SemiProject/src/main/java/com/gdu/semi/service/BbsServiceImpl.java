package com.gdu.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.semi.domain.BbsDTO;
import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.mapper.BbsMapper;
import com.gdu.semi.util.PageUtil;
import com.gdu.semi.util.SecurityUtil;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class BbsServiceImpl implements BbsService {

	private BbsMapper bbsMapper;
	private PageUtil pageUtil;
	private SecurityUtil securityUtil;
	
	@Override
	public void findAllBbsList(HttpServletRequest request, Model model) {
		
		
		// 파라미터 page, 전달되지 않으면 page=1로 처리
		Optional<String> opt1 = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt1.orElse("1"));
		
		// 파라미터 recordPerPage, 전달되지 않으면 recordPerPage=10으로 처리
		Optional<String> opt2 = Optional.ofNullable(request.getParameter("recordPerPage"));
		int recordPerPage = Integer.parseInt(opt2.orElse("10"));

		// 전체 게시글 개수
		int totalRecord = bbsMapper.selectAllBbsCount();
		
		// 페이징에 필요한 모든 계산 완료
		pageUtil.setPageUtil(page, recordPerPage, totalRecord);
		
		// DB로 보낼 Map(begin + end)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		// DB에서 목록 가져오기
		List<BbsDTO> bbsList = bbsMapper.selectAllBbsList(map);
		
		// 뷰로 보낼 데이터
		model.addAttribute("bbsList", bbsList);
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/bbs/list?recordPerPage=" + recordPerPage));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("recordPerPage", recordPerPage);
		
	}

	@Override
	public int addBbs(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String bbsTitle = securityUtil.preventXSS(request.getParameter("bbsTitle"));
		String ip = request.getRemoteAddr();
		
		BbsDTO bbs = new BbsDTO();
		bbs.setId(id);
		bbs.setBbsTitle(bbsTitle);
		bbs.setIp(ip);
		
		return bbsMapper.insertBbs(bbs);
		
	}

	
	/*
		@Transactional
		안녕. 난 트랜잭션을 처리하는 애너테이션이야.
		INSERT/UPDATE/DELETE 중 2개 이상이 호출되는 서비스에 추가하면 되.
	*/
	@Transactional
	@Override
	public int addReply(HttpServletRequest request) {
		
		// 작성자
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		String id = loginUser.getId();
		
		// 제목
		String bbsTitle = securityUtil.preventXSS(request.getParameter("bbsTitle"));
		
		// IP
		String ip = request.getRemoteAddr();
		
		// 원글의 DEPTH, GROUP_NO, GROUP_ORDER
		int depth = Integer.parseInt(request.getParameter("depth"));
		int groupNo = Integer.parseInt(request.getParameter("groupNo"));
		int groupOrder = Integer.parseInt(request.getParameter("groupOrder"));
		
		// 원글DTO(updatePreviousReply를 위함)
		BbsDTO bbs = new BbsDTO();
		bbs.setDepth(depth);
		bbs.setGroupNo(groupNo);
		bbs.setGroupOrder(groupOrder);
		
		// updatePreviousReply 쿼리 실행
		bbsMapper.updatePreviousReply(bbs);
		
		// 답글DTO
		BbsDTO reply = new BbsDTO();
		reply.setId(id);
		reply.setBbsTitle(bbsTitle);
		reply.setIp(ip);
		reply.setDepth(depth + 1);            // 답글 depth : 원글 depth + 1
		reply.setGroupNo(groupNo);            // 답글 groupNo : 원글 groupNo
		reply.setGroupOrder(groupOrder + 1);  // 답글 groupOrder : 원글 groupOrder + 1
		
		// insertReply 쿼리 실행		
		return bbsMapper.insertReply(reply);
		
	}

	@Override
	public int removeBbs(int bbsNo) {
		return bbsMapper.deleteBbs(bbsNo);
	}
	
	@Override
	public int modifyBbs(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		String id = loginUser.getId();
		
		String bbsTitle = request.getParameter("bbsTitle");
		int bbsNo = Integer.parseInt(request.getParameter("bbsNo"));
		
		BbsDTO bbs = BbsDTO.builder()
				.id(id)
				.bbsTitle(bbsTitle)
				.bbsNo(bbsNo)
				.build();
		
		int result = bbsMapper.updateBbsNo(bbs);

		return result;
		
	}
		
	
	}
