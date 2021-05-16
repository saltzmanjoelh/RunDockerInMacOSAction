A simple example of how to start Docker in a macOS GitHub workflow. Take a look at the [swift.yml](.github/workflows/swift.yml) file.

```yaml
jobs:
  build:

    runs-on: macos-latest

    steps:
    - uses: actions/checkout@v2
    - name: Build
      run: swift build -v
    - name: Install docker # Taken from https://github.com/actions/virtual-environments/issues/1143#issuecomment-652264388
      run: |
        mkdir -p ~/.docker/machine/cache
        curl -Lo ~/.docker/machine/cache/boot2docker.iso https://github.com/boot2docker/boot2docker/releases/download/v19.03.12/boot2docker.iso
        brew install docker docker-machine
        docker-machine create --driver virtualbox default
        docker-machine env default
    - name: Run tests
      run: |
        eval "$(docker-machine env default)"
        docker pull swift:5.3-amazonlinux2
        swift test --enable-code-coverage --sanitize=thread
```

The `Install docker` step sets up the filesystem, uses brew to install docker-machine and starts docker-machine.

The `Run tests` sets up the docker environment variables, pulls the image that we are going to use and runs the test. You want to pull the image that you will be using in the tests before running the tests because bandwidth is limited in the testing environment. You don't want your tests to run slowly while downloading the image. I have a had a race condition where I create some temp files, pull the image, continue with the test and the temp files end up being cleaned up and the test fails.
