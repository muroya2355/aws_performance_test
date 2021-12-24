--  顧客コードの生成用シーケンス  --
CREATE SEQUENCE CUSTOMER_CODE_SEQ
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 99999999
    START WITH 1
    NO CYCLE 
;

--  初期データ登録用のプロシージャを生成する。  --
CREATE OR REPLACE FUNCTION C_CUSTOMER(
    --  顧客テーブルへの登録データ  --
    IN customerName VARCHAR,
    IN customerKana VARCHAR,
    IN customerPass VARCHAR,
    IN customerBirth DATE,
    IN customerJob VARCHAR,
    IN customerMail VARCHAR,
    IN customerTel VARCHAR,
    IN customerPost VARCHAR,
    IN customerAdd VARCHAR)
RETURNS 
     CHAR(8) AS $$
DECLARE
     customerCode CHAR(8);
BEGIN

     --  顧客コードシーケンスから顧客コードを取得  --
    SELECT
        TO_CHAR(nextval('CUSTOMER_CODE_SEQ'), 'FM09999999') INTO customerCode;
    --FROM
      --DUAL ;
      
    --  顧客情報の登録  --
    INSERT INTO CUSTOMER(
      CUSTOMER_CODE,
      CUSTOMER_NAME,
      CUSTOMER_KANA,
      CUSTOMER_PASS,
      CUSTOMER_BIRTH,
      CUSTOMER_JOB,
      CUSTOMER_MAIL,
      CUSTOMER_TEL,
      CUSTOMER_POST,
      CUSTOMER_ADD
    ) VALUES (
      customerCode,
      customerName,
      customerKana,
      customerPass,
      customerBirth,
      customerJob,
      customerMail,
      customerTel,
      customerPost,
      customerAdd
    );
    RETURN customerCode;
END;
$$ LANGUAGE plpgsql;

CREATE or REPLACE PROCEDURE PROC1 ()
AS $$
DECLARE
  i INT; 
BEGIN
  DELETE FROM RESERVE;
  DELETE FROM CUSTOMER;
  ALTER SEQUENCE CUSTOMER_CODE_SEQ RESTART WITH 1 INCREMENT BY 1;
  i := 1;
  FOR i IN 1..1000000 LOOP
    PERFORM C_CUSTOMER('試験　太郎', 'シケン　タロウ', '{pbkdf2}34036dc513d126f31515bc6401347a33bc495df1b27b9b39c5770798caa96594616716943f2f33e4', '1975/01/05', 'プログラマ', 'tarou@example.com', '123-1234-1234', '111-1111', '東京都江東区豊洲');
  END LOOP;
END;
$$
LANGUAGE plpgsql;

CALL PROC1();

--  初期データ登録用のプロシージャを削除する。  --
DROP FUNCTION C_CUSTOMER(VARCHAR,VARCHAR,VARCHAR,DATE,VARCHAR,VARCHAR,VARCHAR,VARCHAR,VARCHAR);

