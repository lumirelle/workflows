# Workflow

A collection of reusable GitHub Actions workflows.

## Actions

### Setup Mise

Setup mise environment for your workflow.

#### Cache Support

Cache support is powered by [`actions/cache`](https://github.com/actions/cache).

There are some cache presets supported via the `cache-preset` input:

- `nub` — caches `~/.local/share/nub/store/v1`, keyed by `nub.lock`
- `hk` — caches `~/.cache/hk`, keyed by `hk.pkl`

You can pass a single preset or comma-separated multiple:

```yaml
- uses: lumirelle/workflows/setup-mise@main
  with:
    cache-preset: 'nub,hk'
```

Each preset runs as an independent cache step with its own key and path.

For a custom cache, set `cache-path` (and optionally `cache-key` / `cache-restore-keys`). This adds an extra cache step alongside any presets:

```yaml
- uses: lumirelle/workflows/setup-mise@v10
  with:
    # nub & hk still works
    cache-preset: 'nub,hk'
    # Your custom cache rules
    cache-path: ./.cache
    cache-key: 'custom-${{ runner.os }}'
```

## Workflows

### CI

- [ci.yaml](./.github/workflows/ci.yaml): A workflow for continuous integration, runs `mise run check` & `mise run test` by default;
- [ci-autofix.yaml](./.github/workflows/ci-autofix.yaml): A workflow for continuous integration with autofix, runs `mise run fix` by default;
- [ci-coverage.yaml](./.github/workflows/ci-coverage.yaml): A workflow for continuous integration with code coverage, runs `mise run test --coverage` by default;

### Release

- [release.yaml](./.github/workflows/release.yaml): A workflow for releasing a new version, runs `mise run changelog` && `mise run publish` by default;
- [release-commit.yaml](./.github/workflows/release-commit.yaml): A workflow for generating a release commit, runs `mise run publish-commit`;
