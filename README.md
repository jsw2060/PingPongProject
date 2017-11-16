# PingPongProject

# You need to put ojdbc7.jar file in the directory(C:\Program Files\Java\jre1.8.0_144\lib\ext) to start this project

# You need to put some data in a Locker table and Bootrack table for making certain views.
^ In the Locker table, 1~120 tuples has a each locker_code in numerical order.
^ In the Bootrack table, 1~36 tuples has a each bootrack_code in numerical order.


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
