module purge
module load DefApps
module load cmake
module load nvhpc
module load kokkos

export OMPI_CXX=${OLCF_KOKKOS_ROOT}/bin/nvcc_wrapper

cd ExaMiniMD/src
make -j KOKKOS_ARCH=Power8,Pascal60 KOKKOS_DEVICES=Cuda KOKKOS_PATH=${OLCF_KOKKOS_ROOT} CXX=mpicxx
cd ../..

source /gpfs/alpine/stf007/world-shared/containers/utils/requiredmpilibs.source

jsrun --smpiargs="-gpu" -n12 -c7 -g1 -a7 -dcyclic \
	--rs_per_host 6 \
	singularity exec --nv \
	--env PATH=$PATH:/container_usr/bin \
	--env LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
	--bind /autofs/nccs-svm1_home1 \
	--bind /autofs/nccs-svm1_home1:/ccs/home \
	--bind /usr:/container_usr \
	--bind /opt \
	--bind /lib64 \
	../1_design_base_container/summit_base_image.sif \
	./ExaMiniMD/src/ExaMiniMD -il ./ExaMiniMD/input/in.lj --comm-type MPI --kokkos-num-devices=12

jslist -R -d --last 1

#module load kokkos
#jsrun --smpiargs="-gpu" -n12 -c7 -g1 -a7 -dcyclic --rs_per_host 6 ./ExaMiniMD/src/ExaMiniMD -il ./ExaMiniMD/input/in.lj --comm-type MPI --kokkos-num-devices=12
