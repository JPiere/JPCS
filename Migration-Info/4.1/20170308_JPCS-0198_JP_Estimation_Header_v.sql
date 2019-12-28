--DROP VIEW adempiere.JP_Estimation_Header_v;
CREATE OR REPLACE VIEW adempiere.JP_Estimation_Header_v AS 
SELECT 
o.JP_Estimation_ID
 ,o.AD_Client_ID
 ,c.Name as JP_Client_Name
 ,o.AD_Org_ID
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
 ,o.DocumentNo as JP_Estimation_DocumentNo
 ,o.created
 ,o.description
 ,o.TotalLines
 ,o.GrandTotal
 ,(SELECT sum(TaxAmt) From adempiere.JP_EstimationTax ot WHERE ot.JP_Estimation_ID = o.JP_Estimation_ID )AS TaxAmt
 ,(SELECT sum(TaxBaseAmt) From adempiere.JP_EstimationTax ot WHERE ot.JP_Estimation_ID = o.JP_Estimation_ID )AS TaxBaseAmt
 ,o.JP_BP_Name as JP_BP_Name
 ,g.Greeting
 ,u.Name as JP_User_Name
 ,o.JP_BP_User_Name as JP_BP_User_Name
 ,o.DateOrdered
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
 ,o.JP_BP_Address as JP_BP_Address
 ,concat(bploc.address1, bploc.address2) AS jp_bp_address12
 ,concat(bploc.Address3, bploc.Address4) as JP_BP_Address34
 ,CASE WHEN o.IsDropShip = 'Y' THEN o.DropShip_BPartner_ID ELSE o.C_BPartner_ID END AS DropShip_BPartner_ID
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbp.Name ELSE bp.Name END AS JP_DropShip_BP_Name
 ,CASE WHEN o.IsDropShip = 'Y' THEN dg.Greeting ELSE g.Greeting END AS JP_DropShip_BP_Greeting
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbpl.Phone ELSE bpl.Phone END AS JP_DropShip_BP_Phone
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbpl.Phone2 ELSE bpl.Phone2 END AS JP_DropShip_BP_Phone2
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbpl.Fax ELSE bpl.Fax END AS JP_DropShip_BP_Fax
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.Postal ELSE bploc.Postal END AS JP_DropShip_BP_Postal
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.Postal_Add ELSE bploc.Postal_Add END AS JP_DropShip_BP_Postal_Add
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.C_Region_ID ELSE bploc.C_Region_ID END AS JP_DropShip_Region_ID
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.RegionName ELSE bploc.RegionName END AS JP_DropShip_BP_RegionName
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.C_City_ID ELSE bploc.C_City_ID END AS JP_DropShip_BP_City_ID
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.City ELSE bploc.City END AS JP_DropShip_BP_City
 ,CASE WHEN o.IsDropShip = 'Y' THEN concat(dbploc.RegionName, dbploc.City) ELSE concat(bploc.RegionName, bploc.City) END AS JP_DropShip_BP_Region_City
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.Address1 ELSE bploc.Address1 END AS JP_DropShip_BP_Address1
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.Address2 ELSE bploc.Address2 END AS JP_DropShip_BP_Address2
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.Address3 ELSE bploc.Address3 END AS JP_DropShip_BP_Address3
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbploc.Address4 ELSE bploc.Address4 END AS JP_DropShip_BP_Address4
 ,CASE WHEN o.IsDropShip = 'Y' THEN concat(dbploc.Address1, dbploc.Address2) ELSE concat(bploc.Address1, bploc.Address2) END AS JP_DropShip_BP_Address12
 ,CASE WHEN o.IsDropShip = 'Y' THEN concat(dbploc.Address3, dbploc.Address4) ELSE concat(bploc.Address3, bploc.Address4)END AS JP_DropShip_BP_Address34
 ,billbp.Name AS JP_Bill_BP_Name
 ,billg.Greeting AS JP_Bill_BP_Greeting
 ,billbpu.Name as JP_Bill_User_Name
 ,billbpl.phone as JP_Bill_BP_Phone
 ,billbpl.phone2 as JP_Bill_BP_Phone2
 ,billbpl.Fax as JP_Bill_BP_Fax
 ,billbploc.Postal AS JP_Bill_Postal
 ,billbploc.Postal_Add AS JP_Bill_Postal_Add
 ,billbploc.C_Region_ID AS JP_Bill_Reigon_ID
 ,billbploc.RegionName AS JP_Bill_RegionName
 ,billbploc.C_City_ID AS JP_Bill_City_ID
 ,billbploc.City AS JP_Bill_City
 ,concat(billbploc.RegionName, billbploc.City) AS JP_Bill_Region_City
 ,billbploc.Address1 as JP_Bill_Address1
 ,billbploc.Address2 as JP_Bill_Address2
 ,billbploc.Address3 as JP_Bill_Address3
 ,billbploc.Address4 as JP_Bill_Address4
 ,concat(billbploc.Address1,  billbploc.Address2) as JP_Bill_Address12
 ,concat(billbploc.Address3,  billbploc.Address4) as JP_Bill_Address34
 ,w.Name as JP_WH_Name
 ,wloc.Postal AS JP_WH_Postal
 ,wloc.Postal_Add AS JP_WH_Postal_Add
 ,wloc.C_Region_ID AS JP_WH_Reigon_ID
 ,wloc.RegionName AS JP_WH_RegionName
 ,wloc.C_City_ID AS JP_WH_City_ID
 ,wloc.City AS JP_WH_City
 ,concat(wloc.RegionName, wloc.City) AS JP_WH_Region_City
 ,wloc.Address1 as JP_WH_Address1
 ,wloc.Address2 as JP_WH_Address2
 ,wloc.Address3 as JP_WH_Address3
 ,wloc.Address4 as JP_WH_Address4
 ,concat(wloc.Address1,  wloc.Address2) as JP_WH_Address12
 ,concat(wloc.Address3,  wloc.Address4) as JP_WH_Address34
 ,bp.Name2 as JP_BP_Name2
 ,CASE WHEN o.IsDropShip = 'Y' THEN dbp.Name2 ELSE bp.Name2 END AS JP_DropShip_BP_Name2
 ,billbp.Name2 AS JP_Bill_BP_Name2
 ,o.JP_Estimation_ID AS JP_Estimation_Header_v_ID
 ,adempiere.jp_paymenttermduedate(o.c_paymentterm_id, o.DateAcct::timestamp with time zone) AS duedate

 FROM adempiere.JP_Estimation o
	INNER JOIN adempiere.AD_Client c on(o.AD_Client_ID = c.AD_Client_ID)
	INNER JOIN adempiere.AD_Org org on(o.AD_Org_ID = org.AD_Org_ID)
	INNER JOIN adempiere.AD_OrgInfo orginfo on(o.AD_Org_ID = orginfo.AD_Org_ID)
		left Outer Join adempiere.C_Location orgloc on(orginfo.C_Location_ID = orgloc.C_Location_ID)
	INNER JOIN adempiere.M_Warehouse w on(o.M_Warehouse_ID = w.M_Warehouse_ID)
		left Outer Join adempiere.C_Location wloc on(w.C_Location_ID = wloc.C_Location_ID)
	left Outer Join adempiere.C_BPartner bp on(o.C_BPartner_ID = bp.C_BPartner_ID)
		Left Outer Join  adempiere.C_Greeting g on(bp.C_Greeting_ID = g.C_Greeting_ID)
	INNER JOIN adempiere.AD_User u on(o.SalesRep_ID = u.AD_User_ID)
	Left Outer Join adempiere.AD_User bpu on(o.AD_User_ID = bpu.AD_User_ID)
	left Outer Join adempiere.C_BPartner_Location bpl on(o.C_BPartner_Location_ID = bpl.C_BPartner_Location_ID)
		left Outer Join adempiere.C_Location bploc on(bpl.C_Location_ID = bploc.C_Location_ID)
	Left Outer Join adempiere.C_BPartner dbp on(o.DropShip_BPartner_ID = dbp.C_BPartner_ID)
		left Outer Join adempiere.C_Greeting dg on(dbp.C_Greeting_ID = dg.C_Greeting_ID)
		left Outer Join adempiere.C_BPartner_Location dbpl on(o.DropShip_Location_ID = dbpl.C_BPartner_Location_ID)
		left Outer Join adempiere.C_Location dbploc on(dbpl.C_Location_ID = dbploc.C_Location_ID)
		left Outer Join adempiere.AD_User dbpu on(o.DropShip_User_ID = dbpu.AD_User_ID)
	Left Outer Join adempiere.C_BPartner billbp on(o.Bill_BPartner_ID = billbp.C_BPartner_ID)
		left Outer Join adempiere.C_Greeting billg on(billbp.C_Greeting_ID = billg.C_Greeting_ID)
		left Outer Join adempiere.C_BPartner_Location billbpl on(o.Bill_Location_ID = billbpl.C_BPartner_Location_ID)
		left Outer Join adempiere.C_Location billbploc on(billbpl.C_Location_ID = billbploc.C_Location_ID)
		left Outer Join adempiere.AD_User billbpu on(o.Bill_User_ID = billbpu.AD_User_ID)