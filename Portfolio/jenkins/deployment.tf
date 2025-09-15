resource "kubernetes_deployment" "jenkins" {
  metadata {
    name = "jenkins"
    labels = {
      app = "jenkins"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "jenkins"
      }
    }

    template {
      metadata {
        labels = {
          app = "jenkins"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.jenkins.metadata[0].name
        
        container {
          name  = "jenkins"
          image = "jenkins/jenkins:lts"

          port {
            container_port = 8080
          }

          port {
            container_port = 50000
          }

          volume_mount {
            name       = "jenkins-storage"
            mount_path = "/var/jenkins_home"
          }

          # New: Docker socket mount
          volume_mount {
            name       = "docker-sock"
            mount_path = "/var/run/docker.sock"
          }

           # New: Kubeconfig mount (for kubectl access)
          volume_mount {
            name       = "kube-config"
            mount_path = "/root/.kube"
          }
        }

        volume {
          name = "jenkins-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.jenkins_pvc.metadata[0].name
          }
        }
       # New: Docker socket
        volume {
          name = "docker-sock"
          host_path {
            path = "/var/run/docker.sock"
          }
        }
       # New: Kubeconfig
        volume {
          name = "kube-config"
          host_path {
            path = "/Users/palraj konar/.kube" # replace with your real path
          }
        }
      }
    }
  }
}