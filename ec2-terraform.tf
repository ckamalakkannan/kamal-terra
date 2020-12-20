provider "aws" {
   region = "us-east-1"
   access_key = "your access key"
   secret_key = "your secret key"
}
resource "aws_instance" "name" {
  ami           = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  key_name = "te-kamal"
  user_data = <<-EOF
		            #! /bin/bash
                    sudo yum update -y
                    sudo yum install -y git docker
                    sudo systemctl start docker
                    sudo systemctl enable docker
                    sudo curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
                    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
                    sudo yum upgrade
                    sudo yum install -y jenkins java-1.8.0-openjdk-devel
                    sudo systemctl daemon-reload
                    sudo systemctl start jenkins
                    sudo systemctl enable jenkins
	            EOF
  tags = {
    Name = "ec2-server-name"
  }

}

resource "aws_security_group" "server-sg" {
    name        = "server-sg"
}
