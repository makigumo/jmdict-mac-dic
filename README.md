# JMDict for macOS 

Scripts to convert the JMDict XML file into an XML file suitable for Apple’s Dictionary Development Kit (DDK).

## Install

### Requirements

* DDK inside the `$HOME` directory (adjust in `Makefile`).
* Java 8+
* [Saxon-HE](https://sourceforge.net/projects/saxon/files/Saxon-HE/9.8/SaxonHE9-8-0-8J.zip/download)
    * `build-saxon.sh` will try to download it automatically.
* JMDict file (use either method)
    * HTTP
        * Download `JMDict_e.gz` from a [mirror](http://ftp.monash.edu.au/pub/nihongo/00MIRRORS.html).
        * Extract with `gunzip`.
    * RSYNC
        * Run `./rsync.sh`.

### Steps

```sh
./build-saxon.sh
make
make install
```

## Links/Credits

* [Dictionary License](http://www.edrdg.org/edrdg/licence.html)
* [The JMDict Project](http://www.edrdg.org/jmdict/j_jmdict.html) 
* [Electronic Dictionary Research and Development Group](http://www.edrdg.org/)
