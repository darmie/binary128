#!/bin/sh
rm -f Binary128.zip
zip -r Binary128.zip src *.hxml *.json *.md run.n
haxelib submit Binary128.zip $HAXELIB_PWD --always