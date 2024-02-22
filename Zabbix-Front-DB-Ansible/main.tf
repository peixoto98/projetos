provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "zabbix-key" {
    key_name = "zabbix-key"
    public_key = <ID_RSA.PUB>
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
