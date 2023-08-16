pipeline {
    agent any
    stages {        
        stage('Check Current Path') {
            agent { label 'master' }
            steps {
                sh '''hostname 
                      hostname -i 
                      pwd
                      ls -lrth
                      '''
            }
        }
        stage('Gitlab Checkout') {            
            agent { label 'master' }
            steps {                
                git branch: 'main',
                    credentialsId: 'mvn_project',
                    url: 'https://testdomainname.info/wocheon/mvn_project.git'
                sh 'ls -lrth'
            }
        }        
        stage('Build_Warfile') {            
            agent { label 'master' }
            steps {                
                sh '''
                    mvn clean package
                    cd target
                    mv test.war ROOT.war
                    ls -lrth 
                     '''
            }
        }                                
        stage('Build_Dockerfile') {            
            agent { label 'master' }
            steps {                
                sh '''
                    pwd
                    ls -lrth
                    docker build -t testdomainname.info:5050/wocheon/mvn_project .
                    docker image ls
                   '''
            }
        }
        stage('Push Dockerfile') {            
            agent { label 'master' }
            steps {                
                sh '''
                    docker image ls
                    docker push testdomainname.info:5050/wocheon/mvn_project
                   '''
            }
        }                                                
        stage('Pull Docker image') {
            agent { label 'slave' }
            steps {                
                sh '''
                   docker pull testdomainname.info:5050/wocheon/mvn_project
                   docker image ls                   
                   '''
                   script{ var1 =sh(script: 'docker container ls | grep mvn_test | wc -l', returnStdout: true).trim()
                   if(var1>=1){
                        sh "docker rm mvn_test -f"
                   }
                }
            }
        }        
        stage('Deploy') {
            agent { label 'slave' }
            steps {                
                sh '''
                   docker container ls
                   docker run -it -d -p 8080:8080 --name mvn_test testdomainname.info:5050/wocheon/mvn_project
                   '''
            }
        }
    }
}