# JMDict for macOS 

Scripts to convert the JMDict XML file into an XML file suitable for Apple’s Dictionary Development Kit.

## Install

### Requirements

* DDK inside the `$HOME` directory.
* Java 8
* [Saxon-HE](https://sourceforge.net/projects/saxon/files/Saxon-HE/9.8/SaxonHE9-8-0-3J.zip/download)
    * Extract with `unzip SaxonHE9-8-0-3J.zip saxon9he.jar`.
* JMDict file
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
