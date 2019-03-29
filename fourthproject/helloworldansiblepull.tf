# Provider Configuration for AWS
provider "aws" {
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
    inline = [
      "sudo yum install --enablerepo=epel -y ansible git",
      "sudo ansible-pull -U https://github.com/ash8454/ansible helloworld.yml -i localhost",
    ]
  }
}  
# IP address of newly created EC2 instance
output "myserver" {
  value="${aws_instance.myserver.public_ip}"
}