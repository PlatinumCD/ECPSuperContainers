module purge
module load DefApps
module load cmake
module load gcc

cd amrex
mkdir build
cd build && cmake ..
make -j 16

cd ../Tests/GPU/Vector
make -j 16
cd ../../../..
pwd

source /gpfs/alpine/stf007/world-shared/containers/utils/requiredmpilibs.source

jsrun -n2 -g1 -c1 -a1 \
	singularity exec \
	--env PATH=$PATH:/container_usr/bin \
	--env LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
	--bind /autofs/nccs-svm1_home1 \
	--bind /autofs/nccs-svm1_home1:/ccs/home \
	--bind /usr:/container_usr \
	--bind /opt \
	--bind /lib64 \
	../../1_design_base_container/summit_base_image.sif \
	./amrex/Tests/GPU/Vector/main3d.gnu.ex

jslist -R -d --last 1


#jsrun --smpiargs="-gpu" -n12 -c7 -g1 -a7 -dcyclic --rs_per_host 6 ./ExaMiniMD/src/ExaMiniMD -il ./ExaMiniMD/input/in.lj --comm-type MPI --kokkos-num-devices=12
