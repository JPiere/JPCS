--DROP VIEW adempiere.JP_Inventory_Line_vt;
CREATE OR REPLACE VIEW adempiere.JP_Inventory_Line_vt AS 
SELECT 
  il.M_InventoryLine_ID
  ,il.AD_Client_ID
  ,il.AD_Org_ID
  ,il.M_Inventory_ID
  ,il.M_Locator_ID
  ,il.M_Product_ID
  ,il.Line
  ,il.QtyBook
  ,il.QtyCount
  ,il.Description
  ,il.M_AttributeSetInstance_ID
  ,il.C_Charge_ID
  ,il.InventoryType
  ,il.QtyInternalUse
  ,il.ReversalLine_ID
  ,il.QtyCsv
  ,il.CurrentCostPrice
  ,il.NewCostPrice
  ,loc.value AS m_locator_value
  ,loc.x
  ,loc.y
  ,loc.z
  ,loc.x || ' : ' || loc.y || ' : ' ||loc.z AS JP_LocatorXYZ
  ,p.Value AS ProductValue
  ,p.Name  AS ProductName
  ,p.Value || ':' || p.Name AS ProductValueName
  ,p.C_UOM_ID
  ,pt.AD_Language
 FROM adempiere.M_InventoryLIne il
	INNER JOIN adempiere.M_Locator loc on(il.M_Locator_ID = loc.M_Locator_ID)
	INNER JOIN adempiere.M_Product p on(il.M_Product_ID = p.M_Product_ID)
		INNER JOIN adempiere.M_Product_Trl pt on(p.M_Product_ID = pt.M_Product_ID)