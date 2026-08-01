provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket_seguro" {
  #checkov:skip=CKV_AWS_18: "Bucket logging no requerido en lab"
  #checkov:skip=CKV_AWS_144: "Replicacion no requerida en lab"
  #checkov:skip=CKV_AWS_145: "KMS no requerido en lab"
  #checkov:skip=CKV_AWS_21: "Versionado no requerido en lab"
  #checkov:skip=CKV2_AWS_6: "Public access block definido en recurso separado"
  bucket = "mi-bucket-devsecops-demo-12345"
}

resource "aws_s3_bucket_public_access_block" "publico" {
  bucket                  = aws_s3_bucket.bucket_seguro.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_security_group" "sg_seguro" {
  #checkov:skip=CKV_AWS_260: "Ingreso SSH restringido a segmento de red"
  name        = "sg_ssh_restringido"
  description = "Grupo de seguridad restringido para lab"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}
