# SDSC "intelmpi" roll

## Overview

This roll bundles a intel compiler/mkl version plus intelmpi

For more information about the various packages included in the intelmpi roll please visit their official web pages:

- <a href="/https://software.intel.com/en-us/intel-mpi-library" target="_blank">intelmpi</a> implements the high performance Message Passing Interface Version 3.0 specification on multiple fabrics


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate intelmpi source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.


## Building

To build the intelmpi-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `intelmpi-*.disk1.iso`.  If you built
the roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll intelmpi
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents
of the intelmpi-roll.  To avoid cluttering the cluster frontend with unused
software, the intelmpi-roll is configured to install only on compute and
login nodes. To force installation on your frontend, run this command after
adding the intelmpi-roll to your distro

```shell
% rocks run roll intelmpi host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.

In addition to the software itself, the roll installs intelmpi environment
module files in:

```shell
/opt/modulefiles/compilers/intelmpi (for the compiler component)
/opt/modulefiles/mpi/intelmpi (for the mpi component)
```


## Testing

The intelmpi-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/intelmpi.t 
```

