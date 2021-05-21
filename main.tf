provider "aws" {
    region = "us-east-1"
    version = "~> 2.61.0"
}

resource "aws_instance" "web-server" {
    ami = "ami-03543ffh543ui"
    instance_type = "t2.micro"
    key_name = "ssh_key_created_and_loaded_in_aws_key_pairs"
    # attach to security group
    security_groups = [aws_security_group.security-web-server.name]
    tags = {
      "Name" = "WebserverByTF"
    }
      
}

resource "aws_security_group" "security-web-server" {
    name = "Web-security-Group"
    description = "Allow access to web server"
    ingress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "Allow SSH"
      from_port = 22
      ipv6_cidr_blocks = [ "value" ]
      prefix_list_ids = [ "value" ]
      protocol = "tcp"
      security_groups = [ "value" ]
      self = false
      to_port = 22
    } ]
  
}

# think of this as return value. This will return the public dns
# for the created resource which is an EC2 instance
output "instance_public_dns" {
    value = aws_instance.web-server.public_dns
}