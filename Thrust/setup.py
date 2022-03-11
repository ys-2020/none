from setuptools import setup
from torch.utils.cpp_extension import BuildExtension, CUDAExtension, CppExtension

# python setup.py build
# python setup.py install

setup(
    name='remap',
    ext_modules=[
        CUDAExtension('remap',['remap.cc','remap.cu'])
        ],
    cmdclass={'build_ext': BuildExtension},
    install_requires=['torch']
)