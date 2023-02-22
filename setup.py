import os
from setuptools import setup, Extension, find_packages
from setuptools.command.build_ext import build_ext
from glob import glob
from pybind11.setup_helpers import Pybind11Extension, build_ext

# Parameters that need to be modified
CXX = "g++"

# Generally do not need to modify
os.environ["CXX"] = CXX
os.environ["CC"] = CXX
os.environ['CFLAGS'] = "-O2 -std=c++11 -fPIC -Wall -shared"

include_dirs = [os.path.join("src", "core"), os.path.join("src", "interface_python"), "/usr/include/eigen3", "/usr/include/mkl"]
extra_compile_args = []
extra_link_args = []
if CXX == "g++":
    extra_compile_args += ["-fopenmp"]
else:
    extra_compile_args += ["-qopenmp"]
    LAPACK_DIR = "/opt/intel/compilers_and_libraries_2018.1.163/linux/mkl"
    LAPACK_INCLUDE_DIR = LAPACK_DIR + "/include"
    LAPACK_LIB_DIR = LAPACK_DIR + "/lib/intel64"
    LAPACK_LIB = "-L" + LAPACK_LIB_DIR + " -Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -Wl,-rpath=" + LAPACK_LIB_DIR
    extra_link_args += [LAPACK_LIB]

define_macros = []
undef_macros = []

extension = [
        Pybind11Extension('pyatb.interface_python',
                      include_dirs=include_dirs,
                      sources=sorted(glob("src/core/*.cpp"))+sorted(glob("src/interface_python/*.cpp")),
                      extra_compile_args=extra_compile_args,
                      extra_link_args=extra_link_args,
                      define_macros=define_macros,
                      undef_macros=undef_macros, 
                      ),
]

setup(name='pyatb',
      version="1.0.0",
      cmdclass={'build_ext': build_ext},
      setup_requires=['numpy', 'setuptools>=18.0', 'pybind11'],
      license='GPL v3.0',
      description='This is the pyatb module.',
      long_description='None',
      author='Gan Jin & Hongsheng Pang',
      author_email='jingan@mail.ustc.edu.com',
      url='None',
      packages=find_packages(),
      py_modules=[],
      install_requires=['numpy', 'scipy', 'mpi4py', 'matplotlib'],
      ext_modules=extension,
      entry_points={'console_scripts': ['pyatb = pyatb.main:main']})



