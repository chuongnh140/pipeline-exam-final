pipeline {

    agent any

    parameters {
      choice(
        name: 'APP_BUILD',
        choices: "NodeJS\nPython\nAll",
        description: 'Choose your answer to build'
        )
    }

    stages {
      scrtps {
        if (params.APP_BUILD == "NodeJS") {
            stage('NodeJS') {
                steps {
                    sh "echo NodeJS"
                      }
             }
           }
          else if (params.APP_BUILD == "Python") {
              stage('Python') {
                steps {
                    sh "echo Python"
                      }
              }
          }
          else  {
            stage('All') {
              steps {
                sh "echo All"
                   }
            }
          }
      }
  }
}
