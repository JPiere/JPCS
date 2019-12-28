-- DROP VIEW adempiere.JP_Order_Gross_Profit;

CREATE OR REPLACE VIEW adempiere.JP_Order_Gross_Profit AS 
SELECT 
 o.C_Order_ID
 ,o.AD_Client_ID
 ,o.AD_Org_ID
 ,o.AD_OrgTrx_ID
 ,o.C_DocTypeTarget_ID
 ,o.IsSOTrx
 ,o.DateOrdered
 ,o.DatePromised
 ,o.DocumentNo
 ,o.C_BPartner_ID
 ,o.M_PriceList_ID
 ,o.DocStatus
 ,o.SalesRep_ID
 ,o.C_Currency_ID
 ,o.GrandTotal
 ,ot.TaxAmt
 ,o.GrandTotal - ot.TaxAmt AS JP_OrderAmt
 ,o.JP_ScheduledCostTotalLines AS JP_ScheduledCostTotalLines
 ,adempiere.currencyBase(o.GrandTotal, o.C_Currency_ID, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID) AS JP_ConvertedGrandTotal
 ,adempiere.currencyBase(ot.TaxAmt, o.C_Currency_ID, o.DateAcct, o.AD_Client_ID, o.AD_Org_ID) AS JP_ConvertedTaxAmt
 ,o.DateAcct
 FROM adempiere.C_Order o
  INNER JOIN (SELECT C_Order_ID, SUM(TaxAmt) AS TaxAmt FROM adempiere.C_OrderTax GROUP BY C_Order_ID ) ot ON(o.C_Order_ID = ot.C_Order_ID)
  