DROP VIEW adempiere.JP_RV_Bill_Line;
CREATE OR REPLACE VIEW adempiere.JP_RV_Bill_Line AS 
SELECT 
	bill.JP_Bill_ID
	,bill.AD_Client_ID
	,bill.AD_Org_ID
	,iv.DocumentNo
	,bill.C_DocType_ID
	,dt.DocBaseType
	,bill.dateInvoiced
	,bill.dateAcct
	,bill.C_BPartner_ID
	,bill.M_PriceList_ID
	,pl.IsTaxIncluded
	,bill.TotalLines
	,bill.GrandTotal
	,bill.TaxBaseAmt
	,bill.TaxAmt
	,bill.PayAmt
	,bill.OpenAmt
	,bill.C_Currency_ID

	,il.C_Invoice_ID
	,il.C_InvoiceLine_ID
	,iv.DocumentNo AS JP_Invoice_DocumentNo
	,il.Line	   AS JP_Invoice_Line
	,iv.DocumentNo || ' - ' || il.Line AS JP_InvoiceDocumentNoLine
	,il.M_InOutLine_ID 
	,io.DocumentNo AS JP_InOut_DocumentNo
	,iol.Line		AS  JP_InOut_Line
	,io.DocumentNo || ' - ' || iol.Line AS JP_InOutDocumentNoLine
	,il.C_OrderLIne_ID
	,o.DocumentNo AS JP_Order_DocumentNo
	,ol.Line	AS JP_Order_Line
	,o.DocumentNo || ' - ' || ol.Line AS JP_OrderDocumentNoLine
	,o.POReference
	,il.Line
	,il.M_Product_ID
	,il.C_Charge_ID
	,CASE WHEN il.M_Product_ID > 0 THEN p.Value ELSE '' END AS ProductValue
	,CASE WHEN il.M_Product_ID > 0 THEN p.Name ELSE c.Name END AS ProductName
	,CASE WHEN il.M_Product_ID > 0 THEN p.Value || ':' || p.Name ELSE c.Name END AS ProductValueName
	,il.QtyEntered
	,il.QtyInvoiced
	,il.C_UOM_ID
	,CASE WHEN il.M_Product_ID > 0 THEN puom.C_UOM_ID ELSE 0 END AS M_Product_C_UOM_ID
	,CASE WHEN  dt.DocBaseType = 'ARC' THEN il.PriceEntered * -1 ELSE il.PriceEntered END AS PriceEntered
	,CASE WHEN  dt.DocBaseType = 'ARC' THEN il.PriceActual * -1 ELSE il.PriceActual END AS PriceActual
	,CASE WHEN  dt.DocBaseType = 'ARC' THEN il.PriceList * -1 ELSE il.PriceList END AS PriceList
	,il.C_Tax_ID
	,t.TaxIndicator AS TaxName
	,CASE WHEN  dt.DocBaseType = 'ARC' THEN il.LineNetAmt * -1 ELSE il.LineNetAmt END AS LineNetAmt
	,il.Description
	,CASE WHEN  dt.DocBaseType = 'ARC' THEN il.JP_TaxBaseAmt * -1 ELSE il.JP_TaxBaseAmt END AS JP_TaxBaseAmt
	,CASE WHEN  dt.DocBaseType = 'ARC' THEN il.JP_TaxAmt * -1 ELSE il.JP_TaxAmt END AS JP_TaxAmt


FROM adempiere.JP_BillLine bill
		INNER JOIN adempiere.C_Invoice iv on (bill.C_Invoice_ID = iv.C_Invoice_ID )
		INNER JOIN adempiere.C_DocType dt ON(bill.C_DocType_ID = dt.C_DocType_ID)
		INNER JOIN adempiere.M_PriceList pl ON(bill.M_PriceList_ID = pl.M_PriceList_ID)
		INNER JOIN adempiere.C_InvoiceLine il ON(bill.C_Invoice_ID = il.C_Invoice_ID)
			left Outer Join adempiere.M_InOutLine iol ON (il.M_InOutLine_ID = iol.M_InOutLine_ID)
				left Outer Join adempiere.M_InOut io ON(iol.M_InOut_ID = io.M_InOut_ID)
			left Outer Join adempiere.C_OrderLine ol ON (il.C_OrderLine_ID = ol.C_OrderLine_ID)
				left Outer Join adempiere.C_Order o ON(ol.C_Order_ID = o.C_Order_ID)
			left Outer Join adempiere.M_Product p on(il.M_Product_ID = p.M_Product_ID)
				left Outer JOIN adempiere.C_UOM puom on(p.C_UOM_ID = puom.C_UOM_ID)
			left Outer Join adempiere.C_Charge c on(il.C_Charge_ID = c.C_Charge_ID)
			left Outer Join adempiere.C_Tax t on(il.C_Tax_ID = t.C_Tax_ID)