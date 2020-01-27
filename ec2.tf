provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "locoust" {
   ami = "ami-0d542ef84ec55d71c"
   instance_type = "t2.micro"
   key_name = "locust" 
    tags = {
    Name = "firsttag"
  }
    security_groups = [ "${aws_security_group.nags-sg-locoust.name}"]
}

resource "aws_security_group" "nags-sg-locoust" {
  name        = "nags-sg-locoust"
  ingress {
   
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["59.162.161.225/32"]
  }

ingress {
    # TLS (change to whatever ports you need)
    from_port   = 8085 
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
