#ifndef USE_EIGEN_H
#define USE_EIGEN_H


#define EIGEN_USE_MKL_ALL
#include <Eigen/Eigen>
#include <complex>

using namespace Eigen;



using SparseMatrixXcdC = Eigen::SparseMatrix<std::complex<double>, Eigen::ColMajor>;
using SparseMatrixXcdR = Eigen::SparseMatrix<std::complex<double>, Eigen::RowMajor>;






#endif