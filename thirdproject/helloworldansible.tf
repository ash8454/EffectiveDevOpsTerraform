# Provider Configuration for AWS
provider "aws" {
    # access_key = "<>"
    # secret_key = "<>"
    region = "us-east-1"
}

# Resource Configuration for AWS
resource "aws_instance" "myserver" {
    ami = "ami-0080e4c5bc078760e"
    instance_type="t2.micro"
    key_name="EffectiveDevOpsAWS"
    vpc_security_group_ids= ["sg-07b0b6fc8ddd68aa3"]
    tags {
        Name = "helloworld"
    }

# Provisioner for applying ansible playbook
  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      private_key = "${file("/Users/tulachanashok/.ssh/EffectiveDevOpsAWS.pem")}"
    }
  }

  provisioner "local-exec" {
    command = "sudo echo '${self.public_ip}' > ./myinventory",
  }
  provisioner "local-exec" {
        command = "sudo ansible-playbook -i myinventory --private-key=/Users/tulachanashok/.ssh/EffectiveDevOpsAWS.pem helloworld.yml",
  }
}
   
# IP address of newly created EC2 instance
output "myserver" {
  value="${aws_instance.myserver.public_ip}"
}