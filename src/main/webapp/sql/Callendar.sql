
/* Drop Tables 

DROP TABLE CALLENDAR CASCADE CONSTRAINTS;

*/


/* Create Tables */

CREATE TABLE CALLENDAR
(
	NO number NOT NULL,
	TITLE nvarchar2(100) NOT NULL,
	START_ date NOT NULL,
	END_ date DEFAULT SYSDATE,
	ALRAM char(1) NOT NULL,
	PRIMARY KEY (NO)
);



CREATE SEQUENCE SEQ_CALLENDAR
NOCACHE
NOCYCLE;