variable "repertoire" {
  type = string
  default = "/home/vm1/Desktop"
}

resource "local_file" "file" {
  content = "File created with Terraform !"
  filename = "${var.repertoire}/file.txt"
}

resource "local_file" "file_1" {
    filename = "file_1.txt"
    content = "C'est un chemin : ${var.repertoire}"
}

output "sortie_ressource" {
  value = local_file.file.content
}