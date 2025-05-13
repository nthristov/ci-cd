pipeline {
  agent any

  environment {
    GOOGLE_PROJECT = 'ci-cd-project-459615'
    PULUMI_HOME = "${env.HOME}/.pulumi"
    PATH = "${env.HOME}/.pulumi/bin:${env.PATH}"
  }

  stages {
    stage('Install Pulumi') {
      steps {
        sh '''
          echo "[*] Installing Pulumi..."
          curl -fsSL https://get.pulumi.com | bash
          pulumi version
        '''
      }
    }

    stage('Install Dependencies') {
      steps {
        sh '''
          echo "[*] Installing Node.js dependencies..."
          npm install
        '''
      }
    }

    stage('Pulumi Up') {
      steps {
        withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'GCP_KEY_FILE')]) {
          sh '''
            echo "[*] Setting up Google credentials..."
            export GOOGLE_APPLICATION_CREDENTIALS=$GCP_KEY_FILE

            echo "[*] Running Pulumi up..."
            pulumi login --local
            pulumi stack select dev || pulumi stack init dev
            pulumi up --yes
          '''
        }
      }
    }
  }

  post {
    failure {
      echo "🚨 Deployment failed!"
    }
    success {
      echo "✅ Pulumi deployment succeeded!"
    }
  }
}
