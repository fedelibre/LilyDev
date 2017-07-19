# mkosi.cache

We want `mkosi.cache` directory to exist in this repository (therefore this README)
because, if present, then the package files will be placed here and reused in
subsequent runs of mkosi, speeding up the build of the images.

At the same time, we do not want to track the contents of this directory, which
is listed in `.gitignore`.
