# Workflow

A collection of reusable GitHub Actions workflows.

## CI

- [ci.yaml](./ci.yaml): A workflow for continuous integration, runs `mise run check` & `mise run test` by default;
- [ci-autofix.yaml](./ci-autofix.yaml): A workflow for continuous integration with autofix, runs `mise run fix` by default;
- [ci-coverage.yaml](./ci-coverage.yaml): A workflow for continuous integration with code coverage, runs `mise run test --coverage` by default;

## Release

- [release.yaml](./release.yaml): A workflow for releasing a new version, runs `mise run publish` by default;
- [release-commit.yaml](./release-commit.yaml): A workflow for generating a release commit, runs `mise run publish:commit`;
