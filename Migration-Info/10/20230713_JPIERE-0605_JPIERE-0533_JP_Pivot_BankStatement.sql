CREATE OR REPLACE VIEW adempiere.JP_Pivot_BankStatement
 AS
SELECT
o.C_BankStatement_ID AS C_BankStatement_ID
,o.AD_Client_ID
,o.AD_Org_ID AS AD_Org_ID
,org.Value || '_' ||   org.Name AS JP_Org_VN
,oif.JP_Corporation_ID AS JP_Org_Corporation_ID
,ocrp.Value  || '_' ||  ocrp.Name AS JP_Org_Corporation_VN
,oif.JP_BusinessUnit_ID AS JP_BusinessUnit_ID
,bu.Value || '_' ||  bu.Name AS JP_BusinessUnit_VN
,o.C_BankAccount_ID AS C_BankAccount_ID
,bac.Name AS JP_BankAccount_Name
,bac.JP_BranchName AS JP_BranchName
,bac.BankAccountType AS BankAccountType
,o.StatementDate AS StatementDate
,bac.C_Bank_ID AS C_Bank_ID
,ba.Name AS JP_Bank_Name
,to_char(o.StatementDate, 'YYYY-MM') AS JP_StatementMonth
,o.DateAcct AS DateAcct
,to_char(o.DateAcct, 'YYYY-MM') AS JP_AcctMonth
,o.DocStatus AS DocStatus
,o.Processed AS Processed
,o.IsActive AS IsActive
,o.Name AS Name
,o.Description AS Description

,ol.C_BankStatementLine_ID AS C_BankStatementLine_ID 
,ol.Line AS Line
,ol.Description AS JP_Line_Description

,ol.C_Charge_ID AS C_Charge_ID
,ch.Name As JP_Charge_Name

,ol.C_Tax_ID AS C_Tax_ID
,tax.Name AS JP_Tax_Name
,tax.C_TaxCategory_ID AS C_TaxCategory_ID
,taxc.Name AS JP_TaxCategory_Name

,ol.C_BPartner_ID AS C_BPartner_ID
,bp.Value  || '_' ||   bp.Name AS JP_BPartner_VN
,bpg.C_BP_Group_ID AS C_BP_Group_ID
,bpg.Value || '_' ||  bpg.Name AS JP_BP_Group_VN
,bp.JP_Corporation_ID AS JP_Corporation_ID
,crp.Value  || '_' ||  crp.Name AS JP_Corporation_VN

,ol.C_Currency_ID AS C_Currency_ID
,cy.ISO_Code AS ISO_Code

,ol.C_Payment_ID AS C_Payment_ID 
,pay.DocumentNo AS JP_Payment_DocumentNo
,ol.C_Invoice_ID AS C_Invoice_ID 
,inv.DocumentNo AS JP_Invoice_DocumentNo

,ol.StmtAmt
,ol.TrxAmt
,ol.ChargeAmt
,ol.InterestAmt

,o.DocumentNo
,o.C_DocType_ID

FROM adempiere.C_BankStatement o
	INNER JOIN adempiere.AD_Org org ON (o.AD_Org_ID = org.AD_Org_ID)
		INNER JOIN adempiere.AD_OrgInfo oif ON (org.AD_Org_ID = oif.AD_Org_ID)
 			LEFT OUTER JOIN adempiere.JP_Corporation ocrp ON (oif.JP_Corporation_ID = ocrp.JP_Corporation_ID)
 			LEFT OUTER JOIN adempiere.JP_BusinessUnit bu ON (oif.JP_BusinessUnit_ID = bu.JP_BusinessUnit_ID)
	INNER JOIN  adempiere.C_BankAccount bac ON (o.C_BankAccount_ID = bac.C_BankAccount_ID)
	INNER JOIN  adempiere.C_Bank ba ON (bac.C_Bank_ID = ba.C_Bank_ID)
	
	INNER JOIN adempiere.C_BankStatementLine ol ON (o.C_BankStatement_ID = ol.C_BankStatement_ID)
	LEFT OUTER JOIN adempiere.C_Charge ch ON (ol.C_Charge_ID = ch.C_Charge_ID)
	INNER JOIN adempiere.C_Currency cy ON (ol.C_Currency_ID = cy.C_Currency_ID)
	LEFT OUTER JOIN adempiere.C_Tax tax ON (ol.C_Tax_ID = tax.C_Tax_ID)
		LEFT OUTER JOIN adempiere.C_TaxCategory taxc ON (tax.C_TaxCategory_ID = taxc.C_TaxCategory_ID)
	LEFT OUTER JOIN adempiere.C_BPartner bp ON (ol.C_BPartner_ID = bp.C_BPartner_ID)
		LEFT OUTER JOIN adempiere.C_BP_Group bpg ON (bp.C_BP_Group_ID = bpg.C_BP_Group_ID)
		LEFT OUTER JOIN adempiere.JP_Corporation crp ON (bp.JP_Corporation_ID = crp.JP_Corporation_ID)
	LEFT OUTER JOIN adempiere.C_Payment pay ON (ol.C_Payment_ID = pay.C_Payment_ID)
	LEFT OUTER JOIN adempiere.C_Invoice inv ON (ol.C_Invoice_ID = inv.C_Invoice_ID)
;

ALTER TABLE adempiere.JP_Pivot_BankStatement
    OWNER TO adempiere;