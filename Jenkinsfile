pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/hiessenberg/Portfolio.git'
            }
        }

        stage('Build & Push Image') {
            steps {
                sh 'docker build -t my-dockerhub-user/my-website:latest ./Portfolio'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'hiesenbergg', passwordVariable: 'Walterwhite@10')]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      docker push my-dockerhub-user/my-website:latest
                    '''
                }
            }
        }

        stage('Deploy with Terraform') {
            steps {
                sh '''
                  cd Portfolio-terraform/
                  terraform init -input=false
                  terraform apply -auto-approve -input=false
                '''
            }
        }
    }
}
