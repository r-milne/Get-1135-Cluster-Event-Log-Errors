# Get 1135 Cluster Event Log Errors
 Get 1135 Cluster Event Log Errors


.SYNOPSIS

Purpose of this script is to report on a particular EventID which indicates issues with Windows Failover Clusters

Please see this post for more details. 

https://blog.rmilne.ca/2014/11/19/retrieving-cluster-error-1135-from-servers/

 

.DESCRIPTION

Script was initially created to review the number of 1135 cluster errors that are reported into the system event log of the Exchange servers that are in a Database Available group (DAG).  A DAG sits atop of a failover cluster and if a DAG member experiences a 1135 error then all databases  that were active on the server will be moved to another member in the DAG. 
 
Script can report to the screen the number of 1135 errors per server.  If required you can modify to output to a  CSV using standard methods. 


.ASSUMPTIONS

Script is being executed with sufficient permissions to retrieve eventlog entries on the server(s) targeted.

 You can live with the Write-Host cmdlets :)

 You can add your error handling if you need it. 

 
.VERSION

 
1.0  17-11-2014 -- Initial script released to the scripting gallery

 

.AUTHOR

Rhoderick Milne  blog.rmilne.ca

 

.Disclaimer
This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment. 
THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE. 
We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and to reproduce and distribute the object code form of the Sample Code,
provided that You agree:
(i) to not use Our name, logo, or trademarks to market Your software product in which the Sample Code is embedded;
(ii) to include a valid copyright notice on Your software product in which the Sample Code is embedded; and
(iii) to indemnify, hold harmless, and defend Us and Our suppliers from and against any claims or lawsuits, including attorneys’ fees, that arise or result from the use or distribution of the Sample Code.
Please note: None of the conditions outlined in the disclaimer above will supercede the terms and conditions contained within the Premier Customer Services Description.
This posting is provided "AS IS" with no warranties, and confers no rights.

Use of included script samples are subject to the terms specified at http://www.microsoft.com/info/cpyright.htm.