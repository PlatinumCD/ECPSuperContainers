module purge
module load DefApps

mpicc mpi_example.c

source /gpfs/alpine/stf007/world-shared/containers/utils/requiredmpilibs.source

jsrun -n2 \
	singularity exec \
	--bind /autofs/nccs-svm1_home1 \
	--bind /autofs/nccs-svm1_home1:/ccs/home \
	--bind /usr:/usr \
	../../1_design_base_container/summit_base_image.sif \
	./a.out
