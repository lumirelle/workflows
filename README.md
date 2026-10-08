# Workflow

A collection of reusable GitHub Actions workflows.

## Actions

### Setup Mise

Setup mise environment for your workflow.

#### Cache Support

Cache support is powered by [`actions/cache`](https://github.com/actions/cache).

There are some cache presets supported via the `cache-preset` input:

- `mise-task` — Caches mise task artifacts & state (`~/.cache/mise/task-artifacts`, `~/.local/state/mise/task-artifacts`, `~/.local/state/mise/task-sources`), keyed by OS. Requires `cache = { enabled = true }` in your `mise.toml` tasks.
- `nub` — Caches [nub virtual store](https://nubjs.com/docs/install/virtual-store#one-symlink-per-package) (`~/.local/share/nub/store/v1`), keyed by `nub.lock`

You can pass a single preset or comma-separated multiple, and override preset via JSON configurations:

```yaml
- uses: lumirelle/workflows/setup-mise@main
  with:
    cache-preset: 'mise-task,nub'
    cache-preset-path: '{"mise-task":["/path/a","/path/b"],"nub":"/custom/nub"}'
    cache-preset-key: '{"nub":["nub-Linux-","nub-"]}'
    cache-preset-restore-keys: '{"mise-task":"mise-task-","nub":"nub-"}'
```

Each preset runs as an independent cache step with its own key and path.

For a custom cache, set `cache-path` (and optionally `cache-key` / `cache-restore-keys`). This adds an extra cache step alongside any presets:

```yaml
- uses: lumirelle/workflows/setup-mise@v10
  with:
    # mise-task & nub still works
    cache-preset: 'mise-task,nub'
    # Your custom cache rules
    cache-path: ./.cache
    cache-key: 'custom-${{ runner.os }}'
```

<details>
<summary>

##### Deprecated preset

</summary>

- `mise-deps` — Caches [mise deps state](https://mise.jdx.dev/dev-tools/deps.html#freshness-checking) (`~/.local/state/mise/deps`), keyed by OS.
  - Deps state is strongly correlated with the real dependencies, such as `node_modules` for `npm` backend. Cache dependencies directly is a bad idea: There are many OS & architecture based dependencies cannot be shared, also, the decompressed dependencies may exceed the cache limit.
- `hk` — Caches [hk cache dir](https://hk.jdx.dev/gen/settings-config.html#cache-dir) (`~/.cache/hk`), keyed by `hk.pkl`
  - Use `mise-task` cache preset instead.

</details>

## Workflows

Every runnable step is optional: pass an empty string for its input to skip it. When a step is the only step of a job, the whole job is skipped (including its setup).

```yaml
jobs:
  ci:
    uses: lumirelle/workflows/.github/workflows/ci.yml@v10
    with:
      check: '' # skip `mise run check`
      test: '' # skip `mise run test`
```

### CI

- [ci.yml](./.github/workflows/ci.yml): A workflow for continuous integration, runs `mise run check` & `mise run test` by default
- [ci-autofix.yml](./.github/workflows/ci-autofix.yml): A workflow for continuous integration with autofix, runs `mise run fix` by default
- [ci-coverage.yml](./.github/workflows/ci-coverage.yml): A workflow for continuous integration with code coverage, runs `mise run test --coverage` by default

### Release

- [release.yml](./.github/workflows/release.yml): A workflow for releasing a new version, runs `mise run changelog` && `mise run publish` by default
- [release-commit.yml](./.github/workflows/release-commit.yml): A workflow for generating a release commit, runs `mise run publish-commit`
