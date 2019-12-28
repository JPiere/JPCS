CREATE TABLE adempiere.T_BankAccount_Balance_JP ( 
	 AD_PInstance_ID		numeric(10,0) NOT NULL	--�C���X�^���X
	,AD_CLIENT_ID			numeric(10,0) NOT NULL	--�N���C�A���g
	,AD_Org_ID				numeric(10,0) NOT NULL	--�g�D
	,C_ACCTSCHEMA_ID 		numeric(10,0) NOT NULL	--��v�X�L�[�}
	,DATEACCT				timestamp without time zone			NOT NULL	--�]�L���t
	,C_CURRENCY_ID			numeric(10,0) NOT NULL	--�A�J�E���g�ʉ�
	,Fact_Acct_C_Currency_ID numeric(10,0) NOT NULL --��v�ʉ�
	,ACCOUNT_ID				numeric(10,0) NOT NULL	--����Ȗ�
	,C_BANK_ID				numeric(10,0) 
	,C_BANKACCOUNT_ID		numeric(10,0) 
	,BANKACCOUNTTYPE		character(1)
	,ACCOUNTNO				character varying(40) DEFAULT NULL::character varying
	,DESCRIPTION			character varying(500) DEFAULT NULL::character varying
	,AMTACCTBALANCE			numeric DEFAULT (0)::numeric
	,AMTSOURCEBALANCE		numeric DEFAULT (0)::numeric
) 

