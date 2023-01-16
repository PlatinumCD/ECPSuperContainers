uname -m
cat /etc/os-release

podman build -t summit_base_image -f summit_base_image.dockerfile .

podman save -o summit_base_image.tar localhost/summit_base_image

singularity build summit_base_image.sif docker-archive://summit_base_image.tar
