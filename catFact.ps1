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