import os
from src.loader import load

if __name__ == "__main__":
    # build_path = os.path.abspath(os.getcwd() + "/eval/binaries/mnist-8/x86_64/build/")
    # binary_name = "Mnist8BundleMain"
    # build_path = os.path.abspath(os.getcwd() + "/../glow/build/bundles/resnet50/")
    # binary_name = "ResNet50Bundle"
    build_path = os.path.abspath(os.getcwd() + "/../glow/build/bundles/lenet_mnist/")
    binary_name = "LeNetMnistBundle"
    model_path = os.path.join(build_path, binary_name)
    print(model_path)
    load(model_path, arch="x86")
