## INITIAL SETUP

1. Install Docker.  There is more than one way to do this.  The author
   of this document used Homebrew:

       brew cask install docker

   You might wish to explore and tweak Docker's preferences before
   using it.

2. The provided docker-compose.yaml sets up a container with read-only
   access to the source directory and full access to a separate
   directory for build artifacts.  To tell Docker the host directories
   to use, create a file named ".env" in this directory, holding the
   following variable definitions referring to host directories by
   absolute path.

       LILYPOND_BUILD_DIR=...
       LILYPOND_SRC_DIR=...

   Before you start using the build directory, consider whether you
   want to configure operating system options such as storage quotas,
   backup exclusions, and indexing exclusions.  A full build including
   regression tests and documentation required 4 GB when the author
   tested it in August 2018.

3. Build the lilypond-dev image:

       docker-compose build


## ROUTINE USE

1. Start Docker

2. Start the lilypond-build container:

       docker-compose up -d

3. Enter a shell in the container:

       docker exec -it lilypond-build bash

4. Build and test LilyPond.  The first step is to configure the build
   from the build directory:

       ../lilypond-src/autogen.sh

   For further instruction, refer to the LilyPond Contributor's Guide.

5. When you are done working, clean up:

       docker-compose down

6. Quit Docker
