
CREATE OR REPLACE VIEW adempiere.JP_PaymentSelection AS 
SELECT 
	ps.AD_Client_ID 		AS AD_Client_ID
	,ps.AD_Org_ID 			AS AD_Org_ID
	,ps.C_PaySelection_ID	AS C_PaySelection_ID
	,ps.Name				AS Name
	,ps.Description			AS Description	
	,ps.C_BankAccount_ID	AS C_BankAccount_ID
	,ps.PayDate				AS PayDate
	,ps.TotalAmt			AS TotalAmt
	,ps.Processed			AS Processed
	,ps.IsApproved			AS IsApproved
	,psl.C_PaySelectionLine_ID	AS C_PaySelectionLine_ID
	,psl.Line				AS Line
	,psl.Description		AS LineDescription
	,psl.PaymentRule		AS PaymentRulePO
	,psl.C_Invoice_ID		AS C_Invoice_ID
	,iv.C_BPartner_ID		AS C_Invoice_C_BPartner_ID
	,iv.IsPaid				AS IsPaid
	,psl.OpenAmt			AS OpenAmt
	,psl.PayAmt				AS PayAmt
	,psl.DiscountAmt		AS DiscountAmt
	,psl.DifferenceAmt		AS DifferenceAmt
	,psl.C_PaySelectionCheck_ID	AS C_PaySelectionCheck_ID
	,psc.C_BPartner_ID		AS C_BPartner_ID
	,psc.PaymentRule		AS PaymentRule
	,psc.Qty				AS Qty
	,psc.PayAmt				AS C_Payment_Payamt
	,psc.DiscountAmt		AS C_Payment_Discountamt
	,psc.DocumentNo			AS DocumentNo	
	,psc.C_Payment_ID		AS C_Payment_ID
	,psc.IsReceipt			AS IsReceipt
	,psc.IsPrinted			AS IsPrinted
	,ps.IsReceiptJP			AS IsReceiptJP
	,ba.C_Currency_ID		AS C_Currency_ID
	,ps.JP_DownloadNum  	AS JP_DownloadNum
    ,ps.JP_PaymentBatch_id 	AS JP_PaymentBatch_ID
    ,psl.JP_BP_BankAccount_ID AS JP_BP_BankAccount_ID
    ,psc.C_BP_BankAccount_ID AS C_BP_BankAccount_ID
    ,bpba.IsACH 			AS IsACH
    ,bpba.BPBankAcctUse 	AS BPBankAcctUse
    ,bpba.C_Bank_ID 		AS JP_BP_Bank_ID
    ,bpba.BankAccountType 	AS JP_BP_BankAccountType
    ,bpba.JP_BankTransferFeeDeduct_ID AS JP_BankTransferFeeDeduct_ID
    ,bpba.JP_A_Name_Kana 	AS JP_A_Name_Kana
    ,bpba.JP_BranchCode 	AS JP_BranchCode
    ,bpba.JP_BranchName_Kana AS JP_BranchName_Kana
    ,bpba.AccountNo 		AS JP_BP_AccountNo
    ,psl.IsAutoCalBankTransferfeeJP AS IsAutoCalBankTransferfeeJP
FROM adempiere.C_PaySelection ps
    INNER JOIN adempiere.C_BankAccount ba on (ba.C_BankAccount_ID = ps.C_BankAccount_ID)
	INNER JOIN adempiere.C_PaySelectionLine psl on (ps.C_PaySelection_ID=psl.C_PaySelection_ID)
		INNER JOIN adempiere.C_Invoice iv on(psl.C_Invoice_ID=iv.C_Invoice_ID)
		LEFT OUTER JOIN adempiere.C_PaySelectionCheck psc on(psl.C_PaySelectionCheck_ID=psc.C_PaySelectionCheck_ID)
		LEFT OUTER JOIN adempiere.C_BP_BankAccount bpba ON (psc.C_BP_BankAccount_ID = bpba.C_BP_BankAccount_ID)
		