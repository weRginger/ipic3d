#how to compile and run.

# Pleiades #

Hi
to use pleiades you must first load the following modules. You can do it each time you log in, or put it in your .cshrc or .bashrc depending on the unix shell you use:

> module purge
> module load comp-intel
> module load mpi-intel
> module load hdf5/1.8.3/intel/mpt

Then you can compile with the makefile attached.

To run the code you then need a script like the one attached. That file assumes that the code will find the input fileGEM.inp in the directory where you give the command:
> qsub mpi3D.nasa
And it assumes that the code will be able to save the data in the directory sepcified in the input file. That directory must exist.
The script assumes also that the code is in directory:
~/iPic3D
Note that it sends a message when it starts or end to the given email address so you need to change that too and put yours.

Cheers
Gainni

# Script for Pleiades #
```
#PBS -S /bin/csh

#PBS -l walltime=12:00:00
#PBS -l select=64:ncpus=8
#!PBS -l select=256:ncpus=12:model=wes

#PBS -N earthHR
#PBS -j oe -k eo
#PBS -m abe
#PBS -M me@gmail.com

echo Start: host `hostname`, date `date`
echo PBS id is $PBS_JOBID
echo Assigned nodes: `cat $PBS_NODEFILE`


module purge
module load comp-intel
module load mpi-intel
module load hdf5/1.8.3/intel/mpt

cd ~/iPic3D

mpiexec -np 512 ./iPIC3D GEM.inp

```
# MAkefile Pleiades #
```
DYLD_LIBRARY_PATH = /Users/gianni/Downloads/hdf5-1.6.10/hdf5/lib

CPP = mpicxx
OPTFLAGS=  -O2 -DMPICH_IGNORE_CXX_SEEK

SYSTEM = pleiades

ifeq ($(SYSTEM),ubuntu)
# UBUNTU 
# include files
INC_HDF5 = -I/home/gianni/computer-stuff/hdf5-1.8.9/hdf5/include
# libs
LIB_HDF5 = -L/home/gianni/computer-stuff/hdf5-1.8.9/hdf5/lib
endif

ifeq ($(SYSTEM),mac)
#MAC
# include files
INC_HDF5 = -I/Users/gianni/Downloads/hdf5-1.8.9/hdf5/include 
# libs
LIB_HDF5 = -L/Users/gianni/Downloads/hdf5-1.8.9/hdf5/lib
endif 

ifeq ($(SYSTEM),curie)
# CURIE
# include files
INC_HDF5 = -I/usr/local/hdf5-1.8.8/include
# libs
LIB_HDF5 = -L/usr/local/hdf5-1.8.8/lib
MPELIB = -L/opt/mpi/bullxmpi/1.1.14.3/lib/
endif

ifeq ($(SYSTEM),pleiades)
# include files
# libs
endif


HDF5LIBS =  -lhdf5 -lhdf5_hl  -lz



ipic3D: iPIC3D.cpp Particles3Dcomm.o Particles3D.o ConfigFile.o EllipticF.o
	${CPP} ${OPTFLAGS} -o iPIC3D ${INC_HDF5} ${INC_MPI} \
	iPIC3D.cpp Particles3Dcomm.o Particles3D.o ConfigFile.o EllipticF.o ${LIB_HDF5} ${LIB_MPI} ${HDF5LIBS} ${MPELIB}

iPIC3D.o: iPIC3D.cpp
	${CPP} ${OPTFLAGS} ${INC_HDF5} ${INC_MPI} -c iPIC3D.cpp 

ConfigFile.o: ./ConfigFile/src/ConfigFile.cpp
	${CPP} ${OPTFLAGS} -c ./ConfigFile/src/ConfigFile.cpp

Particles3Dcomm.o: ./particles/Particles3Dcomm.cpp
	${CPP} ${OPTFLAGS} ${INC_HDF5} -c ./particles/Particles3Dcomm.cpp

Particles3D.o: ./particles/Particles3D.cpp 
	${CPP} ${OPTFLAGS} ${INC_HDF5} -c ./particles/Particles3D.cpp

EllipticF.o:    ./mathlib/EllipticF.cpp
	${CPP} ${OPTFLAGS} ${INC_HDF5} -c   ./mathlib/EllipticF.cpp

clean:
	rm -rf *.o iPIC3D data/*.hdf data/*.txt data/*.vtk

```