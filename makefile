# Lint the terraform files. Don't forget to provide the 'region' var, as it is
# not provided by default. Error on issues, suitable for CI.
lint:
	terraform get
	tflint --error-with-issues

# Run the CircleCI build locally.
circleci:
	circleci config validate -c .circleci/config.yml
	circleci build --job lint

.PHONY: lint circleci
