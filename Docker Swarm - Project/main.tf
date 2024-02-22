provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "swarm-key" {
    key_name = "swarm-key"
    public_key: <ID_RSA.PUB>
}

resource "aws_security_group" "swarm-sg" {
    
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
}

resource "aws_instance" "swarm-worker" {
    ami = "ami-0729e439b6769d6ab"
    instance_type = "t2.micro"
    key_name = "swarm-key"
    count = 2
    tags = {
        name = "swarm"
        type = "worker"
    }
    security_groups = ["${aws_security_group.swarm-sg.name}"]
}

resource "aws_instance" "swarm-master" {
    ami = "ami-0729e439b6769d6ab"
    instance_type = "t2.micro"
    key_name = "swarm-key"
    count = 1
    tags = {
        name = "swarm"
        type = "master"
    }
    security_groups = ["${aws_security_group.swarm-sg.name}"]
}
