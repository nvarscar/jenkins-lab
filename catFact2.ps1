Param (
    $Path = ".\catFact2.ini"
)
$catFact = (Invoke-WebRequest -Uri https://catfact.ninja/fact -UseBasicParsing).Content | ConvertFrom-Json
"Phrase=Did you know? $($catFact.fact)" | Set-Content -Path $Path -Encoding Ascii