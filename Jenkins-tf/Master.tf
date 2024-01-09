
resource "aws_instance" "Kube_Master_server" {
  ami                    = "ami-0c7217cdde317cfec"   #change ami id for different region
  instance_type          = "t2.medium"
  key_name               = "mynewkey"
  vpc_security_group_ids = [aws_default_security_group.default_sg.id]
  subnet_id = aws_subnet.main.id
  user_data              = templatefile("./master.sh", {})

  tags = {
    Name = "Kube-Master-server"
  }

}

output "Kube_Master_server_public_ip" {
  value = aws_instance.Kube_Master_server.public_ip
}