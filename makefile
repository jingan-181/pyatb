# 自定义变量objects
objects = \
band_structure_solver.o \
bandunfolding_solver.o \
base_data.o \
berry_connection_solver.o \
berry_curvature_solver.o \
berry_phase_solver.o \
cell_atom.o \
linear_response.o \
math_integral.o \
math_sphbes.o \
optical_conductivity_solver.o \
shift_current_solver.o \
tools.o \
velocity_solver.o \
xr_operation.o \
interface_python.o


HONG = -D__MPI

# 用于make指令搜索源文件的路径
VPATH = ./src/:./src/interface_python/:./src/core/

# 编译器和库地址

## 用户修改参数
CC = g++
CFLAG = -O2 -std=c++11 -fPIC -Wall -shared -fopenmp
LAPACK_DIR = /home/goodchong/python_venv
PYTHON_LIB = $(shell python3-config --includes)

## 一般不需要修改
LAPACK_INCLUDE_DIR = $(LAPACK_DIR)/include
LAPACK_LIB_DIR     = $(LAPACK_DIR)/lib64
LAPACK_LIB         = -L$(LAPACK_LIB_DIR) -Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -Wl,-rpath=$(LAPACK_LIB_DIR)

PYBIND11_INC = /home/goodchong/python_venv/lib/python3.10/site-packages/pybind11/include

# 存放编译后obj文件
OBJPATH = ./build/obj

# 替换objects为OBJPATH中的文件
OBJS = $(patsubst %.o, $(OBJPATH)/%.o, $(objects))
MY_INCLUDE= /home/goodchong/python_venv/lib/python3.10/site-packages/cmeel.prefix/include/eigen3
# 所有命令行必须以Tab键开始
interface_python: $(OBJPATH) $(OBJS)
	$(CC) $(CFLAG) $(OBJS) -I$(LAPACK_INCLUDE_DIR) -lpthread -liomp5 $(LAPACK_LIB) -I$(PYTHON_LIB) -o ./pyatb/interface_python.so

# 每个单独cpp文件编译的简写形式,等价于:
# myfunction.o:
#	g++ -c myfunction.cpp
	
# $< 是 目标的第一个依赖; $@ 是 目标; $^ 是 目标的所有依赖.
$(OBJPATH)/%.o: %.cpp
	$(CC) $(CFLAG) -I$(PYBIND11_INC) -I$(MY_INCLUDE) -I$(LAPACK_INCLUDE_DIR) -I$(PYTHON_LIB) $< -o $@


$(OBJPATH):
	mkdir -p $(OBJPATH)


# .PHONY保证clean是个假目标,而不是具体文件clean
.PHONY:clean
clean:
	rm -rf $(OBJPATH)/
	rm ./pyatb/interface_python.so
