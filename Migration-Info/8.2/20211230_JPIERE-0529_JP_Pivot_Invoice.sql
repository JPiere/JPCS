CREATE OR REPLACE VIEW adempiere.JP_Pivot_Invoice
 AS
SELECT
o.C_Invoice_ID AS C_Invoice_ID
,o.C_Order_ID AS C_Order_ID
,odr.DocumentNo AS JP_Order_DocumentNo
,o.JP_Contract_ID AS JP_Contract_ID
,cnt.DocumentNo AS JP_Contract_DocumentNo
,cnt.JP_ContractCategory_ID AS JP_ContractCategory_ID
,cntc.Value || '_' ||   cntc.Name AS JP_ContractCategory_VN
,o.JP_ContractContent_ID AS JP_ContractContent_ID
,cnt.DocumentNo AS JP_ContractContent_DocumentNo
,o.JP_ContractProcPeriod_ID AS JP_CPP_header_ID
,cpp.Name AS JP_CPP_header_Name
,o.AD_Client_ID AS AD_Client_ID
,o.AD_OrgTrx_ID AS AD_OrgTrx_ID
,otrx.Value || '_' ||   otrx.Name AS JP_OrgTrx_VN
,o.AD_Org_ID AS AD_Org_ID
,org.Value || '_' ||   org.Name AS JP_Org_VN
,o.C_DocTypeTarget_ID AS C_DocType_ID
,dt.Name AS JP_DocType_Name
,dt.DocBaseType AS DocBaseType
,dt.GL_Category_ID AS GL_Category_ID
,glc.Name AS GL_Category_Name
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
,o.M_PriceList_ID AS M_PriceList_ID
,pl.Name AS JP_PriceList_Name
,o.C_Currency_ID AS C_Currency_ID
,cy.ISO_Code AS ISO_Code
,o.SalesRep_ID AS SalesRep_ID
,usr.Name AS JP_SalesRep_Name
,o.C_PaymentTerm_ID AS C_PaymentTerm_ID
,pt.Value  || '_' ||  pt.Name AS JP_PaymentTerm_VN
,o.DocumentNo AS DocumentNo
,o.DateOrdered AS DateOrdered
,to_char(o.DateOrdered, 'YYYY-MM') AS JP_OrderedMonth
,o.DateInvoiced AS DateInvoiced
,to_char(o.DateInvoiced, 'YYYY-MM') AS JP_InvoicedMonth
,o.DateAcct AS DateAcct
,to_char(o.DateAcct, 'YYYY-MM') AS JP_AcctMonth
,o.IsSOTrx AS IsSOTrx
,o.DocStatus AS DocStatus
,o.Processed AS Processed
,o.IsActive AS IsActive

,ol.C_InvoiceLine_ID AS C_InvoiceLine_ID 
,ol.Line AS Line
,ol.M_Product_ID AS M_Product_ID
,p.Value || '_' ||  p.Name AS JP_Product_VN
,pc.M_Product_Category_ID AS M_Product_Category_ID
,pc.Value || '_' ||  pc.Name AS JP_Product_Category_VN

,ol.C_Charge_ID AS C_Charge_ID
,ch.Name As JP_Charge_Name

,ol.C_Tax_ID AS C_Tax_ID
,tax.Name AS JP_Tax_Name
,tax.C_TaxCategory_ID AS C_TaxCategory_ID
,taxc.Name AS JP_TaxCategory_Name

,ol.C_Activity_ID AS C_Activity_ID
,act.Value || '_' ||   act.Name AS JP_Activity_VN
,ol.C_Campaign_ID AS C_Campaign_ID
,cmp.Value || '_' ||  cmp.Name AS JP_Campaign_VN
,ol.C_Project_ID AS C_Project_ID
,pj.Value || '_' ||  pj.Name AS JP_Project_VN

,CASE
    WHEN dt.DocBaseType='ARC'::text THEN ol.QtyInvoiced * '-1'::integer::numeric
    WHEN dt.DocBaseType='APC'::text THEN ol.QtyInvoiced * '-1'::integer::numeric
    ELSE ol.QtyInvoiced END AS QtyInvoiced

,CASE
    WHEN dt.DocBaseType='ARC'::text THEN ol.PriceActual * '-1'::integer::numeric
    WHEN dt.DocBaseType='APC'::text THEN ol.PriceActual * '-1'::integer::numeric
    ELSE ol.PriceActual END AS PriceActual 
    
,CASE
    WHEN dt.DocBaseType='ARC'::text THEN ol.lineNetAmt * '-1'::integer::numeric
    WHEN dt.DocBaseType='APC'::text THEN ol.lineNetAmt * '-1'::integer::numeric
    ELSE ol.lineNetAmt END AS lineNetAmt 
    
,CASE
    WHEN dt.DocBaseType='ARC'::text THEN ol.JP_TaxBaseAmt * '-1'::integer::numeric
    WHEN dt.DocBaseType='APC'::text THEN ol.JP_TaxBaseAmt * '-1'::integer::numeric
    ELSE ol.JP_TaxBaseAmt END AS JP_TaxBaseAmt
    
,CASE
    WHEN dt.DocBaseType='ARC'::text THEN ol.JP_TaxAmt * '-1'::integer::numeric
    WHEN dt.DocBaseType='APC'::text THEN ol.JP_TaxAmt * '-1'::integer::numeric
    ELSE ol.JP_TaxAmt END  AS JP_TaxAmt
 
,ol.JP_ContractProcPeriod_ID AS JP_CPP_Line_ID
,cppl.Name AS JP_CPP_Line_Name
,cc.JP_Contract_Acct_ID AS JP_Contract_Acct_ID
,ca.Value || '_' ||   ca.Name AS JP_Contract_Acct_VN

FROM adempiere.C_Invoice o
	LEFT OUTER JOIN adempiere.AD_Org otrx ON (o.AD_OrgTrx_ID = otrx.AD_Org_ID)
	INNER JOIN adempiere.AD_Org org ON (o.AD_Org_ID = org.AD_Org_ID)
		INNER JOIN adempiere.AD_OrgInfo oif ON (org.AD_Org_ID = oif.AD_Org_ID)
 			LEFT OUTER JOIN adempiere.JP_Corporation ocrp ON (oif.JP_Corporation_ID = ocrp.JP_Corporation_ID)
 			LEFT OUTER JOIN adempiere.JP_BusinessUnit bu ON (oif.JP_BusinessUnit_ID = bu.JP_BusinessUnit_ID)
	INNER JOIN adempiere.C_DocType dt ON (o.C_DocTypeTarget_ID = dt.C_DocType_ID)
		INNER JOIN adempiere.GL_Category glc ON (dt.GL_Category_ID = glc.GL_Category_ID)
	INNER JOIN adempiere.C_BPartner bp ON (o.C_BPartner_ID = bp.C_BPartner_ID)
		LEFT OUTER JOIN adempiere.C_BP_Group bpg ON (bp.C_BP_Group_ID = bpg.C_BP_Group_ID)
		LEFT OUTER JOIN adempiere.JP_Corporation crp ON (bp.JP_Corporation_ID = crp.JP_Corporation_ID)
	INNER JOIN adempiere.M_PriceList pl ON (o.M_PriceList_ID = pl.M_PriceList_ID)
	INNER JOIN adempiere.C_Currency cy ON (o.C_Currency_ID = cy.C_Currency_ID)
	INNER JOIN adempiere.AD_User usr ON (o.SalesRep_ID = usr.AD_User_ID)
	LEFT OUTER JOIN adempiere.C_PaymentTerm pt ON (o.C_PaymentTerm_ID = pt.C_PaymentTerm_ID)
	LEFT OUTER JOIN adempiere.C_Order odr ON (o.C_Order_ID = odr.C_Order_ID)
	LEFT OUTER JOIN adempiere.JP_Contract cnt ON (o.JP_Contract_ID = cnt.JP_Contract_ID)
		LEFT OUTER JOIN adempiere.JP_ContractCategory cntc ON (cnt.JP_ContractCategory_ID = cntc.JP_ContractCategory_ID)
	LEFT OUTER JOIN adempiere.JP_ContractContent cc ON (o.JP_ContractContent_ID = cc.JP_ContractContent_ID)
		LEFT OUTER JOIN adempiere.JP_Contract_Acct ca ON (cc.JP_Contract_Acct_ID = ca.JP_Contract_Acct_ID)
	LEFT OUTER JOIN adempiere.JP_ContractProcPeriod cpp ON (o.JP_ContractProcPeriod_ID = cpp.JP_ContractProcPeriod_ID)
		
INNER JOIN adempiere.C_InvoiceLine ol ON (o.C_Invoice_ID = ol.C_Invoice_ID)
	LEFT OUTER JOIN adempiere.M_Product p ON (ol.M_Product_ID = p.M_Product_ID)
		LEFT OUTER JOIN adempiere.M_Product_Category pc ON (p.M_Product_Category_ID = pc.M_Product_Category_ID)
	LEFT OUTER JOIN adempiere.C_Charge ch ON (ol.C_Charge_ID = ch.C_Charge_ID)
	LEFT OUTER JOIN adempiere.C_Activity act ON (ol.C_Activity_ID = act.C_Activity_ID)
	LEFT OUTER JOIN adempiere.C_Campaign cmp ON (ol.C_Campaign_ID = cmp.C_Campaign_ID)
	LEFT OUTER JOIN adempiere.C_Project pj ON (ol.C_Project_ID = pj.C_Project_ID)
	INNER JOIN adempiere.C_Tax tax ON (ol.C_Tax_ID = tax.C_Tax_ID)
		INNER JOIN adempiere.C_TaxCategory taxc ON (tax.C_TaxCategory_ID = taxc.C_TaxCategory_ID)
	LEFT OUTER JOIN adempiere.JP_ContractLine ccl ON (ol.JP_ContractLine_ID = ccl.JP_ContractLine_ID)
	LEFT OUTER JOIN adempiere.JP_ContractProcPeriod cppl ON (ol.JP_ContractProcPeriod_ID = cppl.JP_ContractProcPeriod_ID)

;

ALTER TABLE adempiere.JP_Pivot_Invoice
    OWNER TO adempiere;