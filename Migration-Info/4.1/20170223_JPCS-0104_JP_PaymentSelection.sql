
CREATE OR REPLACE VIEW adempiere.JP_PaymentSelection AS 
SELECT 
	ps.AD_Client_ID 		AS AD_Client_ID
	,ps.AD_Org_ID 			AS AD_Org_ID
	,ps.C_PaySelection_ID		AS C_PaySelection_ID
	,ps.Name			AS Name
	,ps.Description			AS Description	
	,ps.C_BankAccount_ID		AS C_BankAccount_ID
	,ps.PayDate			AS PayDate
	,ps.TotalAmt			AS TotalAmt
	,ps.Processed			AS Processed
	,ps.IsApproved			AS IsApproved
	,psl.C_PaySelectionLine_ID	AS C_PaySelectionLine_ID
	,psl.Line			AS Line
	,psl.Description		AS LineDescription
	,psl.PaymentRule		AS PaymentRulePO
	,psl.C_Invoice_ID		AS C_Invoice_ID
	,iv.C_BPartner_ID		AS C_Invoice_C_BPartner_ID
	,iv.IsPaid			AS IsPaid
	,psl.OpenAmt			AS OpenAmt
	,psl.PayAmt			AS PayAmt
	,psl.DiscountAmt		AS DiscountAmt
	,psl.DifferenceAmt		AS DifferenceAmt
	,psl.C_PaySelectionCheck_ID	AS C_PaySelectionCheck_ID
	,psc.C_BPartner_ID		AS C_BPartner_ID
	,psc.PaymentRule		AS PaymentRule
	,psc.Qty			AS Qty
	,psc.PayAmt			AS c_payment_payamt
	,psc.DiscountAmt		AS c_payment_discountamt
	,psc.DocumentNo			AS DocumentNo	
	,psc.C_Payment_ID		AS C_Payment_ID
	,psc.IsReceipt			AS IsReceipt
	,psc.IsPrinted			AS IsPrinted
	,ps.IsReceiptJP			AS IsReceiptJP
	,ba.C_Currency_ID	AS C_Currency_ID
	,ps.jp_downloadnum  AS jp_downloadnum
    ,ps.jp_paymentbatch_id AS jp_paymentbatch_id
FROM adempiere.C_PaySelection ps
    INNER JOIN adempiere.C_BankAccount ba on (ba.C_BankAccount_ID = ps.C_BankAccount_ID)
	INNER JOIN adempiere.C_PaySelectionLine psl on (ps.C_PaySelection_ID=psl.C_PaySelection_ID)
		INNER JOIN adempiere.C_Invoice iv on(psl.C_Invoice_ID=iv.C_Invoice_ID)
		LEFT OUTER JOIN adempiere.C_PaySelectionCheck psc on(psl.C_PaySelectionCheck_ID=psc.C_PaySelectionCheck_ID)