resource "kubernetes_deployment" "website" {
  metadata {
    name      = "website"
    namespace = var.website-NameSpace
    labels = {
      app = "website"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "website"
      }
    }

    template {
      metadata {
        labels = {
          app = "website"
        }
      }

      spec {
        container {
          name  = "portfolio"
          image = "my-dockerhub-user/my-website:latest"   # Jenkins will update/push this image
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
