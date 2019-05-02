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
Invoke-Pester @params
Pop-Location