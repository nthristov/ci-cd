pipeline {
  agent any

  environment {
    GOOGLE_PROJECT = 'ci-cd-project-459615'
  }

  stages {
    stage('Install Pulumi') {
      steps {
        sh '''
          curl -fsSL https://get.pulumi.com | sh
          export PATH=$PATH:/root/.pulumi/bin
          pulumi version
        '''
      }
    }

    stage('Install Node.js Dependencies') {
      steps {
        sh '''
          npm install
        '''
      }
    }

    stage('Pulumi Up') {
      steps {
        withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'GCP_KEY_FILE')]) {
          sh '''
            export PATH=$PATH:/root/.pulumi/bin
            export GOOGLE_APPLICATION_CREDENTIALS=$GCP_KEY_FILE

            pulumi login --local
            pulumi stack select dev || pulumi stack init dev
            pulumi up --yes
          '''
        }
      }
    }
  }
}

