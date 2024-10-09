output "private1" {
    value = aws_subnet.privates["private-1"].id 
}

output "private2" {
    value = aws_subnet.privates["private-2"].id 
}

output "public1" {
    value = aws_subnet.public-1["subnet-1"].id 
}

output "public2" {
    value = aws_subnet.public-1["subnet-2"].id 
}

output "vpcs" {
    value = aws_vpc.my_vpc.id
}

output "app-sg" {
  value = aws_security_group.app-sg.id
}