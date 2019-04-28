# Original idea by John Allers: https://gist.github.com/johnallers/178576f097a8a7986fcb17a92c88a486
Param (
    [ValidateSet('Male','Female')]
    $Voice = 'Male'
)
$voices = @{
    Male = 'Microsoft David Desktop'
    Female = 'Microsoft Zira Desktop'
}
Add-Type -AssemblyName System.Speech
$speechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speechSynth.SelectVoice($voices[$Voice])
$catFact = (Invoke-WebRequest -Uri https://catfact.ninja/fact -UseBasicParsing).Content | ConvertFrom-Json
$speechSynth.Speak("did you know?")
$speechSynth.Speak($catFact.fact)