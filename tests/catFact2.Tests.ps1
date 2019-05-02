Describe "CatFact2 tests" {
    Context "Should return a cat fact" {
        Mock -CommandName Invoke-WebRequest -MockWith {
            [pscustomobject]@{
                Content = '{"fact": "This is a fact"}'
            }
        }
        $factFile = "$TestDrive\catFact2.ini"
        It "should create a catFact2.ini file" {
            & ..\catFact2.ps1 -Path $factFile
            $factFile | Should -Exist
            $factFile | Should -FileContentMatchExactly "Phrase\=Did you know\? This is a fact"
        }
    }
}