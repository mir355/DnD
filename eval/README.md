
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

```
# (optional) conver tflite to onnx
python -m tf2onnx.convert --opset 13 --tflite /path/something/resnetv1.tflite --output resnetv1.onnx

# extract pbtxt & dot files from onnx files
cd eval
./extinfo.sh

# compile with glow and store at eval/binaries

# compile with tvm and store at eval/binaries

# decompile eval/binaries/* into onnx using dnd

```
