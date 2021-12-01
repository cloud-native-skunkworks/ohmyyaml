.PHONY: docker docker-push docker-build
create-oci-helm-chart: export HELM_EXPERIMENTAL_OCI=1
create-oci-helm-chart:
	helm package ./app/charts/ohmyyaml
	helm push ohmyyaml-*.tgz oci://ghcr.io/tibbar/ohmyyaml
docker:
	docker build -f app/Dockerfile ./app -t tibbar/ohmyyaml:latest
docker-push:
	docker push tibbar/ohmyyaml:latest
docker-run:
	docker run --rm -it -p 8080:8080 docker.io/tibbar/ohmyyaml:latest 
terragrunt-plan-infra:
	cd regional_configurations/eu-west-1/infrastructure_substrate && \
	trap "cd ../../../" SIGINT SIGTERM ERR EXIT && \
	terragrunt plan --terragrunt-source ../../../module_catalogue/infrastructure_substrate
terragrunt-plan-deployments:
	cd regional_configurations/eu-west-1/deployments && \
	trap "cd ../../../" SIGINT SIGTERM ERR EXIT && \
	terragrunt plan --terragrunt-source ../../../module_catalogue/deployments
terragrunt-apply-infra:
	cd regional_configurations/eu-west-1/infrastructure_substrate && \
	trap "cd ../../../" SIGINT SIGTERM ERR EXIT && \
	terragrunt apply --terragrunt-source ../../../module_catalogue/infrastructure_substrate
terragrunt-destroy-infra:
	cd regional_configurations/eu-west-1/infrastructure_substrate && \
	trap "cd ../../../" SIGINT SIGTERM ERR EXIT && \
	terragrunt destroy --terragrunt-source ../../../module_catalogue/infrastructure_substrate
terragrunt-apply-deployments:
	cd regional_configurations/eu-west-1/deployments && \
	trap "cd ../../../" SIGINT SIGTERM ERR EXIT && \
	terragrunt apply --terragrunt-source ../../../module_catalogue/deployments
