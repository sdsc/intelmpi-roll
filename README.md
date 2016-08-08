# SDSC "intelmpi" roll

## Overview

This roll bundles intelmpi

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
% rocks run roll intelmpi | bash
```

In addition to the software itself, the roll installs intelmpi environment
module files in:

```shell
/opt/modulefiles/compilers/intelmpi
```


## Testing

The intelmpi-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/intelmpi.t 
```

