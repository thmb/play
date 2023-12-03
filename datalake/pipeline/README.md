# [AIRBYTE](https://airbyte.com)

[Deploy Airbyte on Kubernetes using Helm](https://docs.airbyte.com/deploying-airbyte/on-kubernetes-via-helm) to allow scaling sync workloads horizontally. The core components (api server, scheduler, etc) run as deployments while the scheduler launches connector-related pods on different nodes.

Alternative deployments include [AWS EC2](https://docs.airbyte.com/deploying-airbyte/on-aws-ec2), [Google Compute Engine](https://docs.airbyte.com/deploying-airbyte/on-gcp-compute-engine) and others.

## SOURCES

## DESTINATIONS

## CONNECTIONS

## SETUP

## CLI (Alternative)

[Octavia](https://github.com/airbytehq/airbyte/tree/master/octavia-cli) is a CLI tool to manage Airbyte configurations in YAML.

A pratical way to experiment it is to use the official Docker image with command line arguments.

It is also possible to configure an alias in ~/.bashrc file to make it easy to run the commands:

```console
alias octavia='docker run --name octavia -i --rm -v .:/home/octavia-project --network host --user $(id -u):$(id -g) --env-file .octavia.env airbyte/octavia-cli'
```

[Version control Airbyte configurations with Octavia CLI](https://airbyte.com/tutorials/version-control-airbyte-configurations)