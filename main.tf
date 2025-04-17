terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "web_server" {
  image = docker_image.nginx.image_id
  name  = "${var.student_name}-web-server"
  ports {
    internal = 80
    external = 9080
  }
  volumes {
    host_path      = "${path.cwd}/index.html"
    container_path = "/usr/share/nginx/html/index.html"
  }
}

variable "student_name" {
  description = "Your name for personalization"
  type        = string
}

output "container_url" {
  value = "http://localhost:8080"
}