UPDATE adempiere.ad_column
   SET AD_Reference_ID=30,IsAllowLogging='N'
 WHERE ColumnName='AD_Client_ID';
 
 --AD_Clientテーブルは更新除外する
