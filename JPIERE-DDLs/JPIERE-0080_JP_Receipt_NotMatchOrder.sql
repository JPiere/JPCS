--DROP VIEW adempiere.JP_Receipt_NotMatchOrder;

CREATE OR REPLACE VIEW adempiere.JP_Receipt_NotMatchOrder AS 

SELECT 
	iol.AD_Client_ID AS AD_Client_ID, 
	iol.AD_Org_ID AS AD_Org_ID, 
	iol.AD_OrgTrx_ID AS AD_OrgTrx_ID,
	l.M_WAREHOUSE_ID AS M_WAREHOUSE_ID,
	iol.IsActive AS IsActive, 
	iol.Created AS Created, 
	iol.CreatedBy AS CreatedBy, 
	iol.Updated AS Updated, 
	iol.UpdatedBy AS UpdatedBy,   
	io.M_InOut_ID AS M_InOut_ID, 
	io.DocumentNo AS DocumentNo, 
	io.C_DocType_ID AS C_DocType_ID, 
	io.MovementDate AS MovementDate,
	io.DateReceived AS DateReceived, 
	io.DateAcct AS DateAcct, 
	io.DocStatus AS DocStatus,   
	io.C_BPartner_ID AS C_BPartner_ID, 
	bp.C_BP_Group_ID AS C_BP_Group_ID,
	io.C_BPartner_Location_ID AS C_BPartner_Location_ID, 
	io.AD_User_ID AS AD_User_ID,   
	iol.M_InOutLine_ID AS M_InOutLine_ID, 
	iol.Line AS Line,   
	iol.M_Product_ID AS M_Product_ID, 
	p.M_PRODUCT_CATEGORY_ID AS M_PRODUCT_CATEGORY_ID,
	iol.MovementQty AS MovementQty, 
 	COALESCE(m.Qty,0) AS JP_MatchedQty,     
	iol.MovementQty - COALESCE(m.Qty,0) AS JP_NotMatchQty 

FROM  adempiere.M_InOut io   
	INNER JOIN adempiere.M_InOutLine iol ON(io.M_InOut_ID=iol.M_InOut_ID) 
	INNER JOIN adempiere.M_LOCATOR l ON(iol.M_LOCATOR_ID=l.M_LOCATOR_ID)
	INNER JOIN adempiere.M_Product p ON(iol.M_Product_ID=p.M_Product_ID)
	INNER JOIN adempiere.C_BPartner bp ON(io.C_BPartner_ID=bp.C_BPartner_ID)
	INNER JOIN adempiere.C_DocType dt ON(io.C_DocType_ID=dt.C_DocType_ID)
	LEFT OUTER JOIN adempiere.M_MatchPo m ON (m.M_InOutLine_ID=iol.M_InOutLine_ID) 
WHERE 
 io.IsSOTrx='N' AND io.DocStatus IN ('CO', 'CL') 
 AND iol.M_PRODUCT_ID is not null 		/*料金タイプは照合できないため、料金タイプを排除するための条件*/
 AND iol.MovementQty <> COALESCE(m.Qty,0)
 AND dt.IsSOTrx='N'