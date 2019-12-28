DROP VIEW adempiere.JP_InOut_Header_v;
CREATE OR REPLACE VIEW adempiere.JP_InOut_Header_v AS 
SELECT 
 io.AD_Client_ID
 ,c.Name as JP_Client_Name
 ,io.AD_Org_ID
 ,org.Name as JP_Org_Name
 ,io.M_InOut_ID
 ,orgloc.Postal AS JP_Org_Postal
 ,orgloc.Postal_Add AS JP_Org_Postal_Add
 ,orgloc.C_Region_ID AS JP_Org_Reigon_ID
 ,orgloc.RegionName AS JP_Org_RegionName
 ,orgloc.C_City_ID AS JP_Org_City_ID
 ,orgloc.City AS JP_Org_City
 ,orgloc.RegionName || orgloc.City AS JP_Region_City
 ,orgloc.Address1 as JP_Org_Address1
 ,orgloc.Address2 as JP_Org_Address2
 ,orgloc.Address3 as JP_Org_Address3
 ,orgloc.Address4 as JP_Org_Address4
 ,concat(orgloc.Address1,orgloc.Address2) as JP_Org_Address12
 ,concat(orgloc.Address3,orgloc.Address4) as JP_Org_Address34
 ,orginfo.phone as JP_Org_Phone
 ,orginfo.phone2 as JP_Org_Phone2
 ,orginfo.Fax as JP_Org_Fax
 ,io.DocumentNo as JP_InOut_DocumentNo
 ,io.MovementDate
 ,io.created
 ,io.description
 ,bp.Name as JP_BP_Name
 ,g.Greeting
 ,u.Name as JP_User_Name
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
 ,bploc.RegionName || bploc.City AS JP_BP_Region_City
 ,bploc.Address1 as JP_BP_Address1
 ,bploc.Address2 as JP_BP_Address2
 ,bploc.Address3 as JP_BP_Address3
 ,bploc.Address4 as JP_BP_Address4
 ,concat(bploc.Address1, bploc.Address2) as JP_BP_Address12
 ,concat(bploc.Address3, bploc.Address4) as JP_BP_Address34
 ,CASE WHEN io.IsDropShip = 'Y' THEN io.DropShip_BPartner_ID ELSE io.C_BPartner_ID END AS DropShip_BPartner_ID
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbp.Name ELSE bp.Name END AS JP_DropShip_BP_Name
 ,CASE WHEN io.IsDropShip = 'Y' THEN dg.Greeting ELSE g.Greeting END AS JP_DropShip_BP_Greeting
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbpl.Phone ELSE bpl.Phone END AS JP_DropShip_BP_Phone
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbpl.Phone2 ELSE bpl.Phone2 END AS JP_DropShip_BP_Phone2
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbpl.Fax ELSE bpl.Fax END AS JP_DropShip_BP_Fax
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.Postal ELSE bploc.Postal END AS JP_DropShip_BP_Postal
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.Postal_Add ELSE bploc.Postal_Add END AS JP_DropShip_BP_Postal_Add
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.C_Region_ID ELSE bploc.C_Region_ID END AS JP_DropShip_Region_ID
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.RegionName ELSE bploc.RegionName END AS JP_DropShip_BP_RegionName
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.C_City_ID ELSE bploc.C_City_ID END AS JP_DropShip_BP_City_ID
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.City ELSE bploc.City END AS JP_DropShip_BP_City
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.RegionName || dbploc.City ELSE bploc.RegionName || bploc.City END AS JP_DropShip_BP_Region_City
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.Address1 ELSE bploc.Address1 END AS JP_DropShip_BP_Address1
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.Address2 ELSE bploc.Address2 END AS JP_DropShip_BP_Address2
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.Address3 ELSE bploc.Address3 END AS JP_DropShip_BP_Address3
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbploc.Address4 ELSE bploc.Address4 END AS JP_DropShip_BP_Address4
 ,CASE WHEN o.IsDropShip = 'Y' THEN concat(dbploc.Address1, dbploc.Address2) ELSE concat(bploc.Address1, bploc.Address2) END AS JP_DropShip_BP_Address12
 ,CASE WHEN o.IsDropShip = 'Y' THEN concat(dbploc.Address3, dbploc.Address4) ELSE concat(bploc.Address3, bploc.Address4)END AS JP_DropShip_BP_Address34
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
 ,CASE WHEN io.IsDropShip = 'Y' THEN dbp.Name2 ELSE bp.Name2 END AS JP_DropShip_BP_Name2
 FROM adempiere.M_InOut io
	INNER JOIN adempiere.AD_Client c on(io.AD_Client_ID = c.AD_Client_ID)
	INNER JOIN adempiere.AD_Org org on(io.AD_Org_ID = org.AD_Org_ID)
	INNER JOIN adempiere.AD_OrgInfo orginfo on(io.AD_Org_ID = orginfo.AD_Org_ID)
		INNER JOIN adempiere.C_Location orgloc on(orginfo.C_Location_ID = orgloc.C_Location_ID)
	INNER JOIN adempiere.M_Warehouse w on(io.M_Warehouse_ID = w.M_Warehouse_ID)
		left Outer Join adempiere.C_Location wloc on(w.C_Location_ID = wloc.C_Location_ID)
	INNER JOIN adempiere.C_BPartner bp on(io.C_BPartner_ID = bp.C_BPartner_ID)
		Left Outer Join  adempiere.C_Greeting g on(bp.C_Greeting_ID = g.C_Greeting_ID)
	Left Outer Join  adempiere.AD_User u on(io.SalesRep_ID = u.AD_User_ID)
	INNER JOIN adempiere.C_Order o on(io.C_Order_ID = o.C_Order_ID)
	INNER JOIN adempiere.C_BPartner_Location bpl on(io.C_BPartner_Location_ID = bpl.C_BPartner_Location_ID)
		INNER JOIN adempiere.C_Location bploc on(bpl.C_Location_ID = bploc.C_Location_ID)
	Left Outer Join adempiere.C_BPartner dbp on(io.DropShip_BPartner_ID = dbp.C_BPartner_ID)
		left Outer Join adempiere.C_Greeting dg on(dbp.C_Greeting_ID = dg.C_Greeting_ID)
		left Outer Join adempiere.C_BPartner_Location dbpl on(io.DropShip_Location_ID = dbpl.C_BPartner_Location_ID)
		left Outer Join adempiere.C_Location dbploc on(dbpl.C_Location_ID = dbploc.C_Location_ID)