Start-Transcript -Path .\servicePage.log
$headers = @"
<style>
table {
    border: 3px solid #000000;
    background-color: #7B6BEE;
    width: 100%;
    text-align: left;
    border-collapse: collapse;
  }
  table td, table th {
    border: 1px solid #000000;
    padding: 5px 4px;
  }
  table td {
    font-size: 13px;
  }
  table tr:nth-child(even) {
    background: #9D9CF5;
  }
  table th {
    font-size: 15px;
    font-weight: bold;
    color: #000000;
    text-align: left;
  }
</style>
"@
Write-Host "Generating service page"
Get-Service | Select-Object Status, Name, DisplayName | ConvertTo-Html -Head $headers | Set-Content .\services.htm
Write-Host "Generating process page"
Get-Process | Select-Object Name, TotalProcessorTime, WorkingSet  | ConvertTo-Html -Head $headers | Set-Content .\processes.htm
Stop-Transcript