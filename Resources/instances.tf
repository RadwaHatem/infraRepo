resource "aws_instance" "public-instance-1" {
  ami = var.AMI_ID

  instance_type = var.INSTANCE_TYPE

  tags = {
    
    Name = "public-instance-1"
  }

  subnet_id = module.my-network.pub_sub_1

  associate_public_ip_address          = true
  # user_data_replace_on_change = false
  key_name = aws_key_pair.terraformkey.id

  user_data_replace_on_change = true
  vpc_security_group_ids = [aws_security_group.first-sg.id]
  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install mongodb
                sudo systemctl start mongodb
                sudo systemctl enable mongodb
                sudo apt install -y apache2
                systemctl start apache2
                systemctl enable apache2
                echo "<h1> Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
                EOF
}




resource "aws_instance" "public-instance-2" {

  ami = var.AMI_ID

  instance_type = var.INSTANCE_TYPE

  tags = {

    Name = "public-instance-2"
  }

  key_name =  aws_key_pair.terraformkey.id
  associate_public_ip_address          = true

  # provisioner "local-exec" {
  #     command = "sed '8i ${self.public_ip}' ../ansible/inventory"
  # }

  user_data_replace_on_change = true
  subnet_id = module.my-network.pub_sub_2

  vpc_security_group_ids = [aws_security_group.first-sg.id]

  user_data = <<EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install mongodb
                sudo systemctl start mongodb
                sudo systemctl enable mongodb
                yum install -y apache2
                systemctl start apache2
                systemctl enable apache2
                echo "<h1> Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
                EOF

}


resource "aws_instance" "private-instance-1" {
  ami = var.AMI_ID

  instance_type = var.INSTANCE_TYPE

  tags = {

    Name = "private-instance-1"
  }

  subnet_id = module.my-network.priv_sub_1

  vpc_security_group_ids = [aws_security_group.second-sg.id]

  key_name = aws_key_pair.terraformkey.id

}


