import type { Options } from '@lumirelle/linter-config'

export const options = {
  // Strict lib type
  type: 'lib',
  // Oxlint reports these rules, so ESLint turns them off to avoid reporting twice.
  oxlint: { typeAware: true },
  overrides: {
    toml: {
      rules: {
        'toml/array-element-newline': ['error', 'consistent'],
        'toml/array-bracket-spacing': ['error', 'never'],
      },
    },
  },
} satisfies Options
