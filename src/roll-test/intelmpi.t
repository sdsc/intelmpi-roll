#!/usr/bin/perl -w
# intelmpi roll installation test.  Usage:
# intelmpi.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend.

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $output;

my $TESTFILE = 'tmpintelmpi';
my $NODECOUNT = 4;
my $LASTNODE = $NODECOUNT - 1;

open(OUT, ">$TESTFILE.c");
print OUT <<END;
#include <stdio.h>
#include <mpi.h>

int main (int argc, char **argv) {
  int rank, size;
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  printf("Hello from process %d of %d\\n", rank, size);
  MPI_Finalize();
  return 0;
}
END
close(OUT);

my @COMPILERS = split(/\s+/, 'ROLLCOMPILER');

# intelmpi-install.xml
foreach my $compiler (@COMPILERS) {

    my $compilername = (split('/', $compiler))[0];

    SKIP: {

      skip "intelmpi/$compilername not installed", 6
        if ! -d "/opt/intel/VERSION/compilers_and_libraries/linux/mpi";


       my $command = "module load $compiler intelmpi; mpicc -o $TESTFILE.exe $TESTFILE.c";
        $output = `$command 2>&1`;
        ok(-x "$TESTFILE.exe", "Compile with intelmpi/$compilername");

        SKIP: {

          skip 'No exe', 1 if ! -x "$TESTFILE.exe";

          $command = "module load $compiler intelmpi; mpirun -np $NODECOUNT ./$TESTFILE.exe";
          $output = `$command 2>&1`;
          # Later versions of openmpi require a special option for root runs
          if($output =~ "allow-run-as-root") {
            $command =~ s/mpirun/mpirun --allow-run-as-root/;
            $output = `$command 2>&1`;
          }
          like($output, qr/process $LASTNODE of $NODECOUNT/,
               "Run with intelmpi/$compilername");

        }

        `rm -f $TESTFILE.exe`;

        my $dir = "/opt/modulefiles/mpi/.$compilername/intelmpi";
        `/bin/ls $dir/[0-9]* 2>&1`;
        ok($? == 0, "intelmpi/$compilername module installed");
        `/bin/ls $dir/.version.[0-9]* 2>&1`;
        ok($? == 0, "intelmpi/$compilername version module installed");
        ok(-l "$dir/.version",
           "intelmpi/$compilername version module link created");

      }


}

`rm -fr $TESTFILE*`;
