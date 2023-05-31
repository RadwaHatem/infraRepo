resource "aws_instance" "bastion-host" {
  ami = var.AMI_ID

  instance_type = var.INSTANCE_TYPE

  tags = {
    
    Name = "bastion-host"
  }

  provisioner "local-exec" {

    command = "echo ${self.public_ip} > ../ansible/inventory.yml"
  }

  subnet_id = module.my-network.pub_sub_1
  associate_public_ip_address          = true
#   user_data_replace_on_change = false
  key_name = aws_key_pair.terraformkey.id
  vpc_security_group_ids = [aws_security_group.first-sg.id]

  depends_on = [ aws_eks_cluster.eks-cluster]

  user_data = <<-EOF
              #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y ca-certificates curl 
                sudo apt-get install -y apt-transport-https
                sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
                echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
                sudo apt-get update
                VERSION=1.25.0-00
                sudo apt-get install -y kubectl=$VERSION
                apt install kubelet kubeadm kubectl -y
                sudo apt install unzip -y 
                sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.8.9.zip" -o "awscliv2.zip"
                sudo unzip awscliv2.zip
                sudo snap install kubectl --classic
                sudo ./aws/install
                echo "export PATH=$PATH:/usr/bin/kubectl" >> ~/.bashrc
                source ~/.bashrc
                sudo mkdir /home/ubuntu/.aws/
                sudo touch /home/ubuntu/.aws/credentials
                echo "[default]" > /home/ubuntu/.aws/credentials
                echo "aws_access_key_id = ${var.ACCESS_KEY}" >> /home/ubuntu/.aws/credentials
                echo "aws_secret_access_key = ${var.SECRET_ACCESS_KEY}" >> /home/ubuntu/.aws/credentials
                sudo apt install docker.io
                sudo chmod 666 /var/run/docker.sock
                sudo apt-add-repository -y ppa:ansible/ansible
                sudo apt-get -y install ansible
                aws eks update-kubeconfig --region eu-central-1 --name my-eks-cluster
             EOF



}
