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