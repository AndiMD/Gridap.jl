include("../../src/CellValues/CompressedCellValues.jl")

module CompressedCellValuesTests

using Test
using Gridap
using ..CompressedCellValues

values = [10,20,31]
ptrs = [1,2,3,3,2,2]
r = values[ptrs]
cv = IterCompressedCellValue(values,ptrs)
test_iter_cell_value(cv,r)

cv = IndexCompressedCellValue(values,ptrs)
test_index_cell_value(cv,r)

l = 10
v = 3
ccv = ConstantCellValue(v,l)
cv = IndexCompressedCellValue(ccv)
test_index_cell_value(cv,fill(v,l))

@test cv == cv
@test cv ≈ cv

values = [10,20,31]
ptrs = [1,2,3,3,2,2]
cv = CompressedCellValue(values,ptrs)

cv2 = apply(-,cv)
@test isa(cv2,IndexCompressedCellValue)
r = -values[ptrs]
test_index_cell_value(cv2,r)

values1 = [10,20,31]
values2 = [11,21,51]
ptrs = [1,2,3,3,2,2]
cv1 = CompressedCellValue(values1,ptrs)
cv2 = CompressedCellValue(values2,ptrs)
cv3 = apply(-,cv1,cv2)
@test isa(cv3,IndexCompressedCellValue)
r = values1[ptrs] - values2[ptrs]
test_index_cell_value(cv3,r)

values1 = [10,20,31]
values2 = [11,21,51]
ptrs1 = [1,2,3,3,2,2]
ptrs2 = [1,1,3,2,3,2]
cv1 = CompressedCellValue(values1,ptrs1)
cv2 = CompressedCellValue(values2,ptrs2)
cv3 = apply(-,cv1,cv2)
@test ! isa(cv3,IndexCompressedCellValue)
r = values1[ptrs1] - values2[ptrs2]
test_index_cell_value(cv3,r)

values1 = [10,20,31]
values2 = [11,21,51]
ptrs1 = [1,2,3,3,2,2]
ptrs2 = [1,1,3,2,3,2]
cv1 = IterCompressedCellValue(values1,ptrs1)
cv2 = IterCompressedCellValue(values2,ptrs2)
cv3 = apply(-,cv1,cv2)
@test ! isa(cv3,IndexCompressedCellValue)
r = values1[ptrs1] - values2[ptrs2]
test_iter_cell_value(cv3,r)

values = [[10,30],[20,10,40],[31,]]
ptrs = [1,2,3,3,2,2]
cv = CompressedCellValue(values,ptrs)

cv2 = apply(-,cv,broadcast=true)
@test isa(cv2,IndexCompressedCellValue)
r = -values[ptrs]
test_index_cell_array(cv2,r)

end # module
