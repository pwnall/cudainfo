CUDA_CC=nvcc
prefix=/usr/local

all: cudainfo

cudainfo: cudainfo.cu
	$(CUDA_CC) -o cudainfo cudainfo.cu

.PHONY: all clean install

install: cudainfo
	install -m 0755 cudainfo $(prefix)/bin

clean:
	rm -f cudainfo
