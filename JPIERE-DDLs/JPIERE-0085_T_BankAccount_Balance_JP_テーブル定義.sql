CREATE TABLE adempiere.T_BankAccount_Balance_JP ( 
	 AD_PInstance_ID		numeric(10,0) NOT NULL	--インスタンス
	,AD_CLIENT_ID			numeric(10,0) NOT NULL	--クライアント
	,AD_Org_ID				numeric(10,0) NOT NULL	--組織
	,C_ACCTSCHEMA_ID 		numeric(10,0) NOT NULL	--会計スキーマ
	,DATEACCT				timestamp without time zone			NOT NULL	--転記日付
	,C_CURRENCY_ID			numeric(10,0) NOT NULL	--アカウント通貨
	,Fact_Acct_C_Currency_ID numeric(10,0) NOT NULL --会計通貨
	,ACCOUNT_ID				numeric(10,0) NOT NULL	--勘定科目
	,C_BANK_ID				numeric(10,0) 
	,C_BANKACCOUNT_ID		numeric(10,0) 
	,BANKACCOUNTTYPE		character(1)
	,ACCOUNTNO				character varying(40) DEFAULT NULL::character varying
	,DESCRIPTION			character varying(500) DEFAULT NULL::character varying
	,AMTACCTBALANCE			numeric DEFAULT (0)::numeric
	,AMTSOURCEBALANCE		numeric DEFAULT (0)::numeric
) 

