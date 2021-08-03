provider "aws" {
  access_key = "AKIAQ7ZF4UHTTCIIOR4B"
  secret_key = "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"
  region     = "eu-central-1"
}

resource "aws_key_pair" "terraform" {
  key_name   = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCLpc47uP0MIQ3/GCCUpTm9Qq5HvadcYECNdgTW+xvahTyjgIpZ8I0g8GxUo04G+0ohritL1S45UhHUHAmV8+EM68vF6PxCQbHfolwOT/66XG5Kwm1fhr00lR5f+bGIcnmQPxeN5aTgflyatd77XOJA+vwjz9Mv+5yjzFHgMMGKrtnCPrJNK3Ck6mYHA0aYjK9wnWtZkFUxpM4WfRCkJLS8EASuWI8rLud/7l3nE/EDLhi+KID/Gf/xReS8j68wOeuhJHsl9R5JNGuysH7BKsXcOzifN/dUYpFOxyDj0IuJq5Gv/POQHj6KnLozEnSHeu+0AAaXFTxBe2M0ldPUW4yBjJF7jKQyvFmE1e2pvdfbO8v5FM+ksLtT/1dqkzdE8938ql9Wbks23Eov/rzyEyFk4FC9QE6MgQ1dmnExE3OMAAsMrYDDQ5fDSJK4O/p8bkYjP52A/tay+XTKQuTgZrooN6GiR3mSDg0YbdaRbgnMi763TpHm4epuxwbpVwGvmk= zinchi@ubuntu"
}
resource "aws_instance" "lamp"{
  ami             = "ami-05f7491af5eef733a"
  instance_type   = "t2.micro"
  user_data       = file("lamp.sh")
  security_groups = ["web-servers", "allow_ssh"]
  key_name        = "terraform"
}

#tags = {
#   Name = "LAMP"
 #}

resource "aws_security_group" "allow_ssh" {
 name        = "allow_ssh"
 description = "Allow SSH inbound traffic"

 ingress {
   description      = "SSH"
   from_port        = 22
   to_port          = 22
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
 }
 egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
 }

 tags = {
   Name = "allow inbound SSH"
 }
}

resource "aws_security_group" "web-servers" {
 name        = "web-servers"
 description = "Allow HTTP/S inbound traffic"

 ingress {
   description      = "HTTPS"
   from_port        = 443
   to_port          = 443
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
 }

 ingress {
   description      = "HTTP"
   from_port        = 80
   to_port          = 80
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
 }

 egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
 }

 tags = {
   Name = "allow_ufw_to_lamp"
 }
}
