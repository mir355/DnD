#!/bin/bash

GENDIR=$PWD/generated
MODELDIR=$PWD/models

pushd ../scripts/

for file in $MODELDIR/*.onnx; do
  name=${file##*/}
  base=${name%.onnx}
  echo "$name detected"
  # echo "$file, $base.pbtxt $base.dot"
  python3 onnx2pbtxt.py --input $file --pbtxt $GENDIR/$base.pbtxt --dot $GENDIR/$base.dot
done
popd
