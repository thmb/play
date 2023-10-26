# [TERRAFORM](https://www.terraform.io)

Terraform runs from user's machine to provision infrastructure resources in cloud providers.

HashiCorp, the company behind Terraform, made great [tutorials](https://developer.hashicorp.com/terraform/tutorials) to getting started and also offers a cloud service.

## SETUP

The [installation methods](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform) are available for several operating systems and architectures.

For Ubuntu/Debian:

```console
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

## AMAZON WEB SERVICES

- Tutorial to [Provision an EKS cluster (AWS)](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks) and the [Github Repository](https://github.com/hashicorp/learn-terraform-provision-eks-cluster/tree/main).
- Tuotorial to [Provision Redshift]()
- Tuotorial to [Provision S3]()

## AWS (CLI)

In order to shorten the length of docker commands, you can add the following alias:

alias aws='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'

aws --version