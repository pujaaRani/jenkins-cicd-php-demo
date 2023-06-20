pipeline {
    agent any
    stages { 
       stage('GIT CLONE') {
            steps {
              git branch: 'main', credentialsId: 'af3bb9e4-fac6-45a5-9f97-f84a12608e3c', url: 'https://github.com/pujaaRani/jenkins-cicd-php-demo.git' 
        }
       }    
        stage('BUILD DOCKER IMAGE') {
            steps {
                sh ' docker build  -t pujamanish/php-app .'
                
            }
        }
        stage('PUSH DOCKER IMAGE') {
            steps {
                withCredentials([string(credentialsId: 'Docker_hub_password1', variable: 'Docker_hub_password1')]) {
                sh 'docker login -u pujamanish -p ${Docker_hub_password1}'
                }
                sh 'docker push pujamanish/php-app'
            }
        }
    }
}
