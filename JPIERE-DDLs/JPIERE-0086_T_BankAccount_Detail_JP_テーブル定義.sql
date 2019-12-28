CREATE TABLE adempiere.T_BankAccount_Detail_JP ( 
	 AD_PInstance_ID		numeric(10,0) NOT NULL	--�C���X�^���X
	,AD_CLIENT_ID			numeric(10,0) NOT NULL	--�N���C�A���g
	,AD_Org_ID				numeric(10,0) NOT NULL	--�g�D
	,C_ACCTSCHEMA_ID 		numeric(10,0) NOT NULL	--��v�X�L�[�}
	,DATEACCT				timestamp without time zone			NOT NULL	--�]�L���t
	,C_CURRENCY_ID			numeric(10,0) NOT NULL	--�ʉ�
	,Fact_Acct_C_Currency_ID numeric(10,0) NOT NULL
	,ACCOUNT_ID				numeric(10,0)
	,C_BANK_ID				numeric(10,0) 
	,C_BANKACCOUNT_ID		numeric(10,0)  NOT NULL	--�A�J�E���g
	,BANKACCOUNTTYPE		character(1)
	,DESCRIPTION			character varying(500) DEFAULT NULL::character varying
	,line numeric(10,0) 	NOT NULL
	,AMTACCTBALANCE			numeric NOT NULL DEFAULT 0
	,AMTSOURCEBALANCE		numeric NOT NULL DEFAULT 0
	,C_BankStatement_ID 	numeric(10,0)
	,C_BankstatementLine_ID numeric(10,0)
	,StmtAmt 				numeric NOT NULL DEFAULT 0
	,TrxAmt 				numeric NOT NULL DEFAULT 0
  	,ChargeAmt 				numeric NOT NULL DEFAULT 0
  	,InterestAmt 			numeric NOT NULL DEFAULT 0
  	,C_Charge_ID 			numeric(10,0)
  	,C_Payment_ID 			numeric(10,0)
  	,C_Invoice_ID 			numeric(10,0)
  	,C_BPartner_ID 			numeric(10,0)
) 

