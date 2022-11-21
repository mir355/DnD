## General Issues

- There is no entry point nor guideline
- models are not provided
- compilers are not provided
- no "default/standard" setup in AOT compilation.

## From MLPerfTiny

tiny/benchmark/training/image_classification/trained_models/pretrainedResnet.h5
tiny/benchmark/training/image_classification/trained_models/pretrainedResnet_quant.tflite
tiny/benchmark/training/image_classification/trained_models/pretrainedResnet.tflite
tiny/benchmark/training/image_classification/trained_models/pretrainedResnet_quant.md5
tiny/benchmark/training/image_classification/trained_models/pretrainedResnet.md5

## From ONNX zoo

models/vision/classification/mnist/model/mnist-7.onnx
models/vision/classification/mnist/model/mnist-8.onnx
models/vision/classification/mnist/model/mnist-12.onnx
models/vision/classification/mnist/model/mnist-12-int8.onnx
models/vision/classification/mnist/model/mnist-1.onnx

models/vision/classification/mobilenet/model/mobilenetv2-12-qdq.onnx
models/vision/classification/mobilenet/model/mobilenetv2-12.onnx
models/vision/classification/mobilenet/model/mobilenetv2-7.onnx
models/vision/classification/mobilenet/model/mobilenetv2-10.onnx
models/vision/classification/mobilenet/model/mobilenetv2-12-int8.onnx

./classification/resnet/model/resnet18-v1-7.onnx
./classification/resnet/model/resnet18-v2-7.onnx



## What is missing in this repo?

1. evaluation models
1. compilers (glow and tvm)
1. test-running shell code

## What I have to do?
1. Compile tflite, onnx to binary
  - glow supports both tflite and onnx as source.
  - tvm I don't know yet
1. Decompile binary into onnx
  - figure out how to use it.
  - additionally, Resnet has to be converted into tflite.
1. How do you compare here?
  - According to the paper, it needs to compare topology, number of operators, and type of each operator

1. Compare DnD-decompiled model vs original model inference

## How to AOT cross-compile with {Glow, TVM}

Glow provides a compiler binary called `model-compiler`, which is located in 
`/path/to/build/bin/model-compiler`.

Glow AOT compiler will provide 4 artifacts out of compilation process. For
example, given a model named `<network-name>.onnx`, it emits `<network-name>.o`
, `<network-name>.h`, `<network-name>.weights.bin` and
`<network-name>.weights.txt`. In its header file, the function
named `<network-name>()` is defined, so user must link a `*.o` file and call
it. The detailed guideline is described in
[here](https://github.com/pytorch/glow/blob/master/docs/AOT.md).



```
# (optional) conver tflite to onnx
python -m tf2onnx.convert --opset 13 --tflite /path/something/resnetv1.tflite --output resnetv1.onnx

# extract pbtxt & dot files from onnx files
cd eval
./extinfo.sh compile

# compile with glow and store at eval/binaries
model-compiler --backend=CPU --target=arm --mcpu=cortex-m7 --model=<network-model> -emit-bundle=/path/out/directory

# compile with tvm and store at eval/binaries

# compile the artifcats with the main binary
python3 test.py

# decompile eval/binaries/* into onnx using dnd
```

## TODO

- [x] compile glow/tvm artifacts into one binary before decompilation.
- [x] compiling into x64 bundle
- [ ] compiling into aarch64 bundle

- [ ] load the x64 bundle
  - error emitting at a block with no instruction.

- [ ] decompile with DnD.
- [ ] Compare decompiled onnx and original onnx.


