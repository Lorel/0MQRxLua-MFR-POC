# Experiment results on throughput


## Context

The designed experiment aims to check if the scalability of the architecture by comparing how the time for processing given entries evolves according to the number of workers deployed in the processing pipeline.
Each element of the pipeline is running in its Docker container (based on the image produced by this [Dockerfile](../../../docker-image/Dockerfile)).
Containers are distributed accross a cluster of 2 nodes.
Each node is a SGX machine on Ubuntu 14.04.5 (kernel 4.2.0-42-generic), with 8 CPUs and 8 GB RAM, running a Docker daemon (version 1.13.0).
The cluster of nodes is handled by Docker Swarm (version 1.2.5).

All stats data used here for plots have been retrieved from Docker stats.


## Input files

* `2008.csv`: 689413344 bytes, 7009729 entries
* `2007.csv`: 702878193 bytes, 7009729 entries
* `2006.csv`: 672068096 bytes, 7009729 entries
* `2005.csv`: 671027265 bytes, 7140597 entries

Each experiment process all these data files (28745465 entries).


## Regular processing

All workers are processing on a regular Lua machine.

### One worker by processing stage

![schema](../images/4_data_1_worker_by_type.png)

Files: [data/1-workers/](data/1-workers/)

Datas:
* Timestamp (s)
* Cpuusage (ticks)
* Memory usage (bytes)
* Rx (bytes)
* Tx (bytes)

Throughput CDF:

![throughput](outputs/tput_upload_1-workers.png)

CPU usage CDF:

![throughput](outputs/cpu_usage_1-workers.png)

Memory usage CDF:

![throughput](outputs/memory_usage_1-workers.png)


### Two workers by processing stage

![schema](../images/4_data_2_workers_by_type.png)

File: [data/2-workers/](data/2-workers/)

Datas:
* Timestamp (s)
* Cpuusage (ticks)
* Memory usage (bytes)
* Rx (bytes)
* Tx (bytes)

Throughput:

![throughput](outputs/tput_upload_2-workers.png))

CPU usage CDF:

![throughput](outputs/cpu_usage_2-workers.png)

Memory usage CDF:

![throughput](outputs/memory_usage_2-workers.png)


### Four workers by processing stage

![schema](../images/4_data_4_workers_by_type.png)

File: [data/4-workers/](data/4-workers/)

Datas:
* Timestamp (s)
* Cpuusage (ticks)
* Memory usage (bytes)
* Rx (bytes)
* Tx (bytes)

Throughput:

![throughput](outputs/tput_upload_4-workers.png))

CPU usage CDF:

![throughput](outputs/cpu_usage_4-workers.png)

Memory usage CDF:

![throughput](outputs/memory_usage_4-workers.png)



## Secure processing

### One worker by processing stage

The mapper is processing inside a trusted SGX enclave using LuaSGX, other workers are processing on a regular Lua machine.

![schema](../images/4_data_1_worker_by_type_sgxmapper.png)

Files: [data/1-workers-mappersgx/](data/1-workers-mappersgx/)

Datas:
* Timestamp (s)
* Cpuusage (ticks)
* Memory usage (bytes)
* Rx (bytes)
* Tx (bytes)

Throughput:

![throughput](outputs/tput_upload_1-workers-mappersgx.png)

CPU usage CDF:

![throughput](outputs/cpu_usage_1-workers-mappersgx.png)

Memory usage CDF:

![throughput](outputs/memory_usage_1-workers-mappersgx.png)


### Two workers by processing stage

![schema](../images/4_data_2_workers_by_type_sgxmapper.png)

File: [data/2-workers-mappersgx/](data/2-workers-mappersgx/)

Datas:
* Timestamp (s)
* Cpuusage (ticks)
* Memory usage (bytes)
* Rx (bytes)
* Tx (bytes)

Throughput:

![throughput](outputs/tput_upload_2-workers-mappersgx.png)

CPU usage CDF:

![throughput](outputs/cpu_usage_2-workers-mappersgx.png)

Memory usage CDF:

![throughput](outputs/memory_usage_2-workers-mappersgx.png)


### Four workers by processing stage

![schema](../images/4_data_4_workers_by_type_sgxmapper.png)

File: [data/4-workers-mappersgx/](data/4-workers-mappersgx/)

Datas:
* Timestamp (s)
* Cpuusage (ticks)
* Memory usage (bytes)
* Rx (bytes)
* Tx (bytes)

Throughput:

![throughput](outputs/tput_upload_4-workers-mappersgx.png)

CPU usage CDF:

![throughput](outputs/cpu_usage_4-workers-mappersgx.png)

Memory usage CDF:

![throughput](outputs/memory_usage_4-workers-mappersgx.png)
