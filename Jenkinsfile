pipeline {
    agent any
    stages {
        stage('** CLONING CODE  **') {
            steps {
                git branch: 'main', credentialsId: 'af3bb9e4-fac6-45a5-9f97-f84a12608e3c', url: 'https://github.com/pujaaRani/jenkins-cicd-php-demo.git'
            }
        }
         stage('** PHP APP DEPLOYMENT ON APACHE SERVER**') {
            steps {
                input 'Do yo want to deploy on staging environment ?'
                sshPublisher(publishers: [sshPublisherDesc(configName: 'php-deployment-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html/', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/*.php')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                archiveArtifacts artifacts: '**/*.php', followSymlinks: false
            }
        }
        stage('ADMIN APPROVAL') {
            steps {
                
                sshPublisher(publishers: [sshPublisherDesc(configName: 'php-deployment-server', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html/app/', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/*.php')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                echo"Admin Approval For Deployment On Production Server"
                timeout(time: 1, unit: 'HOURS') {
                input message: 'Do you want to deploy on production?', submitter: 'admin'
                }
                
            }
        }
    }

