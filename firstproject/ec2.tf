

# Provider Configuration for AWS
provider "aws" {
    access_key = "<>"
    secret_key = "<>"
    region = "us-east-1"
}

#Resource Configuration for AWS
resource "aws_instance" "myserver" {
    ami = "ami-0080e4c5bc078760e"
    instance_type="t2.micro"
    key_name="EffectiveDevOpsAWS"
    vpc_security_group_ids= ["sg-07b0b6fc8ddd68aa3"]
    tags {
        Name = "helloworld"
    }
}   

# # Helloworld Appication code
# provisioner "remote-exec" {
#     connection {
#         user = "ec2-user"
#         private_key = "${file("/root/.ssh/EffectiveDevOpsAWS.pem")}"
#     }
#     inline = [
#         "sudo yum install --enablerepo=epel -y nodejs",
#         "sudo wget https://raw.githubusercontent.com/yogeshraheja/Effective-DevOps-with-AWS/master/Chapter02/helloworld.js -O /home/ec2-user/helloworld.js",
#         "sudo wget https://raw.githubusercontent.com/yogeshraheja/Effective-DevOps-with-AWS/master/Chapter02/helloworld.conf -O /etc/init/helloworld.conf",
#         "sudo start helloworld",
#         ]
#     }
# }
