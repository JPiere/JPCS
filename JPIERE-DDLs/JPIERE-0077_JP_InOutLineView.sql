--DROP VIEW adempiere.JP_InOutLineView;

CREATE OR REPLACE VIEW adempiere.JP_InOutLineView AS 
SELECT
iol.AD_Client_ID
,iol.AD_Org_ID
,iol.AD_OrgTrx_ID
,iol.M_InOut_ID
,iol.M_InOutLine_ID
,iol.C_OrderLine_ID
,iol.Line		AS JP_InOut_Line
,iol.M_Locator_ID
,iol.M_Product_ID
,iol.M_AttributeSetInstance_ID
,iol.Description
,iol.QtyEntered		AS JP_InOutLine_QtyEntered
,iol.C_UOM_ID		AS JP_InOutLine_UOM_ID
,iol.MovementQty
,iol.PickedQty
,iol.TargetQty
,iol.ConfirmedQty
,iol.ScrappedQty
,iol.C_Project_ID
,iol.C_ProjectPhase_ID
,iol.C_ProjectTask_ID
,iol.C_Campaign_ID
,iol.C_Activity_ID
,iol.User1_ID
,iol.User2_ID
,iol.IsDescription
,iol.IsInvoiced
,iol.Ref_InOutLine_ID
,iol.M_RMALine_ID
,iol.ReversalLine_ID
,iol.QtyOverReceipt
,iol.C_Charge_ID
,io.C_DocType_ID
,io.DocumentNo
,io.M_RMA_ID
,io.MovementDate
,io.DateAcct
,io.SalesRep_ID
,io.C_BPartner_ID
,io.C_BPartner_Location_ID
,io.AD_User_ID
,io.M_Warehouse_ID
,io.DeliveryRule
,io.PickDate
,io.IsDropShip
,CASE WHEN io.IsDropShip = 'Y' THEN io.DropShip_BPartner_ID ELSE io.C_BPartner_ID END AS DropShip_BPartner_ID
,CASE WHEN io.IsDropShip = 'Y' THEN io.DropShip_Location_ID ELSE io.C_BPartner_Location_ID END AS DropShip_Location_ID
,CASE WHEN io.IsDropShip = 'Y' THEN io.DropShip_User_ID ELSE io.AD_User_ID END AS DropShip_User_ID
,io.DeliveryViaRule
,io.M_Shipper_ID
,io.ShipDate
,io.DocStatus
,io.Posted
,io.DateReceived
,io.MovementType
,io.IsSOTrx
,io.C_Invoice_ID
,ol.Line 		AS JP_Order_Line
,ol.DateOrdered
,ol.DatePromised
,ol.QtyEntered		AS JP_OrderLine_QtyEntered
,ol.C_UOM_ID		AS JP_OrderLine_UOM_ID
,ol.QtyOrdered
,ol.QtyReserved
,ol.QtyDelivered
,ol.QtyInvoiced
,ol.PriceEntered
,ol.PriceActual
,ol.PriceLimit
,ol.C_Tax_ID
,ol.Discount
,ol.PriceList
,ol.LineNetAmt
,ol.QtyLostSales
,ol.C_Currency_ID
,ol.qtyordered - ol.qtydelivered AS QtyToDeliver
,ol.qtyordered - ol.qtyinvoiced AS QtyToInvoice 
,ol.qtydelivered - ol.qtyinvoiced AS QtyNotInvDeliverJP
,ol.C_Order_ID
FROM adempiere.M_InOutLine iol
	INNER JOIN adempiere.M_InOut io on(iol.M_InOut_ID = io.M_InOut_ID)
	LEFT OUTER JOIN adempiere.C_OrderLine ol on(iol.C_OrderLine_ID = ol.C_OrderLine_ID)


