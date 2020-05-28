<# 

.SYNOPSIS
	Purpose of this script is to report on a particular EventID which indicates issues with Windows Failover Clusters 

.DESCRIPTION
	Script was initially created to review the number of 1135 cluster errors that are reported into the system event log of the Exchange servers
	that are in a Database Available group (DAG).  A DAG sits atop of a failover cluster and if a DAG member experiences a 1135 error then all databases 
	that were active on the server will be moved to another member in the DAG.  
	
	Script can report to the screen the number of 1135 errors per server.  If required you can modify to output to a  CSV using standard methods.  

.ASSUMPTIONS
	Script is being executed with sufficient permissions to retrieve eventlog entries on the server(s) targeted. 

	You can live with the Write-Host cmdlets :) 

	You can add your error handling if you need it.  

	

.VERSION
  
	1.0  17-11-2014 -- Initial script released to the scripting gallery 





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

#>


$EventAge          = 90		# Defines how far back to search in the event logs
$EventIDToSearch   = 1135	# Defines the event log ID to search for.  In this case we want to look for EventID 1135
$Output = @() 

# Get a list of Exchange 2010 Mailbox servers and then sort the list so it is pretty.  
$ExchangeServers = Get-ExchangeServer | Where-Object {$_.AdminDisplayVersion -Match "^Version 14" -And $_.ServerRole -Match "Mailbox"} | Sort Name

# loop me baby! 
ForEach ($ExchangeServer IN  $ExchangeServers)
{

	Write-Host "Processing: " $ExchangeServer.name -ForeGroundColor Magenta 
	
	# Calculate the date to start searching from.  This is today's date minus the $EventAge 
	$SearchDate = (Get-Date) - (New-TimeSpan -Day $EventAge)

	# This is the main query.  A FilterHashTable is used rather than Where-Object which would be slower. 
	$Events = Get-WinEvent -ComputerName $ExchangeServer.Name -ErrorAction silentlycontinue -FilterHashtable @{logname='system'; ID=$EventIDToSearch; StartTime=$SearchDate}  
	
	# Display to the screen the number of matches on the current server.  Evaluating as an array.  
	(@($Events).count) -1 

	# Should the array have one or more entries, then we want to know about it.  
	IF (@($Events).count  -ge 1)
	{
		# Unrem this if you want to see the events written to the screen below each server
		#$Events | Select-Object TimeCreated, Id, Message | Format-Table -autosize


	# Add to final Output Variable
	$Output += $Events

}


Write-Host 

}


# Unrem this is you want to output to the screen. 
# $Output


# Exporting to CSV in the present directory.  
$Output  | Select -skip 1 | Export-CSV -path $PWD\Output.csv -NoTypeInformation -Force


