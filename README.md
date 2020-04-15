# meterpreter-deps

This repository contains source tarballs, binary tools, and other
artifacts required to build meterpreter, but that are not part of its
source code directly.

## LibreSSL

The Python extension now makes use of LibreSSL instead of OpenSSL. To update, do the following:

* Make sure you have [CMake for Windows](https://cmake.org/download/) v3.15 or higher installed.
* Pull the latest version of the [source](https://ftp.usa.openbsd.org/pub/OpenBSD/LibreSSL/) into the `libressl` folder.
* Make sure that the `CMakeLists.txt` file contains the `USE_STATIC_MSVC_RUNTIMES` option.
    * If not, `git checkout CMakeLists.txt` again so that the patched version still exists in the report.
    * If so, we can remove the custom version of the `CMakeLists.txt` file from this repo.
* Open a command prompt at this location and type `make.bat` to run the build.
* Commit the changes and push.

Done.
