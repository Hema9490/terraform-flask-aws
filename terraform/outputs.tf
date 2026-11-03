output "app_url" {
  description = "Open this link in your browser (wait 2-3 minutes after apply)"
  value       = "http://${aws_instance.web.public_ip}"
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
