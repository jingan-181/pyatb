PYATB, Python ab initio tight binding simuation package, a python package for computing electronic structures and related properties based on the ab initio tight binding Hamiltonian.

Quick start:

Get the source:
```
git clone --recursive https://github.com/jingan-181/pyatb.git
cd pyatb
# if you are updating an existing checkout
git submodule sync
git submodule update --init --recursive
```
Install depandency:
```
sudo apt install libeigen3-dev libmkl-dev
```
Build PYATB:
```
python3 setup.py install
```
or
```
python -m build
```
