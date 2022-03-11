#include <iostream>
#include <pybind11/pybind11.h>
#include <torch/extension.h>
#include <vector>

torch::Tensor remap(torch::Tensor a);

PYBIND11_MODULE(remap, m) {
  m.def("remap", &remap, "remap the indexes");
}