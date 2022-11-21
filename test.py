import os
from src.loader import load
from src.iv_identify import identify_iv

if __name__ == "__main__":
    # build_path = os.path.abspath(os.getcwd() + "/eval/binaries/mnist-8/x86_64/build/")
    # binary_name = "Mnist8BundleMain"
    build_path = os.path.abspath(os.getcwd() + "/eval/binaries/mnist-8/x86_64/")
    binary_name = "mnist_8.o"
    # build_path = os.path.abspath(os.getcwd() + "/../glow/build/bundles/resnet50/")
    # binary_name = "ResNet50Bundle"
    # build_path = os.path.abspath(os.getcwd() + "/../glow/build/bundles/lenet_mnist/")
    # binary_name = "LeNetMnistBundle"
    model_path = os.path.join(build_path, binary_name)
    print(model_path)
    proj = load(model_path, arch="x86")

    for f_addr in proj.outer_loops:
        for loop_idx in range(len(proj.outer_loops[f_addr])):
            iv_dict, iv_aux = identify_iv(proj, f_addr, loop_idx, all_branch=True)

    # for (func_addr, outer_loop_idx) in zip(proj.funcs, proj.outer_loops):
    #     iv_dict, iv_aux = identify_iv(proj, func_addr, outer_loop_idx, all_branch=True)
    # simgr, solver, mem_read_dict, mem_write_dict = extract_ast(proj, func_addr, outer_loop_idx)


