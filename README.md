# NSLS-II Beamline Artwork

---

Permission is granted to use the Brookhaven images in this repository.
Permission is applicable only for the the images in the document. Without
limitation, the images shall not be utilized to endorse, or imply
endorsement of any product or service.  Images may not be digitally
manipulated in any way except to adjust size, crop or color attributes
to optimize it for print production.  The credit line "Courtesy
of Brookhaven National Laboratory" shall be included with the images
or as a separate credit adjacent to the image.
Usage of the image constitutes your agreement with these terms.

---

## Installation

The artwork can bin installed using the Makefile provided.

```shell
$ make
$ make install
```

## Building Debian Package

The debian package can be built from this git repository by executing:

```shell
$ gbp buildpackage --git-debian-branch=main -uc -us  --git-export-dir=build
```

which will build the package in the directory `./build`