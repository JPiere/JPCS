UPDATE adempiere.ad_column
   SET AD_Reference_ID=30,IsAllowLogging='N'
 WHERE ColumnName='UpdatedBy' or ColumnName='CreatedBy';
