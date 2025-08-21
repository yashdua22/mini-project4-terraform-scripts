# ec2.tf
# EC2 Instance in VPC (public subnet)
# Uses Key Pair and Security Group
# Installs Apache, Python, Ansible, AWS CLI using User Data script

resource "aws_instance" "terraform_ec2" {
  ami           = "ami-0f8e81a3da6e2510a" # Ubuntu 22.04 LTS us-west-1 (update if needed)
  instance_type = "t2.micro"              # Free tier eligible
  subnet_id     = aws_subnet.public_sub01.id
  key_name      = aws_key_pair.terraform_kp.key_name
  vpc_security_group_ids = [aws_security_group.terraform_sg.id]

  tags = {
    Name = "terraform-created-ec201"
  }

  # User Data Script (runs on first boot)
  user_data = <<-EOF
  #!/bin/bash
  threshold1=80
  threshold2=60

  echo "***************** memory usage: *****************"
  free -m

  echo "***************** disk usage: *****************"
  df -h

  # Disk usage check
  df -h --output=pcent,target | tail -n +2 | while read line;
  do
      usage=$(echo $line | awk '{print $1}' | tr -d '%')
      mountpoint=$(echo $line | awk '{print $2}')

      if [ "$usage" -gt "$threshold1" ]
      then
          echo "**************** disk usage is high, restart instance! ALERT ******************"
      else
          echo "****************** disk usage is good ***********************"
      fi
  done

  # Memory usage check
  usage1=$(free -m | awk 'NR==2{printf "%.0f", $3*100/$2}')

  if [ "$usage1" -gt "$threshold2" ]
  then
      echo "************ memory usage is high, restart the instance! ALERT ************"
  else
      echo "************ memory usage is perfectly fine ***************"
  fi

  echo "************** current user: *****************"
  whoami

  echo "****************** current date and time: ************"
  date

  # Install Apache2
  echo "************** installing apache2 *************"
  apt update -y
  apt install apache2 -y
  if [ $? -eq 0 ]
  then
      echo "************** apache2 is installed **************"
      systemctl status apache2
  fi

  # Install Python3 + pip
  echo "************** installing python3, pip *************"
  apt install -y python3 python3-pip
  if [ $? -eq 0 ]
  then
      python3 --version
      pip3 --version
  fi

  # Install Ansible
  apt install ansible -y

  # Install AWS CLI
  snap install aws-cli --classic
  EOF
}
