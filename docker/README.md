# Docker

LilyDev Docker image is recommended for Windows and macOS users who
prefer a build environment more limited in scope than a full Linux
development environment running in a virtual machine.  The Docker
container is used for building, running, and debugging LilyPond, but
source control and editing are done on the host with your choice of
tools.

## Initial Setup

1. [Install Docker](https://docs.docker.com/install/).  There is more
   than one way to do this.  On macOS you can use
   [Homebrew](https://brew.sh):

       $ brew cask install docker

   You might wish to explore and tweak Docker's preferences before
   using it.

   On first run, Docker may ask for account creation or log in.
   LilyDev setup needs downloads from public repositories;
   having an account logged in could interfere. So log out:

       $ docker logout

2. The provided `docker-compose.yaml` has rules to set up a container
   named "lilydev" with full access to the host directory holding
   LilyPond source.  To tell Docker the host directory to use, create
   a file named `.env` in the same directory as `docker-compose.yaml`,
   holding the following variable definition referring to the host
   directory by absolute path.
   
   ```shell
   LILY_SRC_DIR=...
   ```

3. Build the image for the "lilydev" service.

       $ docker-compose build lilydev

## Routine Development

1. Start Docker

2. Start the "lilydev" container:

       $ docker-compose up -d lilydev

3. (Optional) Mount the build directory, which Docker manages
   internally, onto the host.  This makes it easy to review build
   products using familiar tools on the host.  While the container is
   running, the build directory is accessible at
   [smb://guest:@127.0.0.1:10445/lilypond-build](smb://guest:@127.0.0.1:10445/lilypond-build).

4. Log into the container:

       $ ./enter lilydev

   This command may be used multiple times.  It executes a new login
   shell each time.

5. Build and test LilyPond.  The first step is to configure the build
   from the build directory:

       [lilydev:~/lilypond-build]
       $ ../lilypond-src/autogen.sh
   
   For further instruction, refer to the LilyPond _Contributor's
   Guide._

6. When you are done working, type Ctrl-D and clean up:
       $ docker-compose down

    :warning: This command shuts down all running services defined in
    `docker-compose.yaml`.  If both "lilydev" and "lilypond"
    containers are running and you want to shut down just one, you
    must instead use `docker` to address the individual container.
    Refer to the manual.

7. Quit Docker

## Using Your Own Scores and Fonts

1. The provided `docker-compose.yaml` has rules to set up a container
   named "lilypond" for running LilyPond after it has been built.
   This container leaves out most of the tools and fonts required for
   LilyPond development, and instead maps in additional directories
   from the host, specified by the following variables in `.env`.

   ```shell
   HOST_EXTRA_FONTS_DIR=...
   HOST_SYSTEM_FONTS_DIR=...
   USER_BUILD_DIR=...
   USER_FONTS_DIR=...
   USER_SRC_DIR=...
   ```

   There are expected values for the three font directories on macOS
   (see [Appendix&nbsp;A](#Appendix-A)).  Any of these may be left
   unset if they are not wanted.

2. Build the image for the "lilypond" service.

       $ docker-compose build lilypond


3. Using the "lilypond" container is like using the "lilydev"
   container.  A round of testing a new LilyPond feature on personal
   scores might begin with a global syntax update:
       [lilypond:~/user-build]
       $ rm -rf *
       [lilypond:~/user-build]
       $ cp -a ~/user-src/* .
       [lilypond:~/user-build]
       $ find . -name '*.ly' | xargs convert-ly -e
       ...

## Appendix A: Example `.env` for macOS

This is what a hypothetical macOS user named "jsb" might provide in
`.env`.  This person has dedicated a partition mounted at
`/Volumes/LilyPond` to LilyPond build products.

```shell
HOST_EXTRA_FONTS_DIR=/Library/Fonts
HOST_SYSTEM_FONTS_DIR=/System/Library/Fonts
LILY_SRC_DIR=/Users/jsb/Projects/LilyPond/git
USER_BUILD_DIR=/Volumes/LilyPond/user-build
USER_FONTS_DIR=/Users/jsb/Library/Fonts
USER_SRC_DIR=/Users/jsb/Music/LilyPond/trunk
```

## Appendix B: Tips for macOS Hosts

* Accessing host files from the container is relatively slow.  To
  remove large trees quickly, delete them with Finder and then empty
  the trash.

* Sometimes it can be useful to create files or directories that the
  user in the container can not modify, for example to force an error
  when debugging build scripts.  This is impossible from within the
  container for files mapped from the host.  To work around this, use
  Finder to mark the file "Locked" or run `sudo chflags uimmutable
  <file>` in Terminal.
