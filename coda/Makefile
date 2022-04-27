prepare-sdx:
	@terraform init
	@terraform workspace new sdx

run-sdx:
	@terraform workspace select sdx
	@terraform apply

down-sdx:
	@terraform workspace select sdx
	@terraform destroy

reset-local:
	@rm -r .terraform
	@rm -r .terraform.lock.hcl

lint: flake8

prepare-lint:
	@pip3 install flake8
	@pip3 install flake8-quotes

validate:
	@terraform fmt -check -diff
	@flake8 --max-line-length 79 --ignore=Q003
