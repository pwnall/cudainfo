# cudainfo

This is a small CLI tool that
[queries the properties of CUDA devices](https://devblogs.nvidia.com/parallelforall/how-query-device-properties-and-handle-errors-cuda-cc/)
on your system, and outputs them in a [YAML](http://yaml.org/) format. The
output is intended to

## Requirements

This tool requires
[nVidia's CUDA Toolkit](https://developer.nvidia.com/cuda-downloads).

[Homebrew](http://brew.sh/) can install the requirement.

```bash
brew cask install cuda
```

## Installation

Distribution packages are hopefully coming. Until then, the typical
[make workflow](https://en.wikipedia.org/wiki/Make_(software)) can be used to
build and install this tool from source.

```bash
git clone https://github.com/pwnall/cudainfo
cd cudainfo
make
make install
```

## Usage

The `cudainfo` binary will output a YAML file as shown below. The file contains
an array with one element per CUDA GPU.

```yaml
---
- name: "GeForce GT 650M"
  compute_version: "3.0"
  pci_address: "01:00"
  total_global_memory: 1073414144
  total_constant_memory: 65536
  shared_memory_per_block: 49152
  max_malloc_pitch: 2147483647
  texture_alignment: 512
  registers_per_block: 65536
  max_threads_per_block: 1024
  max_thread_block_dimension: [1024, 1024, 64]
  max_grid_size: [2147483647, 65535, 65535]
  warp_size_threads: 32
  multi_processor_count: 2
  clock_rate_khz: 900000
  pci_bus_id: 1
  pci_device_id: 0
  compute_major: 3
  compute_minor: 0
  integrated: false
  supports_device_overlap: true
  kernel_execution_timeout_enabled: true
  can_map_host_memory: true
  supports_concurrent_kernels: true
  ecc_enabled: false
  using_tcc_driver: false
  compute_mode: default
```

### Programmatic Usage

The following [Ruby](https://www.ruby-lang.org/en/) example parses the tool's
output and extracts the
[CUDA compute versions](https://developer.nvidia.com/cuda-gpus) implemented by
all the GPUs on the system.

```ruby
require 'yaml'
cuda_info = YAML.load `./cudainfo`
compute_versions = cuda_info.map { |gpu| gpu['compute_version'] }.uniq
puts compute_versions.sort.join(',')
```

The example is only intended to demonstrate the ease of parsing the output
coming from `cudainfo`. Please do not think that the tool is limited to usage
with Ruby, or to this particular purpose.

## License

This tool is Copyright (c) 2017 Victor Costan, and distributed under the MIT
License.
