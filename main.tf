provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "swarm-key" {
    key_name = "swarm-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzjz+rcIBu3PFfDZl6sn9rkxDS4/9aXEvuBiRDenjDRm0tAsQnvLnVSoWZx53/IDXmXNGKtXF0UghB+bfXLSf7UQoCOLb9EXHdRtkyxMqnf/C1QVN8H33/+nph7zz46FMiQWoo65lYDs1V6k3ra1yLq61krxRb1K+Uwle+b/ah3lhsN1mWD+qnQhlOA7rflLw1p3KP/oSq79wWGAAcrtMc94B4f71gy25j6cVelbb7GyUsADEUqxYjCYQFjSDLikyJ0irlFOg9wph89FsDsC7wbjal61m0jrxrYr1/4rppTP/rrGuBPHHAcgGVj+/IHr0IaJ4dAnZ0SnYjT7lKpFiqtzp518VzntmdMM3opL05Ygq4MGcN1sXLyNY5sjjP2c7gTr3MiIvp3P5eN65Ril7dVBng4XLJYXhvZMZXy9DhnqfvBp34MIKAze5FNzRo33o6o+n4hPwp02WZ12wmCLHynNqeETuHyor6M3BLTNzhe8ERX5LapxWneQV7lf0Ie60= root@aws"
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
