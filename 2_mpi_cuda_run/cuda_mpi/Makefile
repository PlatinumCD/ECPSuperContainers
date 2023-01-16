all:
	mpic++ -c exampleMPI.cc
	nvcc -c getDev.cu
	mpic++ exampleMPI.o getDev.o -L${CUDA_DIR}/lib64 -lcudart -o myCudaMpi

clean:
	rm *.o myCudaMpi
