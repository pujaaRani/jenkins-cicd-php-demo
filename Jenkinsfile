pipeline {
    agent any
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker_hub_credential')
    PROJECT_ID ='k8s-390611'
    CLUSTER_NAME ='php-deployment-cluster'
    LOCATION ='us-south1-a'
    CREDENTIALS_ID ='jenkins-docker-k8s'
    DOCKER_IMAGE_TAG = "${env.BUILD_ID}"
    }
    stages { 
       stage('GIT CLONE') {
            steps {
              git branch: 'main', credentialsId: 'Git_hub_cred', url: 'https://github.com/pujaaRani/jenkins-cicd-php-demo.git'
        }
       }    
        stage('BUILD DOCKER IMAGE') {
            steps{
                  sh ' docker build  -t pujamanish/php-app:$BUILD_ID .'
                  }
            }
        stage('LOGIN DOCKER-HUB') {
           steps {
             sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
       }
       
        stage('PUSH IMAGE TO DOCKERHUB') {
           steps {
             sh 'docker push pujamanish/php-app:$BUILD_ID'
            }
        }
        stage('APPROVAL FOR DEPLOYMENT ON K8S') {
           steps{
             timeout(time: 1, unit: 'HOURS') {
             input message: 'Do you want to deploy on K8S ?', submitter: 'admin'
                }
            }
         }
        stage('DEPLOY ON GKE CLUSTER') {
           steps{
			sh "sed -i 's/tagversion/${env.BUILD_ID}/g' kubernetes-manifest.yaml"
            step([$class: 'KubernetesEngineBuilder', 
                        projectId: env.PROJECT_ID,
                        clusterName: env.CLUSTER_NAME,
                        zone: env.LOCATION,
                        manifestPattern: 'kubernetes-manifest.yaml',
                        credentialsId: env.CREDENTIALS_ID,
                        verifyDeployments: true])
            }
        }
  }
    post {
        success {
            script {
                sh 'docker push pujamanish/php-app:$BUILD_ID'
            }
        }
    }
 }
