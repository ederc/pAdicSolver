module HeckeExt

export broadcast, iterate, collect, matrix, rectangular_solve, my_nullspace, eigen, eigvecs, eigspaces, charpoly, MyEigen

export /, valuation, abs, modp, test_rings, rand, random_test_matrix, padic_qr, inverse_iteration, iseigenvector

include("matrix_util_ext.jl")
include("padic_util.jl")



end
