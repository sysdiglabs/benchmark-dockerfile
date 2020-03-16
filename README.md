# Sysdig Benchmark Dockerfile 

The Github action runs CIS Dockerfile benchmark against dockerfiles in repository (CIS 4.1, 4.2, 4.3, 4.6, 4.7, 4.9, 4.10)

## Inputs

### `directory`

Directory of dockerfiles (default "./")

### `dockerfilePattern`

dockerfile name pattern (default "dockerfile")

### `disallowedPackages` 

list of disallowed packages separated by comma (default "")

### `disallowedPackages`

list of disallowed packages separated by comma (default "")

### `trustedBaseImages`

list of trusted base images separated by comma (default "")

### `secretPatterns`

list of secret patterns separated by comma (default "")

## Ouptuts

### `violation_report`

Violation report generated from CIS Dockerfile benchmark

Dockerfile name pattern (default "dockerfile", case insensitive)

## Use Cases
0. Integrate the `sysdig-benchmark-dockerfile` action into the git workflow.
1. Run CIS benchmark check for dockerfiles with the following rules:
   - CIS 4.1 Create a user for the container
   - CIS 4.2 Use trusted base images for containers (user provide trusted base image list)
   - CIS 4.3 Do not install unnecessary packages in the container (user provide the disallowed package list)
   - CIS 4.6 Add HEALTHCHECK instruction to the container image
   - CIS 4.7 Do not use update instructions alone in the Dockerfile
   - CIS 4.9 Use COPY instead of ADD in Dockerfile
   - CIS 4.10 Do not store secrets in Dockerfiles (user provide the secret pattern, only checks contents in `ENV` and `LABEL` instructions)
2. Define your own criteria based on the lint result, for example:
- Send lint report to slack channel.
- Fail the check on the PR if any violation is detected.
- Assign extra reviewers (security architect/engineer) to the PR.

## Example Usage in Git workflow

## Outputs
```
{
  "cis_docker_benchmark_violation_report": [
    {
      "rule": "CIS 4.1 Create a user for the container",
      "violations": [
        "test/Dockerfile_fail"
      ]
    },
    {
      "rule": "CIS 4.3 Do not install unnecessary packages in the container",
      "violations": [
        "test/Dockerfile_fail: netcat"
      ]
    },
    {
      "rule": "CIS 4.6 Add HEALTHCHECK instruction to the container image",
      "violations": [
        "test/Dockerfile_fail"
      ]
    },
    {
      "rule": "CIS 4.7 Do not use update instructions alone in the Dockerfile",
      "violations": [
        "test/Dockerfile_fail"
      ]
    },
    {
      "rule": "CIS 4.9 Use COPY instead of ADD in Dockerfile",
      "violations": [
        "test/Dockerfile_fail"
      ]
    },
    {
      "rule": "CIS 4.10 Do not store secrets in Dockerfiles",
      "violations": [
        "test/Dockerfile_fail: ENV contains 'aws_secret'"
      ]
    }
  ]
}
```

See [Example PR](https://github.com/sysdiglabs/dockerfile-benchmarker/pull/1/checks) for more details
