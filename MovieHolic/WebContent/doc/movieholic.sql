ALTER TABLE holic_board
	DROP
		CONSTRAINT FK_holic_user_TO_holic_board
		CASCADE;

ALTER TABLE holic_board
	DROP
		CONSTRAINT FK_holic_category_TO_holic_board
		CASCADE;

ALTER TABLE holic_coment
	DROP
		CONSTRAINT FK_holic_user_TO_holic_coment
		CASCADE;

ALTER TABLE holic_coment
	DROP
		CONSTRAINT FK_holic_board_TO_holic_coment
		CASCADE;

ALTER TABLE holic_social
	DROP
		CONSTRAINT FK_holic_user_TO_holic_social
		CASCADE;

ALTER TABLE holic_wishlist
	DROP
		CONSTRAINT FK_holic_boardcate_TO_holic_wishlist
		CASCADE;

ALTER TABLE holic_wishlist
	DROP
		CONSTRAINT FK_holic_user_TO_holic_wishlist
		CASCADE;

ALTER TABLE holic_board
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE TABLE2
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE holic_coment
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE holic_user
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE holic_category
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE holic_boardcate
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE holic_visitor
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE holic_log
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

DROP INDEX PK_holic_board;

DROP INDEX PK_TABLE2;

DROP INDEX PK_holic_coment;

DROP INDEX PK_holic_user;

DROP INDEX PK_holic_category;

DROP INDEX PK_holic_boardcate;

DROP INDEX PK_holic_visitor;

DROP INDEX PK_holic_log;

/* holic_board */
DROP TABLE holic_board 
	CASCADE CONSTRAINTS;

/* 회원_위시리스트 */
DROP TABLE TABLE2 
	CASCADE CONSTRAINTS;

/* holic_review */
DROP TABLE holic_coment 
	CASCADE CONSTRAINTS;

/* holic_social */
DROP TABLE holic_social 
	CASCADE CONSTRAINTS;

/* holic_user */
DROP TABLE holic_user 
	CASCADE CONSTRAINTS;

/* holic_category */
DROP TABLE holic_category 
	CASCADE CONSTRAINTS;

/* holic_wishlist */
DROP TABLE holic_wishlist 
	CASCADE CONSTRAINTS;

/* holic_wishlistcate */
DROP TABLE holic_boardcate 
	CASCADE CONSTRAINTS;

/* holic_visitor */
DROP TABLE holic_visitor 
	CASCADE CONSTRAINTS;

/* holic_log */
DROP TABLE holic_log 
	CASCADE CONSTRAINTS;

/* holic_board */
CREATE TABLE holic_board (
	seq NUMBER NOT NULL, /* 글번호 */
	userId VARCHAR2(100) NOT NULL, /* 회원ID */
	boardCode NUMBER NOT NULL, /* 게시판코드 */
	subject VARCHAR2(100), /* 제목 */
	postDate DATE, /* 작성일 */
	content CLOB, /* 내용 */
	starPoint NUMBER, /* 별점 */
	movieName VARCHAR2(200), /* 영화명 */
	movieCodeNaver VARCHAR2(500), /* 영화코드(네이버) */
	movieCodeYoung VARCHAR2(500), /* 영화코드(진흥원) */
	cotegory VARCHAR2(24), /* 장르 */
	best NUMBER, /* 추천 */
	worst NUMBER, /* 비추천 */
	notify NUMBER, /* 신고 */
	enable VARCHAR2(8), /* 공개여부 */
	viewCount NUMBER /* 조회수 */
);

COMMENT ON TABLE holic_board IS 'holic_board';

COMMENT ON COLUMN holic_board.seq IS '글번호';

COMMENT ON COLUMN holic_board.userId IS '회원ID';

COMMENT ON COLUMN holic_board.boardCode IS '게시판코드';

COMMENT ON COLUMN holic_board.subject IS '제목';

COMMENT ON COLUMN holic_board.postDate IS '작성일';

COMMENT ON COLUMN holic_board.content IS '내용';

COMMENT ON COLUMN holic_board.starPoint IS '별점';

COMMENT ON COLUMN holic_board.movieName IS '영화명';

COMMENT ON COLUMN holic_board.movieCodeNaver IS '영화코드(네이버)';

COMMENT ON COLUMN holic_board.movieCodeYoung IS '영화코드(진흥원)';

COMMENT ON COLUMN holic_board.cotegory IS '장르';

COMMENT ON COLUMN holic_board.best IS '추천';

COMMENT ON COLUMN holic_board.worst IS '비추천';

COMMENT ON COLUMN holic_board.notify IS '신고';

COMMENT ON COLUMN holic_board.enable IS '공개여부';

COMMENT ON COLUMN holic_board.viewCount IS '조회수';

CREATE UNIQUE INDEX PK_holic_board
	ON holic_board (
		seq ASC
	);

ALTER TABLE holic_board
	ADD
		CONSTRAINT PK_holic_board
		PRIMARY KEY (
			seq
		);


/* holic_review */
CREATE TABLE holic_coment (
	postDate DATE NOT NULL, /* 작성일 */
	userId VARCHAR2(100) NOT NULL, /* 회원ID */
	seq NUMBER NOT NULL, /* 글번호 */
	content VARCHAR2(1000) /* 내용 */
);

COMMENT ON TABLE holic_coment IS 'holic_review';

COMMENT ON COLUMN holic_coment.postDate IS '작성일';

COMMENT ON COLUMN holic_coment.userId IS '회원ID';

COMMENT ON COLUMN holic_coment.seq IS '글번호';

COMMENT ON COLUMN holic_coment.content IS '내용';

CREATE UNIQUE INDEX PK_holic_coment
	ON holic_coment (
		postDate ASC
	);

ALTER TABLE holic_coment
	ADD
		CONSTRAINT PK_holic_coment
		PRIMARY KEY (
			postDate
		);

/* holic_social */
CREATE TABLE holic_social (
	userId VARCHAR2(100) NOT NULL, /* 회원ID */
	followingId VARCHAR2(100), /* 팔로잉ID */
	followerId <지정 되지 않음>, /* 팔로워ID */
	postDate DATE /* 작성일 */
);

COMMENT ON TABLE holic_social IS 'holic_social';

COMMENT ON COLUMN holic_social.userId IS '회원ID';

COMMENT ON COLUMN holic_social.followingId IS '팔로잉ID';

COMMENT ON COLUMN holic_social.followerId IS '팔로워ID';

COMMENT ON COLUMN holic_social.postDate IS '작성일';

/* holic_user */
CREATE TABLE holic_user (
	userId VARCHAR2(100) NOT NULL, /* 회원ID */
	name VARCHAR2(16), /* 이름 */
	pass VARCHAR2(100), /* 비밀번호 */
	phoneFirst VARCHAR2(3), /* 핸드폰번호1 */
	phoneMid VARCHAR2(4), /* 핸드폰번호2 */
	phoneLast VARCHAR2(4), /* 핸드폰번호3 */
	birth VARCHAR2(16), /* 생년월일 */
	gender VARCHAR2(2), /* 성별 */
	joinDate DATE, /* 가입일 */
	outDate DATE, /* 탈퇴일 */
	profile CLOB, /* 회원사진 */
	enable VARCHAR2(8) /* 활성화여부 */
);

COMMENT ON TABLE holic_user IS 'holic_user';

COMMENT ON COLUMN holic_user.userId IS '회원ID';

COMMENT ON COLUMN holic_user.name IS '이름';

COMMENT ON COLUMN holic_user.pass IS '비밀번호';

COMMENT ON COLUMN holic_user.phoneFirst IS '핸드폰번호1';

COMMENT ON COLUMN holic_user.phoneMid IS '핸드폰번호2';

COMMENT ON COLUMN holic_user.phoneLast IS '핸드폰번호3';

COMMENT ON COLUMN holic_user.birth IS '생년월일';

COMMENT ON COLUMN holic_user.gender IS '성별';

COMMENT ON COLUMN holic_user.joinDate IS '가입일';

COMMENT ON COLUMN holic_user.outDate IS '탈퇴일';

COMMENT ON COLUMN holic_user.profile IS '회원사진';

COMMENT ON COLUMN holic_user.enable IS '활성화여부';

CREATE UNIQUE INDEX PK_holic_user
	ON holic_user (
		userId ASC
	);

ALTER TABLE holic_user
	ADD
		CONSTRAINT PK_holic_user
		PRIMARY KEY (
			userId
		);

/* holic_category */
CREATE TABLE holic_category (
	boardCode NUMBER NOT NULL, /* 게시판코드 */
	boardName VARCHAR2(100) /* 게시판명 */
);

COMMENT ON TABLE holic_category IS 'holic_category';

COMMENT ON COLUMN holic_category.boardCode IS '게시판코드';

COMMENT ON COLUMN holic_category.boardName IS '게시판명';

CREATE UNIQUE INDEX PK_holic_category
	ON holic_category (
		boardCode ASC
	);

ALTER TABLE holic_category
	ADD
		CONSTRAINT PK_holic_category
		PRIMARY KEY (
			boardCode
		);

/* holic_wishlist */
CREATE TABLE holic_wishlist (
	userId VARCHAR2(100) NOT NULL, /* 회원ID */
	code NUMBER NOT NULL, /* 코드 */
	movieCodeNaver VARCHAR2(500), /* 영화코드(네이버) */
	postDate DATE /* 작성일 */
);

COMMENT ON TABLE holic_wishlist IS 'holic_wishlist';

COMMENT ON COLUMN holic_wishlist.userId IS '회원ID';

COMMENT ON COLUMN holic_wishlist.code IS '코드';

COMMENT ON COLUMN holic_wishlist.movieCodeNaver IS '영화코드(네이버)';

COMMENT ON COLUMN holic_wishlist.postDate IS '작성일';

/* holic_wishlistcate */
CREATE TABLE holic_boardcate (
	code NUMBER NOT NULL, /* 코드 */
	category VARCHAR2(100) /* 분류명 */
);

COMMENT ON TABLE holic_boardcate IS 'holic_wishlistcate';

COMMENT ON COLUMN holic_boardcate.code IS '코드';

COMMENT ON COLUMN holic_boardcate.category IS '분류명';

CREATE UNIQUE INDEX PK_holic_boardcate
	ON holic_boardcate (
		code ASC
	);

ALTER TABLE holic_boardcate
	ADD
		CONSTRAINT PK_holic_boardcate
		PRIMARY KEY (
			code
		);

/* holic_visitor */
CREATE TABLE holic_visitor (
	connectDate DATE NOT NULL, /* 접속날짜 */
	visitor NUMBER DEFAULT 0 /* 방문자수 */
);

COMMENT ON TABLE holic_visitor IS 'holic_visitor';

COMMENT ON COLUMN holic_visitor.connectDate IS '접속날짜';

COMMENT ON COLUMN holic_visitor.visitor IS '방문자수';

CREATE UNIQUE INDEX PK_holic_visitor
	ON holic_visitor (
		connectDate ASC
	);

ALTER TABLE holic_visitor
	ADD
		CONSTRAINT PK_holic_visitor
		PRIMARY KEY (
			connectDate
		);

/* holic_log */
CREATE TABLE holic_log (
	logDate DATE NOT NULL, /* 활동시간 */
	userId VARCHAR2(100), /* 활동ID */
	log NUMBER, /* 추천비추천 */
	logCate NUMBER, /* 활동분류 */
	subect VARCHAR2(100) /* 제목 */
);

COMMENT ON TABLE holic_log IS 'holic_log';

COMMENT ON COLUMN holic_log.logDate IS '활동시간';

COMMENT ON COLUMN holic_log.userId IS '활동ID';

COMMENT ON COLUMN holic_log.log IS '추천비추천';

COMMENT ON COLUMN holic_log.logCate IS '활동분류';

COMMENT ON COLUMN holic_log.subect IS '제목';

CREATE UNIQUE INDEX PK_holic_log
	ON holic_log (
		logDate ASC
	);

ALTER TABLE holic_log
	ADD
		CONSTRAINT PK_holic_log
		PRIMARY KEY (
			logDate
		);

ALTER TABLE holic_board
	ADD
		CONSTRAINT FK_holic_user_TO_holic_board
		FOREIGN KEY (
			userId
		)
		REFERENCES holic_user (
			userId
		);

ALTER TABLE holic_board
	ADD
		CONSTRAINT FK_holic_category_TO_holic_board
		FOREIGN KEY (
			boardCode
		)
		REFERENCES holic_category (
			boardCode
		);

ALTER TABLE holic_coment
	ADD
		CONSTRAINT FK_holic_user_TO_holic_coment
		FOREIGN KEY (
			userId
		)
		REFERENCES holic_user (
			userId
		);

ALTER TABLE holic_coment
	ADD
		CONSTRAINT FK_holic_board_TO_holic_coment
		FOREIGN KEY (
			seq
		)
		REFERENCES holic_board (
			seq
		);

ALTER TABLE holic_social
	ADD
		CONSTRAINT FK_holic_user_TO_holic_social
		FOREIGN KEY (
			userId
		)
		REFERENCES holic_user (
			userId
		);

ALTER TABLE holic_wishlist
	ADD
		CONSTRAINT FK_holic_boardcate_TO_holic_wishlist
		FOREIGN KEY (
			code
		)
		REFERENCES holic_boardcate (
			code
		);

ALTER TABLE holic_wishlist
	ADD
		CONSTRAINT FK_holic_user_TO_holic_wishlist
		FOREIGN KEY (
			userId
		)
		REFERENCES holic_user (
			userId
		);