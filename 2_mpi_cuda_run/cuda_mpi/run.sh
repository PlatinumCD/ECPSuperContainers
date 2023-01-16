module purge
module load DefApps
module load nvhpc

make

source /gpfs/alpine/stf007/world-shared/containers/utils/requiredmpilibs.source

jsrun --smpiargs="-gpu" -n2 -c1 -g1 -a1 \
	--rs_per_host 1 \
	singularity exec --nv \
	--env PATH=$PATH:/singularity_usr/bin \
	--env LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
	--bind /autofs/nccs-svm1_home1 \
	--bind /autofs/nccs-svm1_home1:/ccs/home \
	--bind /usr:/singularity_usr \
	--bind /opt \
	--bind /lib64 \
	../../1_design_base_container/summit_base_image.sif \
	./myCudaMpi

jslist -R -d --last 1
