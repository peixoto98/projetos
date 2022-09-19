provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "zabbix-key" {
    key_name = "zabbix-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzjz+rcIBu3PFfDZl6sn9rkxDS4/9aXEvuBiRDenjDRm0tAsQnvLnVSoWZx53/IDXmXNGKtXF0UghB+bfXLSf7UQoCOLb9EXHdRtkyxMqnf/C1QVN8H33/+nph7zz46FMiQWoo65lYDs1V6k3ra1yLq61krxRb1K+Uwle+b/ah3lhsN1mWD+qnQhlOA7rflLw1p3KP/oSq79wWGAAcrtMc94B4f71gy25j6cVelbb7GyUsADEUqxYjCYQFjSDLikyJ0irlFOg9wph89FsDsC7wbjal61m0jrxrYr1/4rppTP/rrGuBPHHAcgGVj+/IHr0IaJ4dAnZ0SnYjT7lKpFiqtzp518VzntmdMM3opL05Ygq4MGcN1sXLyNY5sjjP2c7gTr3MiIvp3P5eN65Ril7dVBng4XLJYXhvZMZXy9DhnqfvBp34MIKAze5FNzRo33o6o+n4hPwp02WZ12wmCLHynNqeETuHyor6M3BLTNzhe8ERX5LapxWneQV7lf0Ie60= root@aws"
}

resource "aws_security_group" "zabbix-sg" {
    
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

        ingress {
        from_port = 10050
        to_port = 10050
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

        ingress {
        from_port = 10051
        to_port = 10051
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

        ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
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

resource "aws_instance" "zabbix" {
    ami = "ami-06640050dc3f556bb"
    instance_type = "t2.micro"
    key_name = "zabbix-key"
    count = 1
    tags = {
        name = "zabbix"
    }
    security_groups = ["${aws_security_group.zabbix-sg.name}"]
}

resource "aws_instance" "database" {
    ami = "ami-06640050dc3f556bb"
    instance_type = "t2.micro"
    key_name = "zabbix-key"
    count = 1
    tags = {
        name = "database"
    }
    security_groups = ["${aws_security_group.zabbix-sg.name}"]
}

resource "aws_instance" "front" {
    ami = "ami-06640050dc3f556bb"
    instance_type = "t2.micro"
    key_name = "zabbix-key"
    count = 1
    tags = {
        name = "front"
    }
    security_groups = ["${aws_security_group.zabbix-sg.name}"]
}