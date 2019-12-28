DROP VIEW adempiere.JP_RV_Bill_Header;
CREATE OR REPLACE VIEW adempiere.JP_RV_Bill_Header AS 
SELECT 
 bill.JP_Bill_ID AS JP_RV_Bill_Header_ID
 ,bill.JP_Bill_ID AS JP_Bill_ID
 ,bill.AD_Client_ID AS AD_Client_ID
 ,c.Name AS JP_Client_Name
 ,bill.AD_Org_ID AS AD_Org_ID
 ,org.Name AS JP_Org_Name
 ,orgloc.Postal AS JP_Org_Postal
 ,orgloc.Postal_Add AS JP_Org_Postal_Add
 ,orgloc.C_Region_ID AS JP_Org_Reigon_ID
 ,orgloc.RegionName AS JP_Org_RegionName
 ,orgloc.C_City_ID AS JP_Org_City_ID
 ,orgloc.City AS JP_Org_City
 ,concat(orgloc.RegionName,orgloc.City) AS JP_Org_Region_City
 ,orgloc.Address1 AS JP_Org_Address1
 ,orgloc.Address2 AS JP_Org_Address2
 ,orgloc.Address3 AS JP_Org_Address3
 ,orgloc.Address4 AS JP_Org_Address4
 ,concat(orgloc.Address1,orgloc.Address2) AS JP_Org_Address12
 ,concat(orgloc.Address3,orgloc.Address4) AS JP_Org_Address34
 ,orginfo.phone AS JP_Org_Phone
 ,orginfo.phone2 AS JP_Org_Phone2
 ,orginfo.Fax AS JP_Org_Fax
 
 ,bill.DocumentNo AS JP_Bill_DocumentNo
 ,bill.DocStatus AS DocStatus
 ,bill.DocAction AS DocAction
 ,bill.Processed AS Processed
 ,bill.Posted AS Posted
 
 ,bill.AD_OrgTrx_ID AS AD_OrgTrx_ID
 ,bill.C_DocType_ID AS C_DocType_ID
 ,bill.JPDateBilled AS JPDateBilled 
 ,bill.JPCutOffDate AS JPCutOffDate
 ,bill.SalesRep_ID AS SalesRep_ID
 ,bill.C_BPartner_ID AS C_BPartner_ID
 ,bill.C_BPartner_Location_ID AS C_BPartner_Location_ID
 ,bill.AD_User_ID AS AD_User_ID
 ,bill.PaymentRule AS PaymentRule
 ,bill.C_PaymentTerm_ID AS C_PaymentTerm_ID
 ,bill.C_Currency_ID AS C_Currency_ID
 ,bill.Description AS Description
 
 ,bill.JP_LastBill_ID AS JP_LastBill_ID
 ,bill.JPLastBillAmt AS JPLastBillAmt
 ,bill.C_Payment_ID AS C_Payment_ID
 ,bill.JPLastPayAmt AS JPLastPayAmt
 ,bill.JPCarriedForwardAmt AS JPCarriedForwardAmt
 
 ,bill.TotalLines AS TotalLines
 ,bill.GrandTotal AS GrandTotal
 ,bill.TaxBaseAmt AS TaxBaseAmt
 ,bill.TaxAmt AS TaxAmt
 ,bill.PayAmt AS PayAmt
 ,bill.OpenAmt AS OpenAmt
 ,bill.OverUnderAmt AS OverUnderAmt
 ,bill.JPBillAmt AS JPBillAmt

 ,adempiere.jp_paymenttermduedate(bill.c_paymentterm_id, bill.JPCutOffDate::timestamp with time zone) AS duedate

 ,bp.Name as JP_BP_Name
 ,bp.Name2 as JP_BP_Name2
 ,g.Greeting
 ,u.Name as JP_User_Name
 ,bpu.Name as JP_BP_User_Name
 ,bpl.phone as JP_BP_Phone
 ,bpl.phone2 as JP_BP_Phone2
 ,bpl.Fax as JP_BP_Fax
 ,bploc.Postal AS JP_BP_Postal
 ,bploc.Postal_Add AS JP_BP_Postal_Add
 ,bploc.C_Region_ID AS JP_BP_Reigon_ID
 ,bploc.RegionName AS JP_BP_RegionName
 ,bploc.C_City_ID AS JP_BP_City_ID
 ,bploc.City AS JP_BP_City
 ,concat(bploc.RegionName, bploc.City) AS JP_BP_Region_City
 ,bploc.Address1 as JP_BP_Address1
 ,bploc.Address2 as JP_BP_Address2
 ,bploc.Address3 as JP_BP_Address3
 ,bploc.Address4 as JP_BP_Address4
 ,concat(bploc.Address1, bploc.Address2) as JP_BP_Address12
 ,concat(bploc.Address3, bploc.Address4) as JP_BP_Address34

 
 FROM adempiere.JP_Bill bill
	INNER JOIN adempiere.AD_Client c on(bill.AD_Client_ID = c.AD_Client_ID)
	INNER JOIN adempiere.AD_Org org on(bill.AD_Org_ID = org.AD_Org_ID)
	INNER JOIN adempiere.AD_OrgInfo orginfo on(bill.AD_Org_ID = orginfo.AD_Org_ID)
		LEFT OUTER JOIN adempiere.C_Location orgloc on(orginfo.C_Location_ID = orgloc.C_Location_ID)
	INNER JOIN adempiere.C_BPartner bp on(bill.C_BPartner_ID = bp.C_BPartner_ID)
		LEFT OUTER JOIN adempiere.C_Greeting g on(bp.C_Greeting_ID = g.C_Greeting_ID)
	LEFT OUTER JOIN adempiere.AD_User u on(bill.SalesRep_ID = u.AD_User_ID)
	LEFT OUTER JOIN adempiere.AD_User bpu on(bill.AD_User_ID = bpu.AD_User_ID)
	INNER JOIN adempiere.C_BPartner_Location bpl on(bill.C_BPartner_Location_ID = bpl.C_BPartner_Location_ID)
		INNER JOIN adempiere.C_Location bploc on(bpl.C_Location_ID = bploc.C_Location_ID)