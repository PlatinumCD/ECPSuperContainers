#include "getDev.h"
#include <cuda.h>
#include <cuda_runtime.h>
#include <stdlib.h>
#include <stdio.h>

__global__ void vector_add(float *out, float *a, float *b) {
    out[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}

void CudaMod::get_dev() {
  int nDevices;

  cudaGetDeviceCount(&nDevices);
  printf("Number of CUDA devices: %d\n", nDevices); 
  for (int i = 0; i < nDevices; i++) {
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, i);
    printf("GPU ID: %d\n", prop.pciBusID);
  }


  long int N = 10000000;
  float *a, *b, *out; 

  // Allocate memory
  a   = (float*)malloc(sizeof(float) * N);
  b   = (float*)malloc(sizeof(float) * N);
  out = (float*)malloc(sizeof(float) * N);

  // Initialize array
  for(int i = 0; i < N; i++){
    a[i] = 1.0f; b[i] = 2.0f;
  }


  printf("Executing vector add\n");

  vector_add<<<N,8>>>(out, a, b);
  free(a);
  free(b);
  free(out);
}

