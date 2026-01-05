# As Bun does not support `publish --recursive`, we need to manually publish each package.
for package in "$@"; do
  (cd $package  && bun pm pack --filename release.tgz && bunx npm publish ./release.tgz --access public)
done
