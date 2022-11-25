DROP TABLE ACCESS_LOG;

CREATE TABLE ACCESS_LOG (
    ID	VARCHAR2(30 BYTE)	NOT NULL UNIQUE,
	ACCESS_LOG_NO	NUMBER	NOT NULL,
	LAST_LOGIN_DATE	DATE	NULL
);

ALTER TABLE ACCESS_LOG ADD CONSTRAINT FK_USERS_ACCESS_LOG FOREIGN KEY (ID) REFERENCES USERS (ID);


