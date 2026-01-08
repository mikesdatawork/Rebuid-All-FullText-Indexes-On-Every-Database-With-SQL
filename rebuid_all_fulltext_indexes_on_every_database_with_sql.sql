use master;
set nocount on
 
declare @rebuild_all_fti varchar(max)
set @rebuild_all_fti = ''
select @rebuild_all_fti = @rebuild_all_fti
+
'use [' + name + ']; '
+ char(10) +
'declare @rebuild_fti_'
+ cast(database_id as varchar(200)) + ' varchar(255)' + char(10) +
'set @rebuild_fti_'
+ cast(database_id as varchar(200)) + ' = '''''
+ char(10) +
'select @rebuild_fti_'
+ cast(database_id as varchar(200)) + ' = @rebuild_fti_' + cast(database_id as varchar(200)) + ' + '''
+ char(10) +
'alter fulltext catalog '' + sftc.name + '' rebuild; ''
+ char(10) + char(10)
from sys.fulltext_catalogs as sftc order by [name] asc'
+ char(10) +
'exec (@rebuild_fti_' + cast(database_id as varchar(200)) + ')' + char(10) + char(10)
from sys.databases where name not in ('master', 'model', 'msdb', 'tempdb') order by name asc
 
exec (@rebuild_all_fti) --for xml path(''), type
