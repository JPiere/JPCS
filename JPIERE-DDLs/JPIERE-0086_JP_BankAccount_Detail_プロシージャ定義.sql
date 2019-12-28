/******************************************************************************
 * Product: JPiere(ジェイピエール) - JPiere Configurations         	              *
 * Copyright (C) Hideaki Hagiwara All Rights Reserved.                        *
 * このプログラムはGNU Gneral Public Licens Version2のもと公開しています。		      *
 * このプログラムは自由に活用してもらう事を期待して公開していますが、			      *
 * いかなる保証もしていません。                                               	      *
 * 著作権は萩原秀明(h.hagiwara@oss-erp.co.jp)が保持し、サポートサービスは		      *
 * 株式会社オープンソース・イーアールピー・ソリューションズで                 		      *
 * 提供しています。サポートをご希望の際には、                                 	      *
 * 株式会社オープンソース・イーアールピー・ソリューションズまでご連絡下さい。 			      *
 * http://www.oss-erp.co.jp/                                                  *
 *****************************************************************************/
 
CREATE OR REPLACE FUNCTION adempiere.JP_BankAccount_Detail(INTEGER) RETURNS INTEGER AS '
DECLARE
	PInstance_ID ALIAS FOR $1;
	
	Cur_Parameter CURSOR (PInstance INTEGER) IS
		SELECT i.AD_CLIENT_ID,i.Record_ID, p.ParameterName, p.P_String, p.P_Number, p.P_Date,p.P_Date_TO
		FROM AD_PInstance i
			INNER JOIN AD_PInstance_Para p ON(i.AD_PInstance_ID=p.AD_PInstance_ID)
		WHERE i.AD_PInstance_ID=PInstance
		ORDER BY p.SeqNo;

	ResultStr	character varying(2000);
	Message		character varying(2000);
	Statement	TEXT;
	Statement2	TEXT;
		
	P_AD_CLIENT_ID		adempiere.T_BankAccount_Detail_JP.AD_CLIENT_ID%TYPE;				
	P_C_ACCTSCHEMA_ID 	adempiere.T_BankAccount_Detail_JP.C_ACCTSCHEMA_ID%TYPE;						
	P_DATEACCT 		adempiere.T_BankAccount_Detail_JP.DATEACCT%TYPE;
	P_DATEACCT_TO 		adempiere.T_BankAccount_Detail_JP.DATEACCT%TYPE;			
	P_C_BANKACCOUNT_ID	adempiere.T_BankAccount_Detail_JP.C_BANKACCOUNT_ID%TYPE;

	
BEGIN
	FOR p IN Cur_Parameter (PInstance_ID) LOOP
			P_AD_CLIENT_ID := p.AD_Client_ID;
		IF (p.ParameterName = ''C_AcctSchema_ID'') 	--必須
 			THEN P_C_ACCTSCHEMA_ID := p.P_NUMBER;
		ELSIF (p.ParameterName = ''DateAcct'')		--必須
			THEN P_DATEACCT := p.P_DATE;
			     P_DATEACCT_TO := p.P_DATE_TO;
		ELSIF (p.ParameterName = ''C_BankAccount_ID'')	--必須
 			THEN P_C_BANKACCOUNT_ID := p.P_NUMBER;
	 	END IF;
	END LOOP;

	/*繰越残高計算*/
	Statement := ''INSERT INTO adempiere.T_BankAccount_Detail_JP
			(	 
				 AD_PInstance_ID
				,AD_CLIENT_ID
				,C_ACCTSCHEMA_ID
				,DATEACCT
				,AD_Org_ID
				,C_CURRENCY_ID
				,Fact_Acct_C_Currency_ID
				,ACCOUNT_ID
				,C_BANK_ID
				,C_BANKACCOUNT_ID		
				,BANKACCOUNTTYPE
				,DESCRIPTION
				,AMTACCTBALANCE
				,AMTSOURCEBALANCE
				,Line
				,C_BankStatement_ID
				,C_BankstatementLine_ID
			)
			SELECT ''
			      || PInstance_ID || 
			'','' || P_AD_CLIENT_ID ||
			'','' || P_C_ACCTSCHEMA_ID ||
			'','' || quote_literal(P_DATEACCT) ||
			'',	 f.AD_Org_ID
			  ,	 ba.C_Currency_ID
			  ,      f.C_Currency_ID 
			  ,	 f.Account_ID	
			  ,	 ba.C_BANK_ID AS C_BANK_ID
			  ,	 ba.C_BANKACCOUNT_ID 
			  ,	 ba.BANKACCOUNTTYPE ''
			'','' || quote_literal(''繰越残高'') ||
			'',	 sum(f.AMTACCTDR)-sum(f.AMTACCTCR)
			  ,	 sum(f.AMTSOURCEDR)-sum(f.AMTSOURCECR) 
			  ,	 0 
			  ,	 0
			  ,	 0'' ||
			'' FROM adempiere.FACT_ACCT f  
				INNER JOIN C_ELEMENTVALUE e ON(f.ACCOUNT_ID=e.C_ELEMENTVALUE_ID AND e.ISBANKACCOUNT='' || quote_literal(''Y'') || '')'' ||
			''	INNER JOIN C_BANKACCOUNT ba ON(e.C_BANKACCOUNT_ID=ba.C_BANKACCOUNT_ID AND ba.ISACTIVE='' || quote_literal(''Y'') || '')'' ||
			'' WHERE f.C_ACCTSCHEMA_ID='' || P_C_ACCTSCHEMA_ID ||
			''	AND f.POSTINGTYPE='' || quote_literal(''A'') ||
			''	AND f.DATEACCT   < '' || quote_literal(P_DATEACCT) ||
			''	AND ba.C_BANKACCOUNT_ID= '' || P_C_BANKACCOUNT_ID ||
			'' GROUP BY
				 f.AD_CLIENT_ID
				,f.C_ACCTSCHEMA_ID
				,f.AD_Org_ID
				,f.C_CURRENCY_ID
				,f.ACCOUNT_ID
				,ba.C_BANK_ID
				,ba.C_BANKACCOUNT_ID
				,ba.BANKACCOUNTTYPE
				,ba.DESCRIPTION ''
			;		

       EXECUTE Statement;

	/*明細データ作成*/
       Statement2 := ''INSERT INTO adempiere.T_BankAccount_Detail_JP
			(	 
				 AD_PInstance_ID
				,AD_CLIENT_ID
				,C_ACCTSCHEMA_ID
				,DATEACCT
				,AD_Org_ID
				,C_CURRENCY_ID
				,Fact_Acct_C_Currency_ID
				,C_BANKACCOUNT_ID		
				,DESCRIPTION
				,AMTACCTBALANCE
				,AMTSOURCEBALANCE
				,Line
				,C_BankStatement_ID
				,C_BankstatementLine_ID
				,StmtAmt
				,TrxAmt
				,ChargeAmt
				,InterestAmt
				,C_Charge_ID
				,C_Payment_ID
				,C_Invoice_ID
				,C_BPartner_ID
			)			
			SELECT ''
			      || PInstance_ID || 
			'','' || P_AD_CLIENT_ID ||
			'','' || P_C_ACCTSCHEMA_ID ||
			'',      bs.DateAcct
			  ,	 bs.AD_Org_ID
			  ,      bsl.C_Currency_ID 
			  ,	 bsl.C_Currency_ID 
			  ,	 bs.C_BANKACCOUNT_ID 
			  ,	 bsl.DESCRIPTION
			  ,	 0 --仕訳の通貨とアカウントの通貨が異なる可能性があるので0を代入し計算しない。
			  ,	 bsl.StmtAmt
			  ,	 bsl.Line
			  , 	 bsl.C_BankStatement_ID
			  ,	 bsl.C_BankstatementLine_ID
			  ,	 bsl.StmtAmt
			  ,	 bsl.TrxAmt
			  ,	 bsl.ChargeAmt
			  ,	 bsl.InterestAmt
			  ,	 bsl.C_Charge_ID
			  ,	 bsl.C_Payment_ID
			  ,	 bsl.C_Invoice_ID
			  ,	 bsl.C_BPartner_ID '' ||
			'' FROM adempiere.C_BankStatement bs  
				INNER JOIN C_BankStatementLine bsl ON(bs.C_BankStatement_ID=bsl.C_BankStatement_ID)'' ||
			'' WHERE bs.C_BANKACCOUNT_ID= '' || P_C_BANKACCOUNT_ID ||
			''	AND bs.DATEACCT   >= '' || quote_literal(P_DATEACCT) ||
			''	AND bs.DATEACCT   <= '' || quote_literal(P_DATEACCT_TO) ||
			''	AND bs.DocStatus in ('' || quote_literal(''CO'') || '','' || quote_literal(''CL'') || '')'' ||
			'' ORDER BY bs.DateAcct, bsl.C_BankStatement_ID,bsl.Line ''
			;		

		EXECUTE Statement2;

 RETURN 0;
END
' LANGUAGE 'plpgsql';