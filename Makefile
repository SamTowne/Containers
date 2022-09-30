default:
	echo

fmt:
	terraform fmt --recursive

init:
	terraform init --backend=false

validate: fmt init
	terraform validate

localdev: rmlocaldev
	cp ./dev/localdev/example_TF_override ./modules/my-example/example_TF_override.tf
	cp ./dev/localdev/example_auto_tfvars ./example.auto.tfvars
	make validate

rmlocaldev:
	rm -f ./modules/my-example/example_TF_override.tf
