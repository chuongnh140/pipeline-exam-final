pipeline {

    agent any

    parameters {
      choice(
        name: 'APP_BUILD',
        choices: "NodeJS\nPython\nAll",
        description: 'Choose your answer to build' )
    }

    stages
    {
      stage('Build App')
      {
        steps {
          script {
            if (params.APP_BUILD == "NodeJS") {
              sh """
                    echo 'NodeJS is building...'
                    ./nodejs/build.sh ${env.BUILD_ID}
                    """
            }
            else if (params.APP_BUILD == "Python") {
              sh """
                    echo "Python is building..."
                    ./python/build.sh ${env.BUILD_ID}
                    """
            }
            else{
              sh '''
                    echo "Starting build Python_App and Nodejs_APP"
                    ./build-both.sh
                    '''
            }
          }
        }
      }
      stage('Deploy to machine') {
        agent {label 'docker-machine'}
        steps {
          script {
            if (params.APP_BUILD == "NodeJS") {
              sh '''
                    echo "NodeJS is deploying..."
                    ./nodejs/deploy.sh
                    '''
            }
            else if (params.APP_BUILD == "Python") {
              sh '''
                    echo "Python is deploying..."
                    ./python/deploy.sh
                    '''
            }
            else{
              sh '''
                    echo "Starting deploy Python_App and Nodejs_APP"
                    ./deploy-both.sh
                    '''
            }
          }
        }
      }
    }
    post {
      success {
        echo "SUCCESSFUL nha man"
      }
      failure {
        echo "FAILED roi kia"
      }
    }
}
