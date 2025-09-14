resource "kubernetes_service" "website" {
  metadata {
    name      = "website-svc"
    namespace = var.website-NameSpace
  }

  spec {
    selector = {
      app = kubernetes_deployment.website.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }

    type = "NodePort"
  }
}
