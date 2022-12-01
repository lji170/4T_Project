DROP TABLE TBL_COMMENT;
DROP TABLE TBL_LIKE;
DROP TABLE GALLERY;

DROP SEQUENCE GALLERY_SEQ;
CREATE SEQUENCE GALLERY_SEQ NOCACHE;
DROP SEQUENCE TBL_LIKE_SEQ;
CREATE SEQUENCE TBL_LIKE_SEQ NOCACHE;
DROP SEQUENCE TBL_COMMENT_SEQ;
CREATE SEQUENCE TBL_COMMENT_SEQ NOCACHE;


-- 갤러리 TABLE
CREATE TABLE GALLERY (
   GAL_NO                NUMBER,
   ID                    VARCHAR2(30 BYTE)    NOT NULL,
   GAL_TITLE            VARCHAR2(100 BYTE)	  NOT NULL,
   GAL_CONTENT            VARCHAR2(1000 BYTE) NOT NULL,
   GAL_CREATE_DATE     DATE,
   GAL_LAST_MODIFY_DATE DATE,
   GAL_HIT                NUMBER,
   LIKE_COUNT           NUMBER,
   IP                    VARCHAR2(30 BYTE) NOT NULL,
    CONSTRAINT PK_GALLERY PRIMARY KEY (GAL_NO)
);
-- 갤러리 외래키 : 회원이 탈퇴하면 갤러리가 삭제된다.
ALTER TABLE GALLERY
    ADD CONSTRAINT FK_GALLERY_USERS
        FOREIGN KEY(ID) REFERENCES USERS(ID)
            ON DELETE CASCADE;


-- 댓글 TABLE
CREATE TABLE TBL_COMMENT (
   COMMENT_NO                NUMBER NOT NULL,
   GAL_NO                    NUMBER NOT NULL,
   ID                        VARCHAR2(30 BYTE)   NOT NULL,
   COMMENT_TITLE            VARCHAR2(100 BYTE) NOT NULL,
   COMMENT_CREATE_DATE        DATE,
   COMMNET_LAST_MODIFY_DATE DATE,
   IP                        VARCHAR2(30 BYTE) NOT NULL,
    CONSTRAINT PK_COMMENT PRIMARY KEY (COMMENT_NO)
);

-- 갤러리 댓글 외래키 : 갤러리가 삭제되면 댓글도 삭제된다.
ALTER TABLE TBL_COMMENT
    ADD CONSTRAINT FK_COMMENT_GALLERY
        FOREIGN KEY(GAL_NO) REFERENCES GALLERY(GAL_NO)
            ON DELETE CASCADE;

-- 갤러리 댓글 외래키 : 회원이 탈퇴하면 댓글도 삭제된다.
ALTER TABLE TBL_COMMENT
    ADD CONSTRAINT FK_COMMENT_USERS
        FOREIGN KEY(ID) REFERENCES USERS(ID)
            ON DELETE CASCADE;
            
            -- 좋아요 TABLE
CREATE TABLE TBL_LIKE (
   LIKE_NO    NUMBER   NOT NULL,
   GAL_NO       NUMBER   NOT NULL,
   ID           VARCHAR2(30 BYTE)   NOT NULL,
   LIKE_DATE   DATE   NULL,
    CONSTRAINT PK_LIKE PRIMARY KEY (LIKE_NO)
);

-- 좋아요 외래키 : 갤러리가 삭제되면 댓글도 삭제된다.
ALTER TABLE TBL_LIKE
    ADD CONSTRAINT FK_LIKE_GALLERY
        FOREIGN KEY(GAL_NO) REFERENCES GALLERY(GAL_NO)
            ON DELETE CASCADE;

-- 갤러리 댓글 외래키 : 회원이 탈퇴하면 댓글도 삭제된다.
ALTER TABLE TBL_LIKE
    ADD CONSTRAINT FK_LIKE_USERS
        FOREIGN KEY(ID) REFERENCES USERS(ID)
            ON DELETE CASCADE;