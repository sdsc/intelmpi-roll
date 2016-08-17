#!/usr/bin/perl -w
# intelmpi roll installation test.  Usage:
# intelmpi.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend.

use Test::More qw(no_plan);

my $output;

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '^(?!Frontend).';
my $isInstalled = -d '/opt/intel';
my $compilersInstalled = "ROLLNAME" eq "intelmpi";

if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'intelmpi installed');
} else {
  ok(! $isInstalled, 'intelmpi not installed');
}

my $TESTFILE = 'tmpintelmpi';

open(OUT, ">$TESTFILE.c");
print OUT <<END;
#include <stdio.h>
int main(char **args) {
  printf("Hello world\\n");
  return 0;
}
END
close(OUT);

open(OUT, ">$TESTFILE.f");
print OUT <<END;
      PROGRAM HELLO
      PRINT*, 'Hello world!'
      END
END
close(OUT);

# software.intel.com/sites/default/files/article/171460/mkl-lab-solution.c
open(OUT, ">$TESTFILE.mkl.c");
print OUT <<'END';
/*
********************************************************************************
*   Copyright(C) 2004-2011 Intel Corporation. All Rights Reserved.
*   
*   The source code, information  and  material ("Material") contained herein is
*   owned  by Intel Corporation or its suppliers or licensors, and title to such
*   Material remains  with Intel Corporation  or its suppliers or licensors. The
*   Material  contains proprietary information  of  Intel or  its  suppliers and
*   licensors. The  Material is protected by worldwide copyright laws and treaty
*   provisions. No  part  of  the  Material  may  be  used,  copied, reproduced,
*   modified, published, uploaded, posted, transmitted, distributed or disclosed
*   in any way  without Intel's  prior  express written  permission. No  license
*   under  any patent, copyright  or  other intellectual property rights  in the
*   Material  is  granted  to  or  conferred  upon  you,  either  expressly,  by
*   implication, inducement,  estoppel or  otherwise.  Any  license  under  such
*   intellectual  property  rights must  be express  and  approved  by  Intel in
*   writing.
*   
*   *Third Party trademarks are the property of their respective owners.
*   
*   Unless otherwise  agreed  by Intel  in writing, you may not remove  or alter
*   this  notice or  any other notice embedded  in Materials by Intel or Intel's
*   suppliers or licensors in any way.
*
********************************************************************************
*   Content : Simple MKL Matrix Multiply C example
*
********************************************************************************/

#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include "mkl.h"

void print_arr(int N, char * name, double* array);
void init_arr(int N, double* a);
void Dgemm_multiply(double* a,double*  b,double*  c, int N);


int main(int argc, char* argv[])
{
	clock_t start, stop;
	int i, j;
	int N;
	double* a;
	double* b;
	double* c;
	if(argc < 2)
	{
		printf("Enter matrix size N=");
		//please enter small number first to ensure that the 
		//multiplication is correct! and then you may enter 
		//a "reasonably" large number say like 500 or even 1000
		scanf("%d",&N);
	}
	else
	{
		N = atoi(argv[1]);
	}
	
	a=(double*) malloc( sizeof(double)*N*N );
	b=(double*) malloc( sizeof(double)*N*N );
	c=(double*) malloc( sizeof(double)*N*N );

	init_arr(N,a);
	init_arr(N,b);

	//DGEMM Multiply
	//reallocate to force cash to be flushed
	a=(double*) malloc( sizeof(double)*N*N );
	b=(double*) malloc( sizeof(double)*N*N );
	c=(double*) malloc( sizeof(double)*N*N );
	init_arr(N,a);
	init_arr(N,b);

	start = clock();
	//for(i=0;i<1000;i++)
	Dgemm_multiply(a,b,c,N);
	stop = clock();

	printf("Dgemm_multiply(). Elapsed time = %g seconds\n",
		((double)(stop - start)) / CLOCKS_PER_SEC);
	//print simple test case of data to be sure multiplication is correct
	if (N < 7) {
		print_arr(N,"a", a);
		print_arr(N,"b", b);
		print_arr(N,"c", c);
	}

	free(a);
	free(b);
	free(c);

	return 0;
}


//DGEMM way. The PREFERED way, especially for large matrices
void Dgemm_multiply(double* a,double*  b,double*  c, int N)
{	

	double alpha = 1.0, beta = 0.;
	int incx = 1;
	int incy = N;
	cblas_dgemm(CblasRowMajor,CblasNoTrans,CblasNoTrans,N,N,N,alpha,b,N,a,N,beta,c,N);
}

//initialize array with random data
void init_arr(int N, double* a)
{	
	int i,j;
	for (i=0; i< N;i++) {
		for (j=0; j<N;j++) {
			a[i*N+j] = (i+j+1)%10; //keep all entries less than 10. pleasing to the eye!
		}
	}
}

//print array to std out
void print_arr(int N, char * name, double* array)
{	
	int i,j;	
	printf("\n%s\n",name);
	for (i=0;i<N;i++){
		for (j=0;j<N;j++) {
			printf("%g\t",array[N*i+j]);
		}
		printf("\n");
	}
}
END


my @COMPILERS = split(/\s+/, 'ROLLCOMPILER');

# intelmpi-install.xml

SKIP: {

  skip 'intelmpi compiler not installed', 10 if ! $isInstalled;

  if($compilersInstalled) {

    $output = `module load intel/VERSION; icc -o $TESTFILE.c.exe $TESTFILE.c 2>&1`;
    ok($? == 0, 'intel C compiler works');
    $output = `module load intel/VERSION; ./$TESTFILE.c.exe`;
    ok($? == 0, 'compiled C program runs');
    like($output, qr/Hello world/, 'compile C program correct output');

    $output = `module load intel/VERSION; ifort -o $TESTFILE.f.exe $TESTFILE.f 2>&1`;
    ok($? == 0, 'intel FORTRAN compiler works');
    $output = `module load intel/VERSION; ./$TESTFILE.f.exe`;
    ok($? == 0, 'compiled FORTRAN program runs');
    like($output, qr/Hello world/, 'compile FORTRAN program correct output');

    $output = `module load intel/VERSION; man icc 2>&1`;
    ok($output =~ /Intel/, 'man works for intel');
  
    `/bin/ls /opt/modulefiles/compilers/intel/[0-9.]* 2>&1`;
    ok($? == 0, 'intel module installed');
    `/bin/ls /opt/modulefiles/compilers/intel/.version.[0-9.]* 2>&1`;
    ok($? == 0, 'intel version module installed');
    ok(-l '/opt/modulefiles/compilers/intel/.version',
       'intel version module link created');
 }

  $output = `module load mkl/L_MKL_VERS; gcc -o $TESTFILE.mkl.exe $TESTFILE.mkl.c -I\${MKL_ROOT}/include -L\${MKL_ROOT}/intel64/lib -lmkl_gf_lp64 -lmkl_core -lmkl_gnu_thread -lpthread -lm -lgomp 2>&1`;
  ok($? == 0, 'mkl compiles w/gnu C');
  $output = `module load mkl/L_MKL_VERS; ./$TESTFILE.mkl.exe 5`;
  ok($? == 0, 'mkl runs w/gnu C');
  like($output, qr/115\s+150\s+185\s+220\s+255/, 'mkl correct output w/gu C');

  `/bin/ls /opt/modulefiles/applications/mkl/[0-9.]* 2>&1`;
  ok($? == 0, 'mkl module installed');
  `/bin/ls /opt/modulefiles/applications/mkl/.version.[0-9.]* 2>&1`;
  ok($? == 0, 'mkl version module installed');
  ok(-l '/opt/modulefiles/applications/mkl/.version',
     'mkl version module link created');

}

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

foreach my $compiler (@COMPILERS) {

    my $compilername = (split('/', $compiler))[0];

    SKIP: {

      skip "intelmpi/$compilername not installed", 6
        if ! -d "/opt/intel/VERSION/compilers_and_libraries_VERSION/linux/mpi";


       my $command = "module load $compiler intelmpi; mpicc -o $TESTFILE.exe $TESTFILE.c";
        $output = `$command 2>&1`;
        ok(-x "$TESTFILE.exe", "Compile with intelmpi/$compilername");

        SKIP: {

          skip 'No exe', 1 if ! -x "$TESTFILE.exe";

          $command = "module load $compiler intelmpi; mpirun -np $NODECOUNT ./$TESTFILE.exe";
          $output = `$command 2>&1`;
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
