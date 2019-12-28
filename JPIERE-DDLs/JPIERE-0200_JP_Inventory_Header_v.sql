--DROP VIEW adempiere.JP_Inventory_Header_v;
CREATE OR REPLACE VIEW adempiere.JP_Inventory_Header_v AS 
SELECT 
 io.AD_Client_ID
 ,c.Name as JP_Client_Name
 ,io.AD_Org_ID
 ,org.Name as JP_Org_Name
 ,io.M_Inventory_ID
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
 ,io.DocumentNo
 ,io.MovementDate
 ,io.description
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
 ,io.M_Inventory_ID as JP_Inventory_Header_v_ID
 ,io.DocStatus
 FROM adempiere.M_Inventory io
	INNER JOIN adempiere.AD_Client c on(io.AD_Client_ID = c.AD_Client_ID)
	INNER JOIN adempiere.AD_Org org on(io.AD_Org_ID = org.AD_Org_ID)
	INNER JOIN adempiere.AD_OrgInfo orginfo on(io.AD_Org_ID = orginfo.AD_Org_ID)
		INNER JOIN adempiere.C_Location orgloc on(orginfo.C_Location_ID = orgloc.C_Location_ID)
	INNER JOIN adempiere.M_Warehouse w on(io.M_Warehouse_ID = w.M_Warehouse_ID)
		left Outer Join adempiere.C_Location wloc on(w.C_Location_ID = wloc.C_Location_ID)