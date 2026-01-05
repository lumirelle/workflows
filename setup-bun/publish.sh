# As Bun does not support `publish --recursive`, we need to manually publish each package.
for package in "$1"; do
  # (cd $package && bun publish --access public)
  echo $package
done
