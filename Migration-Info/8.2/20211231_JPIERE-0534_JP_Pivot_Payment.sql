CREATE OR REPLACE VIEW adempiere.JP_Pivot_Payment
 AS
SELECT
o.C_Payment_ID AS C_Payment_ID
,o.AD_Client_ID
,o.AD_OrgTrx_ID AS AD_OrgTrx_ID
,otrx.Value || '_' ||   otrx.Name AS JP_OrgTrx_VN
,o.AD_Org_ID AS AD_Org_ID
,org.Value || '_' ||   org.Name AS JP_Org_VN
,o.C_DocType_ID AS C_DocType_ID
,dt.Name AS JP_DocType_Name
,oif.JP_Corporation_ID AS JP_Org_Corporation_ID
,ocrp.Value  || '_' ||  ocrp.Name AS JP_Org_Corporation_VN
,oif.JP_BusinessUnit_ID AS JP_BusinessUnit_ID
,bu.Value || '_' ||  bu.Name AS JP_BusinessUnit_VN
,o.C_BPartner_ID AS C_BPartner_ID
,bp.Value  || '_' ||   bp.Name AS JP_BPartner_VN
,bpg.C_BP_Group_ID AS C_BP_Group_ID
,bpg.Value || '_' ||  bpg.Name AS JP_BP_Group_VN
,bp.JP_Corporation_ID AS JP_Corporation_ID
,crp.Value  || '_' ||  crp.Name AS JP_Corporation_VN
,o.C_Currency_ID AS C_Currency_ID
,cy.ISO_Code AS ISO_Code

,o.C_BankAccount_ID AS C_BankAccount_ID
,bac.Name AS JP_BankAccount_Name
,bac.JP_BranchName AS JP_BranchName
,bac.BankAccountType AS BankAccountType
,bac.C_Bank_ID AS C_Bank_ID
,ba.Name AS JP_Bank_Name

,o.DocumentNo AS DocumentNo
,o.DateTrx AS DateTrx
,to_char(o.DateTrx, 'YYYY-MM') AS JP_TrxMonth
,o.DateAcct AS DateAcct
,to_char(o.DateAcct, 'YYYY-MM') AS JP_AcctMonth
,o.IsReceipt AS IsReceipt
,o.DocStatus AS DocStatus
,o.Processed AS Processed
,o.IsActive AS IsActive
,o.Description AS Description

,o.C_Charge_ID AS C_Charge_ID
,ch.Name As JP_Charge_Name

,o.TenderType AS TenderType
,o.IsPrepayment AS IsPrepayment
,o.IsReconciled AS IsReconciled
,o.IsAllocated AS IsAllocated

,o.C_PaymentBatch_ID AS C_PaymentBatch_ID
,pb.DocumentNo AS JP_PaymentBatch_DocumentNo
,o.C_DepositBatch_ID AS C_DepositBatch_ID
,db.DocumentNo AS JP_DepositBatch_DocumentNo
,o.JP_Bill_ID AS JP_Bill_ID
,bill.DocumentNo AS JP_Bill_DocumentNo
,o.C_Order_ID AS C_Order_ID
,odr.DocumentNo AS JP_Order_DocumentNo
,o.C_Invoice_ID AS C_Invoice_ID
,inv.DocumentNo AS JP_Invoice_DocumentNo

,o.C_Activity_ID AS C_Activity_ID
,act.Value || '_' ||   act.Name AS JP_Activity_VN
,o.C_Campaign_ID AS C_Campaign_ID
,cmp.Value || '_' ||  cmp.Name AS JP_Campaign_VN
,o.C_Project_ID AS C_Project_ID
,pj.Value || '_' ||  pj.Name AS JP_Project_VN

,o.PayAmt AS PayAmt 
,o.DiscountAmt AS DiscountAmt
,o.writeOffAmt AS writeOffAmt


FROM adempiere.C_Payment o
	LEFT OUTER JOIN adempiere.AD_Org otrx ON (o.AD_OrgTrx_ID = otrx.AD_Org_ID)
	INNER JOIN adempiere.AD_Org org ON (o.AD_Org_ID = org.AD_Org_ID)
		INNER JOIN adempiere.AD_OrgInfo oif ON (org.AD_Org_ID = oif.AD_Org_ID)
 			LEFT OUTER JOIN adempiere.JP_Corporation ocrp ON (oif.JP_Corporation_ID = ocrp.JP_Corporation_ID)
 			LEFT OUTER JOIN adempiere.JP_BusinessUnit bu ON (oif.JP_BusinessUnit_ID = bu.JP_BusinessUnit_ID)
	INNER JOIN adempiere.C_DocType dt ON (o.C_DocType_ID = dt.C_DocType_ID)
	INNER JOIN adempiere.C_BPartner bp ON (o.C_BPartner_ID = bp.C_BPartner_ID)
		LEFT OUTER JOIN adempiere.C_BP_Group bpg ON (bp.C_BP_Group_ID = bpg.C_BP_Group_ID)
		LEFT OUTER JOIN adempiere.JP_Corporation crp ON (bp.JP_Corporation_ID = crp.JP_Corporation_ID)
	INNER JOIN adempiere.C_Currency cy ON (o.C_Currency_ID = cy.C_Currency_ID)
	INNER JOIN  adempiere.C_BankAccount bac ON (o.C_BankAccount_ID = bac.C_BankAccount_ID)
		INNER JOIN  adempiere.C_Bank ba ON (bac.C_Bank_ID = ba.C_Bank_ID)
	LEFT OUTER JOIN adempiere.C_PaymentBatch pb ON (o.C_PaymentBatch_ID = pb.C_PaymentBatch_ID)
	LEFT OUTER JOIN adempiere.C_DepositBatch db ON (o.C_DepositBatch_ID = db.C_DepositBatch_ID)
	LEFT OUTER JOIN adempiere.JP_Bill bill ON (o.JP_Bill_ID = bill.JP_Bill_ID)
	LEFT OUTER JOIN adempiere.C_Order odr ON (o.C_Order_ID = odr.C_Order_ID)
	LEFT OUTER JOIN adempiere.C_Invoice inv ON (o.C_Invoice_ID = inv.C_Invoice_ID)
	LEFT OUTER JOIN adempiere.C_Activity act ON (o.C_Activity_ID = act.C_Activity_ID)
	LEFT OUTER JOIN adempiere.C_Campaign cmp ON (o.C_Campaign_ID = cmp.C_Campaign_ID)
	LEFT OUTER JOIN adempiere.C_Project pj ON (o.C_Project_ID = pj.C_Project_ID)
	LEFT OUTER JOIN adempiere.C_Charge ch ON (o.C_Charge_ID = ch.C_Charge_ID)
;

ALTER TABLE adempiere.JP_Pivot_Payment
    OWNER TO adempiere;