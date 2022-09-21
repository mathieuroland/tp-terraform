terraform {
required_providers {
docker = {
source  = "kreuzwerker/docker"
version = "2.22.0"
}
}
}

provider "docker" {
host     = "ssh://tcom@10.10.0.104:22"
ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}
# Pulls the image
resource "docker_image" "ubuntu-sshd" {
  name = "rastasheep/ubuntu-sshd:latest"
}

# Create a container

resource "docker_container" "roland-proxy" {
  image = docker_image.ubuntu-sshd.image_id
  name  = "roland-proxy"
  ports {
    external = 11344
    internal = 22
  }
  ports {
    external = 12344
    internal = 80
  }
}

resource "docker_container" "roland-app1" {
  image = docker_image.ubuntu-sshd.image_id
  name  = "roland-app1"
  ports {
    external = 21344
    internal = 22
  }
  ports {
    external = 22344
    internal = 80
  }
}

resource "docker_container" "roland-app2" {
  image = docker_image.ubuntu-sshd.image_id
  name  = "roland-app2"
  ports {
    external = 31344
    internal = 22
  }
  ports {
    external = 3244
    internal = 80
  }
}
