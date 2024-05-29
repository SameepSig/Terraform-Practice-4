output "public_subnet_1" {
    value = aws_subnet.sameep_terraform_subnet_1.id
}

output "public_subnet_2" {
    value = aws_subnet.sameep_terraform_subnet_public_2.id
}