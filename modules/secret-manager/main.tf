variable "policy-for-sm" {
  default = <<POLICY
				{
					"Version": "2012-10-17",
					"Statement": [
						{
							"Sid": "ConfigureAllPermissions",
							"Effect": "Allow",
							"Principal": {
								"AWS": "*"
							},
							"Action": "secretsmanager:GetSecretValue",
							"Resource": "*",
               "Condition" : {
                  "StringEquals" : {
                      "aws:ResourceTag/Env": "$${aws:PrincipalTag/Envide}"
                  }
						    }
            }
					]
				}
				POLICY
}

resource "aws_secretsmanager_secret" "secrets" {
  for_each                = var.SECRETS_LIST
  name                    = "SM-${each.key}"
  description             = lookup(each.value, "description", null)
  policy                  = var.policy-for-sm
  recovery_window_in_days = 0

  tags = {
    Name        = "SM-${each.key}"
    Env         = "Prod" 
    CreatedByTerraform   = true
  }
}

resource "aws_secretsmanager_secret_version" "sm-version" {
  for_each      = { for k, v in var.SECRETS_LIST : k => v }
  secret_id     = "SM-${each.key}"
  secret_string = jsonencode(lookup(each.value, "secret_key_value", {}))
  depends_on    = [aws_secretsmanager_secret.secrets]
}  