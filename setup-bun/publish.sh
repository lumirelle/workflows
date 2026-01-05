# As Bun does not support `publish --recursive`, we need to manually publish each package.
for package in "$@"; do
  # (cd $package && bun publish --access public)
  cd $package && echo "$(cwd)"
done
