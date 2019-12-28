DROP VIEW adempiere.JP_Invoice_Header_v;
CREATE OR REPLACE VIEW adempiere.JP_Invoice_Header_v AS 
SELECT 
i.C_Order_ID
,i.C_Invoice_ID
 ,i.AD_Client_ID
 ,c.Name as JP_Client_Name
 ,i.AD_Org_ID
 ,org.Name as JP_Org_Name
 ,orgloc.Postal AS JP_Org_Postal
 ,orgloc.Postal_Add AS JP_Org_Postal_Add
 ,orgloc.C_Region_ID AS JP_Org_Reigon_ID
 ,orgloc.RegionName AS JP_Org_RegionName
 ,orgloc.C_City_ID AS JP_Org_City_ID
 ,orgloc.City AS JP_Org_City
 ,concat(orgloc.RegionName,orgloc.City) AS JP_Org_Region_City
 ,orgloc.Address1 as JP_Org_Address1
 ,orgloc.Address2 as JP_Org_Address2
 ,orgloc.Address3 as JP_Org_Address3
 ,orgloc.Address4 as JP_Org_Address4
 ,concat(orgloc.Address1,orgloc.Address2) as JP_Org_Address12
 ,concat(orgloc.Address3,orgloc.Address4) as JP_Org_Address34
 ,orginfo.phone as JP_Org_Phone
 ,orginfo.phone2 as JP_Org_Phone2
 ,orginfo.Fax as JP_Org_Fax
 ,i.DocumentNo as JP_Invoice_DocumentNo
 ,i.created
 ,i.description
 ,i.TotalLines
 ,i.GrandTotal
 ,(SELECT sum(TaxAmt) From adempiere.C_InvoiceTax it WHERE it.C_Invoice_ID = i.C_Invoice_ID )AS TaxAmt
 ,(SELECT sum(TaxBaseAmt) From adempiere.C_InvoiceTax it WHERE it.C_Invoice_ID = i.C_Invoice_ID )AS TaxBaseAmt
 ,bp.Name as JP_BP_Name
 ,g.Greeting
 ,u.Name as JP_User_Name
 ,bpu.Name as JP_BP_User_Name
 ,i.DateInvoiced
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
 ,adempiere.jp_paymenttermduedate(i.c_paymentterm_id, i.DateAcct::timestamp with time zone) AS duedate
 ,bp.Name2 as JP_BP_Name2
 ,bpu.Comments AS JP_User_Comments
 FROM adempiere.C_Invoice i
	INNER JOIN adempiere.AD_Client c on(i.AD_Client_ID = c.AD_Client_ID)
	INNER JOIN adempiere.AD_Org org on(i.AD_Org_ID = org.AD_Org_ID)
	INNER JOIN adempiere.AD_OrgInfo orginfo on(i.AD_Org_ID = orginfo.AD_Org_ID)
		LEFT OUTER JOIN adempiere.C_Location orgloc on(orginfo.C_Location_ID = orgloc.C_Location_ID)
	INNER JOIN adempiere.C_BPartner bp on(i.C_BPartner_ID = bp.C_BPartner_ID)
		LEFT OUTER JOIN adempiere.C_Greeting g on(bp.C_Greeting_ID = g.C_Greeting_ID)
	LEFT OUTER JOIN adempiere.AD_User u on(i.SalesRep_ID = u.AD_User_ID)
	LEFT OUTER JOIN adempiere.AD_User bpu on(i.AD_User_ID = bpu.AD_User_ID)
	INNER JOIN adempiere.C_BPartner_Location bpl on(i.C_BPartner_Location_ID = bpl.C_BPartner_Location_ID)
		INNER JOIN adempiere.C_Location bploc on(bpl.C_Location_ID = bploc.C_Location_ID)