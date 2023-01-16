module purge
module load DefApps
module load fftw

cd SWFFT
make -f GNUmakefile.openmp
cd ../

source /gpfs/alpine/stf007/world-shared/containers/utils/requiredmpilibs.source

jsrun -n8 -c4 -a4 -g1 \
	singularity exec \
	--env PATH=$PATH:/container_usr/bin \
	--env LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
	--bind /autofs/nccs-svm1_home1 \
	--bind /autofs/nccs-svm1_home1:/ccs/home \
	--bind /usr:/container_usr \
	--bind /opt \
	--bind /lib64 \
	../../1_design_base_container/summit_base_image.sif \
	./SWFFT/build.openmp/TestDfft 4 128

jslist -R -d --last 1


#jsrun --smpiargs="-gpu" -n12 -c7 -g1 -a7 -dcyclic --rs_per_host 6 ./ExaMiniMD/src/ExaMiniMD -il ./ExaMiniMD/input/in.lj --comm-type MPI --kokkos-num-devices=12
