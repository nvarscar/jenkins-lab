param
(
	[string[]]$Path = '.',
	[string[]]$Tag
)
if ($PSScriptRoot) { $commandName = $MyInvocation.MyCommand.Name.Replace(".Tests.ps1", ""); $here = $PSScriptRoot }
else { $commandName = "_ManualExecution"; $here = (Get-Item . ).FullName }

#Run each module function
$params = @{
    Script = @{
        Path = $Path
    }
}
if ($Tag) {
	$params += @{ Tag = $Tag}
}
Push-Location $here
$results = Invoke-Pester @params -PassThru
Pop-Location

$failedcount = $results | Select-Object -ExpandProperty FailedCount | Measure-Object -Sum | Select-Object -ExpandProperty Sum
if ($failedcount -gt 0) {
	$faileditems = $results | Select-Object -ExpandProperty TestResult | Where-Object { $_.Passed -notlike $True }
	if ($faileditems) {
		Write-Warning "Failed tests summary:"
		$faileditems | ForEach-Object {
			$name = $_.Name
			[pscustomobject]@{
				Describe = $_.Describe
				Context  = $_.Context
				Name     = "It $name"
				Result   = $_.Result
				Message  = $_.FailureMessage
			}
		} | Sort-Object Describe, Context, Name, Result, Message | Format-List
		throw "$failedcount tests failed."
	}
}