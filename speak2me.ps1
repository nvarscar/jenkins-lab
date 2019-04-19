Param (
    [ValidateSet('Male','Female')]
    $Voice = 'Male',
    [ValidateNotNullOrEmpty()]
    $Phrase
)
$voices = @{
    Male = 'Microsoft David Desktop'
    Female = 'Microsoft Zira Desktop'
}
Add-Type -AssemblyName System.Speech
$speechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speechSynth.SelectVoice($voices[$Voice])
$speechSynth.Speak($Phrase)