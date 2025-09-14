terraform {
required_providers {
  kubernetes = {
     source = "hashicorp/kubernetes"
     version = "~> 2.27"
  }
 }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "docker-desktop"
}

resource "kubernetes_namespace" "ns" {
  metadata {
   name =  var.jenkins_pod_name
  }
}

resource "kubernetes_namespace" "website-ns" {
  metadata {
    name = var.website-NameSpace
  }
}

module "jenkins" {
  source = "./Jenkins"
}

module "Portfolio" {
  source = "./Portfolio"
}