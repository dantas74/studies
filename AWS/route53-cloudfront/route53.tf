resource "aws_route53domains_registered_domain" "this" {
  domain_name = "this.com"

  name_server {
    name = "ns-195.awsdns-24.com"
  }

  name_server {
    name = "ns-874.awsdns-45.net"
  }
}

resource "aws_route53_zone" "this" {
  name = "this.com"
}

resource "aws_route53_record" "this" {
  name    = "www"
  type    = "A"
  zone_id = "aws_route53_zone.this.id"
  ttl     = 300
  records = ["74.74.74.74/32"]
}
