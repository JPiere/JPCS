--DROP VIEW adempiere.C_Invoice_Line_JP;
CREATE OR REPLACE VIEW adempiere.C_Invoice_Line_JP AS 
SELECT 
il.C_Invoice_ID
,il.C_InvoiceLine_ID
,il.AD_Client_ID
,il.AD_Org_ID
,il.Line
,il.M_Product_ID
,il.C_Charge_ID
,CASE WHEN il.M_Product_ID > 0 THEN p.Value ELSE il.Description END AS ProductValue
,CASE WHEN il.M_Product_ID > 0 THEN p.Name ELSE c.Name END AS ProductName
,il.QtyEntered
,il.QtyInvoiced
,il.C_UOM_ID
,CASE WHEN il.M_Product_ID > 0 THEN puom.C_UOM_ID ELSE 0 END AS M_Product_C_UOM_ID
,il.PriceEntered
,il.PriceActual
,il.PriceList
,il.C_Tax_ID
,t.TaxIndicator AS TaxName
,il.LineNetAmt
,il.Description
,'en_US'::text AS ad_language
,il.JP_TaxBaseAmt
,il.JP_TaxAmt
,CASE WHEN il.M_Product_ID > 0 THEN p.Value || ':' || p.Name ELSE c.Name END AS ProductValueName

FROM adempiere.C_InvoiceLine il
	left Outer Join adempiere.M_Product p on(il.M_Product_ID = p.M_Product_ID)
		left Outer JOIN adempiere.C_UOM puom on(p.C_UOM_ID = puom.C_UOM_ID)
	left Outer Join adempiere.C_Charge c on(il.C_Charge_ID = c.C_Charge_ID)
	left Outer Join adempiere.C_Tax t on(il.C_Tax_ID = t.C_Tax_ID)