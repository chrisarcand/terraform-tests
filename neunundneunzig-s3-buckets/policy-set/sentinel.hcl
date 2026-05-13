policy "cloudtrail-encryption-must-be-enabled" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy/cloudtrail-encryption-must-be-enabled.sentinel?checksum=sha256:274a8b6a3b18d9f5acacda195c2cff39351c5b3a1283ed2f1192f143b6d213ac"
  enforcement_level = "advisory"
}
policy "s3-should-have-encryption-enabled" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy/s3-should-have-encryption-enabled.sentinel?checksum=sha256:0b7d6e0e010e019c969101244d6de952da94590e98a7704af7a06f823cf3f1ce"
  enforcement_level = "advisory"
}
policy "rds-must-be-encrypted" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy/rds-must-be-encrypted.sentinel?checksum=sha256:5da1e10acd4d74e774105d01ded4db77dd4f3ef342c9ae9b5418e527006cd977"
  enforcement_level = "advisory"
}
policy "elasticsearch-domains-encryption-must-be-enabled" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy/elasticsearch-domains-encryption-must-be-enabled.sentinel?checksum=sha256:8945518ff2a287a6eadda63a7e2fab2a6c3b48c546ca92f86638b70f42958dbb"
  enforcement_level = "advisory"
}
policy "efs-filesystem-should-have-encryption-enabled" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy/efs-filesystem-should-have-encryption-enabled.sentinel?checksum=sha256:5e2d67fabdf0763028b88dbde8d6b3f52328a2d328b96381baad522bb48732b2"
  enforcement_level = "advisory"
}
policy "ebs-volume-must-be-encrypted" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy/ebs-volume-must-be-encrypted.sentinel?checksum=sha256:c7ad02e59b3214ea94770c82ca8c6443ad0e8e0ba24652ebb52fc6e5556e2e61"
  enforcement_level = "advisory"
}
policy "ecs-service-should-not-have-public-ip" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy/ecs-service-should-not-have-public-ip.sentinel?checksum=sha256:0b7d6e0e010e019c969101244d6de952da94590e98a7704af7a06f823cf3f1ce"
  enforcement_level = "advisory"
}
policy "deny-public-rdp-acl-rules" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/aws-networking-terraform/1.0.1/policy/deny-public-rdp-acl-rules.sentinel?checksum=sha256:b301e80bd612809aeeac263b5d4b5b22b9f84190da67216cc298a96652301086"
  enforcement_level = "advisory"
}
policy "deny-public-ssh-acl-rules" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/aws-networking-terraform/1.0.1/policy/deny-public-ssh-acl-rules.sentinel?checksum=sha256:b56a7869c9ddd2bece7de8d251de106e072407207247e6f94e001b6eba22c71b"
  enforcement_level = "advisory"
}
policy "restrict-all-vpc-traffic-acl-rules" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/aws-networking-terraform/1.0.1/policy/restrict-all-vpc-traffic-acl-rules.sentinel?checksum=sha256:b58e49dbd2e4795481c4af970aaf6dc883bdf5b6fb9cb47e331aa44883e8301d"
  enforcement_level = "advisory"
}
policy "cloudtrail-bucket-access-logging-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/cloudtrail-bucket-access-logging-enabled.sentinel?checksum=sha256:caeb199c37280e281f43d49ac43b4379683093d2ba0783b0c5002af326313fac"
  enforcement_level = "advisory"
}
policy "cloudtrail-cloudwatch-logs-group-arn-present" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/cloudtrail-cloudwatch-logs-group-arn-present.sentinel?checksum=sha256:0704df994efe8182b0362c4c3ad6c72ff34b743cfcfc728107b44cd94a3197e0"
  enforcement_level = "advisory"
}
policy "cloudtrail-log-file-validation-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/cloudtrail-log-file-validation-enabled.sentinel?checksum=sha256:bfe2c3f6212a74d24e2f50d13a55eada5277183ac4b3dca1a8b3d96132ed8bb5"
  enforcement_level = "advisory"
}
policy "cloudtrail-logs-bucket-not-public" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/cloudtrail-logs-bucket-not-public.sentinel?checksum=sha256:4976039990c97d4d94e7811f8e04a02f425660ee7aeed595363facfa5ff61edd"
  enforcement_level = "advisory"
}
policy "cloudtrail-server-side-encryption-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/cloudtrail-server-side-encryption-enabled.sentinel?checksum=sha256:907936e6bc842121bb07885d150f0b55bf68f52feca30577f5d3a0aa311e5bf5"
  enforcement_level = "advisory"
}
policy "ec2-ebs-encryption-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-ebs-encryption-enabled.sentinel?checksum=sha256:56e3f7d56d2fb97d5a66ccd239e834cf337aa5f9794aa31de372e0d64851cb5f"
  enforcement_level = "advisory"
}
policy "ec2-metadata-imdsv2-required" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-metadata-imdsv2-required.sentinel?checksum=sha256:a2f841b0368354f48ca89a9d399b26c9eab0f5cb2e982e79889297da81c8810e"
  enforcement_level = "advisory"
}
policy "ec2-network-acl" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-network-acl.sentinel?checksum=sha256:43b60299fc59d74ea26efc5be489262f72bb0109069fd7811846a283c9842957"
  enforcement_level = "advisory"
}
policy "ec2-security-group-ingress-traffic-restriction-port-22" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-security-group-ingress-traffic-restriction-port-22.sentinel?checksum=sha256:e2e59ace19249122d460883630dbb8ed1fa134f34258db2338ad286be01cda37"
  enforcement_level = "advisory"
}
policy "ec2-security-group-ingress-traffic-restriction-port-3389" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-security-group-ingress-traffic-restriction-port-3389.sentinel?checksum=sha256:e2e59ace19249122d460883630dbb8ed1fa134f34258db2338ad286be01cda37"
  enforcement_level = "advisory"
}
policy "ec2-security-group-ipv4-ingress-traffic-restriction" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-security-group-ipv4-ingress-traffic-restriction.sentinel?checksum=sha256:9ceeac12b54465b5038f91843a6334eafd4f0fc7aa9b58bead7a9154fdc56488"
  enforcement_level = "advisory"
}
policy "ec2-security-group-ipv6-ingress-traffic-restriction" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-security-group-ipv6-ingress-traffic-restriction.sentinel?checksum=sha256:9ceeac12b54465b5038f91843a6334eafd4f0fc7aa9b58bead7a9154fdc56488"
  enforcement_level = "advisory"
}
policy "ec2-vpc-default-security-group-no-traffic" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-vpc-default-security-group-no-traffic.sentinel?checksum=sha256:65f4856be6130099821b0f6a7a14bdb0115b9e6f38b5628651f21161b844940b"
  enforcement_level = "advisory"
}
policy "ec2-vpc-flow-logging-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/ec2-vpc-flow-logging-enabled.sentinel?checksum=sha256:7aee2ad1983c99cac093f744f367c54a1eafdc32142d6eedc076a1cecf47a03c"
  enforcement_level = "advisory"
}
policy "efs-encryption-at-rest-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/efs-encryption-at-rest-enabled.sentinel?checksum=sha256:d9e55a187f0d352d4664665f5d366115e6819c5af55d6d067572a20b5dba5124"
  enforcement_level = "advisory"
}
policy "iam-no-admin-privileges-allowed-by-policies" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-no-admin-privileges-allowed-by-policies.sentinel?checksum=sha256:36d8724432511237fa37f35e91d0af80150c7e7c11dfe50deaa4bc1dbfe7dafc"
  enforcement_level = "advisory"
}
policy "iam-no-policies-attached-to-users" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-no-policies-attached-to-users.sentinel?checksum=sha256:4521dee273aa0b94fe2cb4fdf17a47b48ca8759bb8671e7cfb74f8409cf9a648"
  enforcement_level = "advisory"
}
policy "iam-password-expiry" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-password-expiry.sentinel?checksum=sha256:c92aaf81e0f671a5da431d2039c3a243e704c7661a8eea526e71fe27be67a45a"
  enforcement_level = "advisory"
}
policy "iam-password-length" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-password-length.sentinel?checksum=sha256:58a6f1b48f93c8fb5fe37b0bcdaaafbf90877382af6a2651bd2b8d8e65f4f901"
  enforcement_level = "advisory"
}
policy "iam-password-lowercase" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-password-lowercase.sentinel?checksum=sha256:d97d7c3f158eafc27d5fc592aea937ad630ca2dd0437f779a2a82469754bbe42"
  enforcement_level = "advisory"
}
policy "iam-password-numbers" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-password-numbers.sentinel?checksum=sha256:3fd173488237d6642e4f34544aa7d69ae44262fd1ad4aaee661b9c7c87f1bded"
  enforcement_level = "advisory"
}
policy "iam-password-reuse" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-password-reuse.sentinel?checksum=sha256:66ecbf8c7ed7e50c1ab0366c40e317e93c82343d614ff43347e675cb26d6c8af"
  enforcement_level = "advisory"
}
policy "iam-password-symbols" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-password-symbols.sentinel?checksum=sha256:c106745e65de5037ae30428dca54ef71cdc9b5cfa7c0f6fc98de18a52dd5e705"
  enforcement_level = "advisory"
}
policy "iam-password-uppercase" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/iam-password-uppercase.sentinel?checksum=sha256:12684ed1196069a0feccf4c1e515af74b673a9c2ebecf5c2b6c6c21487b6c1c3"
  enforcement_level = "advisory"
}
policy "kms-key-rotation-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/kms-key-rotation-enabled.sentinel?checksum=sha256:8713b66adb10e31d7d95ef5c5ec63ec9a9da63234984c13b8a6406fe9706b9e4"
  enforcement_level = "advisory"
}
policy "rds-encryption-at-rest-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/rds-encryption-at-rest-enabled.sentinel?checksum=sha256:b7fe7ef6612e2f12e6f6bf0e7776309b095c96e132e2da59ce437ee02035d7c4"
  enforcement_level = "advisory"
}
policy "rds-minor-version-upgrade-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/rds-minor-version-upgrade-enabled.sentinel?checksum=sha256:7453f72c3b59afc73f1cf4546894798f19dc8f516a87b1681d515b25fa126a7d"
  enforcement_level = "advisory"
}
policy "rds-public-access-disabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/rds-public-access-disabled.sentinel?checksum=sha256:63d9b27d782a242de7cbb4c9ad96dd1cae2ab1d9bd3d814239744b9f3834c502"
  enforcement_level = "advisory"
}
policy "s3-block-public-access-account-level" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/s3-block-public-access-account-level.sentinel?checksum=sha256:f0d38b333d0ba3180ea4ab7afb0c5634e1515a9aa3f0fa013370de88d534aaf9"
  enforcement_level = "advisory"
}
policy "s3-block-public-access-bucket-level" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/s3-block-public-access-bucket-level.sentinel?checksum=sha256:6359a9eff7914cc54333256b8a84dde7a1eca0adeab489994b7877f856381d1b"
  enforcement_level = "advisory"
}
policy "s3-enable-object-logging-for-read-events" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/s3-enable-object-logging-for-read-events.sentinel?checksum=sha256:57f31bd14cb5ccff01a6741576d401f1faea9be8dfef74f4dca4310a71fb9c32"
  enforcement_level = "advisory"
}
policy "s3-enable-object-logging-for-write-events" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/s3-enable-object-logging-for-write-events.sentinel?checksum=sha256:57f31bd14cb5ccff01a6741576d401f1faea9be8dfef74f4dca4310a71fb9c32"
  enforcement_level = "advisory"
}
policy "vpc-flow-logging-enabled" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/vpc-flow-logging-enabled.sentinel?checksum=sha256:47154215cc11cf0f038b7947f2035f4f468e78c6affc9fcafb737066a54c2bdd"
  enforcement_level = "advisory"
}
policy "s3-require-ssl" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/s3-require-ssl.sentinel?checksum=sha256:1fb24079d45416131d246f6641840868c3594c7230b158b065c795badeb32723"
  enforcement_level = "advisory"
}
policy "s3-require-mfa-delete" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy/s3-require-mfa-delete.sentinel?checksum=sha256:62dd3bc8c473d88a78db6bed90abbb17260b05261bad8bb87f50a41de191b55a"
  enforcement_level = "advisory"
}
module "report" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy-module/report.sentinel?checksum=sha256:1e733d8aa6840713ad89ca380114077bec624f548e30f68664e7a22182686a6f"
}
module "tfresources" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/CIS-Policy-Set-for-AWS-Terraform/1.0.2/policy-module/tfresources.sentinel?checksum=sha256:0c41826596cad74d399554436c7883dc9e1585f28898be030683f13fb993e2ab"
}
module "tfplan-functions" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy-module/tfplan-functions.sentinel?checksum=sha256:b7590b6f1729e957cd2d2fec048babcd5f5b4a3bbe90dba14eb8bb5da024ff66"
}
module "tfstate-functions" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy-module/tfstate-functions.sentinel?checksum=sha256:53eeec20c431053b9402e565f66a2aaba415f26a59ab202e128e88b4a392954f"
}
module "tfconfig-functions" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy-module/tfconfig-functions.sentinel?checksum=sha256:dd41e7150e1189676f37bbf5c3aeae7791cc9793d921f19ba4f7bcbd42e21cb9"
}
module "aws-functions" {
  source = "https://registry.terraform.io/v2/policies/SPHTech-Platform/aws/1.0.5/policy-module/aws-functions.sentinel?checksum=sha256:b6f0301884456544f2d5ae708918e08419fe4e9b8abee65314a109497f2ef725"
}
