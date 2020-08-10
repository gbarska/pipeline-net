pipeline {

    agent any
    
  environment {
    registry = "gbarska/pipeline-project:$BUILD_TAG"
    registryCredential = 'gbarska-hub'
    dockerImage = ''
  }

    stages {
        stage('Build') {
            steps {
                sh '''
                    ./jenkins/build/net.sh
                '''
            }

            post {
                success {
                   archiveArtifacts artifacts: 'api/package/*', fingerprint: true
                }
            }
        }

          stage('Unit Tests') {
            steps {
                sh './jenkins/test/test.sh'
            }

            post {
                always {
                 step([$class: 'MSTestPublisher', failOnError: false, testResultsFile: 'Tests/test_results.trx']) 
                }
            }
        }

    stage('Build docker image') {
      steps{
        script {
          dockerImage =  docker.build(registry, "-f jenkins/build/Dockerfile api/") 
        }
      }
    }

    stage('Deploy docker Image') {
      steps{ 
          script {
              docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
                dockerImage.push('latest')
              }
          }
      }
      }
     
      stage('Deploy') {
        steps{
          echo "***************************"
          echo "** Deploying ***********"
          echo "***************************"

          withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'ssh-credentials', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME']]) {
                sh 'SSHPASS=$PASSWORD sshpass -e ssh $USERNAME@62.171.159.241 "/home/jenkins/jenkins-data/app/publish.sh"'
             }
        }
      }

       stage('Clean') {
        steps{
          echo "***************************"
          echo "** Cleaning ***********"
          echo "***************************"

           sh 'rm -rf api/package'
        }
      }
    }
}
