
CPP = mpicxx
OPTFLAGS=  -O2 -DMPICH_IGNORE_CXX_SEEK

SYSTEM=linux64

ifeq ($(SYSTEM),linux64)
  INC_HDF5 = -I/usr/local/hdf5/include
  LIB_HDF5 = -L/usr/local/hdf5/lib
endif

ifeq ($(SYSTEM),curie)
  INC_HDF5 = -I/usr/local/hdf5-1.8.8/include
  LIB_HDF5 = -L/usr/local/hdf5-1.8.8/lib
  MPELIB = -L/opt/mpi/bullxmpi/1.1.14.3/lib/
endif

HDF5LIBS = -lhdf5 -lhdf5_hl 

ipic3D: iPIC3D.cpp Particles3Dcomm.o Particles3D.o ConfigFile.o
	${CPP} ${OPTFLAGS} -o iPIC3D ${INC_HDF5} ${INC_MPI} \
	iPIC3D.cpp Particles3Dcomm.o Particles3D.o ConfigFile.o ${LIB_HDF5} ${LIB_MPI} ${HDF5LIBS} ${MPELIB}

iPIC3D.o: iPIC3D.cpp
	${CPP} ${OPTFLAGS} ${INC_HDF5} ${INC_MPI} -c iPIC3D.cpp 

ConfigFile.o: ./ConfigFile/src/ConfigFile.cpp
	${CPP} ${OPTFLAGS} -c ./ConfigFile/src/ConfigFile.cpp

Particles3Dcomm.o: ./particles/Particles3Dcomm.cpp
	${CPP} ${OPTFLAGS} ${INC_HDF5} -c ./particles/Particles3Dcomm.cpp

Particles3D.o: ./particles/Particles3D.cpp 
	${CPP} ${OPTFLAGS} ${INC_HDF5} -c ./particles/Particles3D.cpp

clean:
	rm -rf *.o iPIC3D
