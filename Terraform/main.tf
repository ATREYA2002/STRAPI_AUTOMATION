provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create SSH key pair locally
resource "tls_private_key" "strapi_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096

}

# Upload public key to AWS as EC2 Key Pair
resource "aws_key_pair" "strapi_key" {
  key_name   = "strapi_key_pair"
  public_key = tls_private_key.strapi_ssh.public_key_openssh
}

# Save the private key locally
resource "local_file" "private_key_pem" {

  content  = tls_private_key.strapi_ssh.private_key_pem
  filename = "${path.module}/strapi_key_pair.pem"
  file_permission = "0600"
  
}



# Security group resource that allows inbound traffic on port 80
resource "aws_security_group" "strapi_sg" {
  name        = "strapi_sg"
  description = "Allow inbound HTTP traffic on port 80"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from any IP address
  }
ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from any IP address
  }

ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP (you might want to restrict this to your IP)
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "strapi_instance" {
  ami           = "ami-053b0d53c279acc90"  #  # Ubuntu (us-east-1)
  instance_type = "t2.micro"  # Adjust the instance type if needed
   key_name      = aws_key_pair.strapi_key.key_name
  # Reference the user_data script from a separate file
  user_data = file("user_data.sh")

  # Security group that allows inbound HTTP traffic on port 80
  security_groups = [aws_security_group.strapi_sg.name]

  tags = {
    Name = "Strapi-EC2"
  }
}



