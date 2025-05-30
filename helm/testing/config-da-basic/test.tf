# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
    }
  }
}

resource "kind_cluster" "demo" {
  name = "tfacc"
}

provider "helm" {
  kubernetes = {
    host                   = kind_cluster.demo.endpoint
    cluster_ca_certificate = kind_cluster.demo.cluster_ca_certificate
    client_certificate     = kind_cluster.demo.client_certificate
    client_key             = kind_cluster.demo.client_key
  }
}

resource "helm_release" "test-release" {
  name       = "test-hello"
  repository = "https://cloudecho.github.io/charts/"
  chart      = "hello"
}
