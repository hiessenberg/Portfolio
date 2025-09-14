resource "kubernetes_service" "jenkins_service" {
  metadata {
    name = "jenkins"
  }

  spec {
    selector = {
      app = "jenkins"
    }

    port {
      name        = "http" 
      port        = 8080
      target_port = 8080
      node_port   = 30080
    }

    port {
      name        = "jnlp"
      port        = 50000
      target_port = 50000
      node_port   = 30050
    }

    type = "NodePort"
  }
}