pipeline {
  agent {
    node {
      label 'windows'
    }
  }
  stages {
    stage('Install Pester Module') {
      steps {
        powershell 'if (!(Get-Module pester -ListAvailable)) { Install-Module pester -Repository PSGallery -Scope CurrentUser -Force }'
      }
    }
    stage('Run tests') {
      steps {
        powershell '& .\\tests\\ci.pester.ps1'
      }
    }
  }
}