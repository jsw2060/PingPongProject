# PingPongProject

# You need to put ojdbc7.jar file in the directory(C:\Program Files\Java\jre1.8.0_144\lib\ext) to start this project

# You need to create these tables in a database

CREATE TABLE member(
	member_code NUMBER not null,
	id VARCHAR2(20) not null,
	password VARCHAR2(256) not null,
	approval_status VARCHAR2(1) not null,
	manager_status VARCHAR2(1) not null,
	coach_status VARCHAR2(1) not null,
	name VARCHAR2(10) not null,
	age VARCHAR2(3) not null,
	sex VARCHAR2(20) not null,
	tel VARCHAR2(20) not null,
	email VARCHAR2(30),
	addr VARCHAR2(100),
	birthday DATE not null,
	style VARCHAR2(20) default 0,
	grade VARCHAR2(3) default 0,
	note VARCHAR2(200),
	join_status VARCHAR2(1) not null,
	join_date DATE default sysdate,
	CONSTRAINT new_memberCode_pk PRIMARY KEY(member_code)
);

CREATE TABLE fee(
	fee_code NUMBER not null,
	fee_type VARCHAR2(20) not null,
	fee_amount NUMBER not null,
	fee_date DATE default sysdate,
	note VARCHAR2(200),
	CONSTRAINT new_feeCode_pk PRIMARY KEY(fee_code)
);

CREATE TABLE monthmember(
	month_code NUMBER not null,
	fee_code NUMBER not null,
	member_code NUMBER not null,
	month_registerdate DATE default sysdate,
	fee_status VARCHAR2(1) not null,
	note VARCHAR2(200),
	CONSTRAINT new_monthCode_pk PRIMARY KEY(month_code),
	CONSTRAINT monthMember_feeCode_fk FOREIGN KEY(fee_code) REFERENCES fee(fee_code),
	CONSTRAINT monthMember_memberCode_fk FOREIGN KEY(member_code) REFERENCES member(member_code)
);

CREATE TABLE coach(
	coach_code NUMBER not null,
	member_code NUMBER not null,
	coach_registerdate DATE default sysdate,
	work_weekday VARCHAR2(7),
	note VARCHAR2(200),
	CONSTRAINT new_coachCode_pk PRIMARY KEY(coach_code),
	CONSTRAINT coach_memberCode_fk FOREIGN KEY(member_code) REFERENCES member(member_code)
);

CREATE TABLE locker(
	locker_code VARCHAR2(4) not null,
	member_code NUMBER,
	locker_purpose VARCHAR2(20) default 2,
	locker_article VARCHAR2(50),
	CONSTRAINT new_lockerCode_pk PRIMARY KEY(locker_code),
	CONSTRAINT locker_memberCode_fk FOREIGN KEY(member_code) REFERENCES member(member_code)
);

CREATE TABLE bootrack(
	bootrack_code VARCHAR2(3) not null,
	member_code NUMBER,
	bootrack_status VARCHAR2(1) not null default 0,
	CONSTRAINT new_bootrackCode_pk PRIMARY KEY(bootrack_code),
	CONSTRAINT bootrack_memberCode_fk FOREIGN KEY(member_code) REFERENCES member(member_code)
);


# You need to put some data in a Locker table and Bootrack table for making certain views.
In the Locker table, 1~120 tuples has a each locker_code in numerical order.
In the Bootrack table, 1~36 tuples has a each bootrack_code in numerical order.


# You need to put these triggers

create or replace TRIGGER bootrackDeletionForMemb
BEFORE DELETE
ON member
FOR EACH ROW
BEGIN
    UPDATE bootrack b
    SET b.BOOTRACK_STATUS = 0, b.MEMBER_CODE = null
    WHERE b.member_code = :OLD.member_code;
END;


create or replace TRIGGER coachDeletionForMemb
BEFORE DELETE
ON member
FOR EACH ROW
BEGIN
    DELETE FROM coach c
    WHERE c.member_code = :OLD.member_code;
END;


create or replace TRIGGER feeDeletion
BEFORE DELETE
ON monthmember
FOR EACH ROW
BEGIN
    DELETE FROM fee f
    WHERE f.fee_code = :OLD.fee_code;
END;


create or replace TRIGGER lockerDeletionForMemb
BEFORE DELETE
ON member
FOR EACH ROW
BEGIN
    UPDATE locker l
    SET l.LOCKER_PURPOSE = 2, l.MEMBER_CODE = null
    WHERE l.member_code = :OLD.member_code;
END;


create or replace TRIGGER monthMembDeletionForMemb
BEFORE DELETE
ON member
FOR EACH ROW
BEGIN
    DELETE FROM monthmember mo
    WHERE mo.member_code = :OLD.member_code;
END;
