# Workflow

A collection of reusable GitHub Actions workflows. Based on Mise. Inspired by [sxzz/workflows](https://github.com/sxzz/workflows).

## Actions

### Setup Mise

Setup mise environment for your workflow.

#### Cache Support

Cache support is powered by [`actions/cache`](https://github.com/actions/cache).

There are some cache presets supported via the `cache-preset` input:

- `nub` — Caches [nub virtual store](https://nubjs.com/docs/install/virtual-store#one-symlink-per-package) (`~/.local/share/nub/store/v1`), keyed by `nub.lock`
- `eslint` — Caches ESLint's lint cache (`--cache`, default `.eslintcache`), keyed by OS and `nub.lock`. Your lint task must pass `--cache`, and the cache path can be overridden with `--cache-location`.
- `mise-task` — Caches mise task artifacts & state (`~/.cache/mise/task-artifacts`, `~/.local/state/mise/task-artifacts`, `~/.local/state/mise/task-sources`), keyed by OS. Requires `cache = { enabled = true }` in your `mise.toml` tasks.

You can pass a single preset or comma-separated multiple, and override preset via JSON configurations:

```yaml
- uses: lumirelle/workflows/setup-mise@main
  with:
    cache-preset: 'nub,mise-task'
    cache-preset-path: '{"nub":"/custom/nub","mise-task":["/path/a","/path/b"]}'
    cache-preset-key: '{"nub":"nub-custom-key"}'
    cache-preset-restore-keys: '{"nub":"nub-","mise-task":"mise-task-"}'
```

Each preset runs as an independent cache step with its own key and path.

For a custom cache, set `cache-path` (and optionally `cache-key` / `cache-restore-keys`). This adds an extra cache step alongside any presets:

```yaml
- uses: lumirelle/workflows/setup-mise@v11
  with:
    # nub & mise-task still works
    cache-preset: 'nub,mise-task'
    # Your custom cache rules
    cache-path: ./.cache
    cache-key: 'custom-${{ runner.os }}'
```

## Workflows

Every runnable step is optional: pass an empty string for its input to skip it. When a step is the only step of a job, the whole job is skipped (including its setup).

```yaml
jobs:
  ci:
    uses: lumirelle/workflows/.github/workflows/ci.yml@v11
    with:
      check: '' # skip `mise run check`
      test: '' # skip `mise run test`
```

### Job specific cache presets

For the workflow who has more than one jobs inside, there are job specific cache presets.

For example, the CI workflow has two jobs: `check` & `test`. To cache ESLint for the check job only:

```yaml
jobs:
  ci:
    uses: lumirelle/workflows/.github/workflows/ci.yml@v11
    with:
      cache-preset: nub
      check-cache-preset: 'nub,eslint'
```

> [!Note]
> For the workflow who has only one job, `cache-preset` is enough.

### CI

- [ci.yml](./.github/workflows/ci.yml): A workflow for continuous integration, runs `mise run check` & `mise run test` by default
- [ci-autofix.yml](./.github/workflows/ci-autofix.yml): A workflow for continuous integration with autofix, runs `mise run fix` by default
- [ci-coverage.yml](./.github/workflows/ci-coverage.yml): A workflow for continuous integration with code coverage, runs `mise run test --coverage` by default

### Release

- [release.yml](./.github/workflows/release.yml): A workflow for releasing a new version, runs `mise run changelog` && `mise run publish` by default
- [release-commit.yml](./.github/workflows/release-commit.yml): A workflow for generating a release commit, runs `mise run publish-commit`
