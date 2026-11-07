
terraform {
    required_providers {
        docker = {
        source  = "kreuzwerker/docker"
        version = "~> 3.0.1"
        }
    }
}

provider "docker" {
    host = "npipe:////./pipe/docker_engine"
}

data "docker_registry_image" "nginx" {
    name = "bubbaj/it4200-fall-2026:latest"
}

resource "docker_image" "nginx" {
    name          = data.docker_registry_image.nginx.name
    pull_triggers = [data.docker_registry_image.nginx.sha256_digest]
    keep_locally  = false
}

resource "docker_container" "nginx" {
    image = docker_image.nginx.image_id
    name  = "tutorial"

    ports {
        internal = 80
        external = 8000
    }
}
