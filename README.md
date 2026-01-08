![MIKES DATA WORK GIT REPO](https://raw.githubusercontent.com/mikesdatawork/images/master/git_mikes_data_work_banner_01.png "Mikes Data Work")        

# Rebuid All FullText Indexes On Every Database With SQL
**Post Date: July 14, 2014** 





## Contents    
- [About Process](##About-Process)  
- [SQL Logic](#SQL-Logic)  
- [Author](#Author)  
- [License](#License)       

## About-Process

<p>Use this script to rebuild all FullText Indexes across every database. It would be wise to set this up as a repeated Job on a maintenance window. Remember; Standard Editions does not allow indexes to be rebuilt (online=on) so FTI's will be unavailable during the course of the rebuild. If you are using Enterprise Edition you could always incorporate with (online=on) as this is supported for Enterprise.</p>      


## SQL-Logic
```SQL
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
```
Hope this is useful. 


[![WorksEveryTime](https://forthebadge.com/images/badges/60-percent-of-the-time-works-every-time.svg)](https://shitday.de/)

## Author

[![Gist](https://img.shields.io/badge/Gist-MikesDataWork-<COLOR>.svg)](https://gist.github.com/mikesdatawork)
[![Twitter](https://img.shields.io/badge/Twitter-MikesDataWork-<COLOR>.svg)](https://twitter.com/mikesdatawork)
[![Wordpress](https://img.shields.io/badge/Wordpress-MikesDataWork-<COLOR>.svg)](https://mikesdatawork.wordpress.com/)

    
## License
[![LicenseCCSA](https://img.shields.io/badge/License-CreativeCommonsSA-<COLOR>.svg)](https://creativecommons.org/share-your-work/licensing-types-examples/)

![Mikes Data Work](https://raw.githubusercontent.com/mikesdatawork/images/master/git_mikes_data_work_banner_02.png "Mikes Data Work")

