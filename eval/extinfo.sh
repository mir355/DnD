#!/bin/bash

set -x

GENDIR=$PWD/generated
MODELDIR=$PWD/models
BINDIR=$PWD/binaries
DECOMPDIR=$PWD/decompiled_models

extract_info ()
{
  pushd ../scripts/
  for file in $MODELDIR/*.onnx; do
    name=${file##*/}
    base=${name%.onnx}
    echo "$name detected"
    # echo "$file, $base.pbtxt $base.dot"
    python3 onnx2pbtxt.py --input $file \
      --pbtxt $GENDIR/$base.pbtxt \
      --dot $GENDIR/$base.dot
  done
  popd
}

compile ()
{
  for file in $MODELDIR/*.onnx; do
    name=${file##*/}
    base=${name%.onnx}
    echo "$name is being compiled"
    undefined_symbol=$(if [[ $name =~ "resnet" ]]; then echo "-onnx-define-symbol=N,1"; else echo ""; fi)
    echo $undefined_symbol

    for tuple in "arm cortex-m7" "aarch64 cortex-a72" "x86_64 "; do
      set -- $tuple
      model-compiler \
        --backend=CPU \
        --model=$file \
        -emit-bundle=$BINDIR/$base/$1 \
        -bundle-api=static \
        --target=$1 \
        --mcpu=$2 \
        $undefined_symbol
    done
    ls -al --recursive $BINDIR/$base
  done
}

$@
