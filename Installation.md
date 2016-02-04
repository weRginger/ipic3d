iPIC3D is a particle in cell (PIC) code based on the implicit moment method. It is the successor of CELESTE ([web page of CELESTE](http://code.google.com/p/celeste/)) but it is fully parallel and written in C++. The code was developed by Stefano Markdis, Enrico Camporeale, David Burgess and myself (Giovanni Lapenta).

# Installation #
## Before the installation required libraries ##

iPIC3D compiles with all tested MPI libraries. In particular we use regularly intel MPI, SGI MPI, MPICH2, OpenMPI. For example MPICH-2 is available at http://www.mcs.anl.gov/research/projects/mpich2/.

The following libraries are needed: <br>
-'''HDF5''' used for the output of the simulation data. This library can be downloaded at <a href='http://www.hdfgroup.org/HDF5/'>http://www.hdfgroup.org/HDF5/</a>. The latest version needs to be used (older ones are not compatible).<br>
<blockquote>In order to build the HDF5 library, other two libraries can be installed first:<br>
-'''szip''' library, availabe at <a href='ftp://ftp.hdfgroup.org/lib-external/szip/2.1/src/'>ftp://ftp.hdfgroup.org/lib-external/szip/2.1/src/</a>. <br>
-'''zlib''' library, available at <a href='ftp://ftp.hdfgroup.org/lib-external/zlib/1.2/src'>ftp://ftp.hdfgroup.org/lib-external/zlib/1.2/src</a>. <br></blockquote>


When installing these libraries, we recommend to install as root, using:<br>
<pre><code> ./configure<br>
 make<br>
 sudo make install<br>
</code></pre>

At the end the systems tells the path where the include files and the library has been installed. Make a note of it, it is needed to modify to your needs the make file.<br>
<br>
<h2>Install iPIC3D</h2>

- prepare a suitable makefile with the specific location of the KVF, HDF5, MPI include files and libraries. A template makefile is provided, but the environment variables  INC_HDF5, INC_MPI, LIB_HDF5, LIB_MPI must be set at the beginning of the makefile with the correct path for the HDF5, MPI include file, and libraries.<br>
<br>
- run the makefile, just typing ''make'' in the ipic3d directory. The makefile prepares the iPIC3D executable.<br>
<br>
<h2>Run iPic3D</h2>

- mpirun -np <# processors> iPIC3D <nome of inputfile><br>
<br>
For instance:<br>
<pre><code>mpirun -np 2 iPIC3D GEM.inp<br>
</code></pre>
'''Note that the number of processors after -np should match the number of processors defined in /processtopology/VCtopology3D.h as XLEN times YLEN times ZLEN.'''<br>
<br>
<br>
<h1>Running</h1>

<h2>Input file</h2>
The simulation parameters that can be set in the inputfile are:<br>
<br>
<h4>time setup</h4>
dt = time step <br>
ncycles = number of particles <br>
th = theta, the decentering parameter. This value must be between 0 and 1.<br>
<h4>simulation box</h4>
Lx = simulation box length - x direction <br>
Ly = simulation box length - y direction <br>
nxc = number of cells - x direction <br>
nyc = number of cells - y direction  <br>
<h4>particles</h4>
ns = number of species or groups of particles <br>
TrackParticleID= =true, false --> Assign ID to particles <br>
npcelx = {npcx_1,npcx_2,...,npcx_s} = number of particles per cell - Direction X <br>
npcely = {npcy_1,npcy_2,...,npcy_s} = number of particles per cell - Direction Y <br>
qom = {qom_1,qom_2,...,qom_s} charge to mass ratio for different species <br>
uth  = {uth_1,uth_2,...,uth_s} = thermal velocity for different species - Direction X <br>
vth  = {vth_1,vth_2,...,vth_s} = thermal velocity for different species - Direction Y <br>
wth  = {wth_1,wth_2,...,wth_s} = thermal velocity for different species - Direction Z <br>
u0 = {u0_1,u0_2,...,u0_s} = drift velocity   - Direction X  <br>
v0 = {v0_1,v0_2,...,v0_s} = drift velocity   - Direction Y  <br>
w0 = {w0_1,w0_2,...,w0_s} = drift velocity   - Direction Z  <br>
<br>
<br>
<hr><br>
<br>
<br>
bcPfaceXright = Boundary condition for particles on X right simulation wall. The value can be:<br>
<ul>
<li>0 = exit </li>
<li>1 = perfect mirror </li>
<li>2 = riemmision </li>
</ul>
bcPfaceXleft =  Boundary condition for particles. Same as above<br>
bcPfaceYright = Boundary condition for particles. Same as above<br>
bcPfaceYleft =  Boundary condition for particles. Same as above<br>
<br>
<br>
<hr><br>
<br>
<br>
Vinj = Injection velocity form the boundary (Under development)<br>
<br>
<h4>field</h4>
bcEMfaceXright = Boundary condition for Maxell's solver on X right wall. It value can be <ul>
<li>0 perfect conductor </li>
<li>2 open boundary </li>
<li>3 perfect conductor with no charge on the boundary</li>
<li>4 magnetic mirror </li>
</ul>
bcEMfaceXleft =  Boundary condition for Maxell's solver. As above. <br>
bcEMfaceYright = Boundary condition for Maxell's solver. As above. <br>
bcEMfaceYleft =  Boundary condition for Maxell's solver. As above. <br>
<br>
<br>
<hr><br>
<br>
<br>
B0x = guide magnetic field X direction - used for Harris-like equilibrium<br>
B0y = guide magnetic field Y direction - used for Harris-like equilibrium<br>
B0z = guide magnetic field Z direction - used for Harris-like equilibrium<br>
delta = current sheet thickness - used for Harris-like equilibrium<br>
rhoINIT = {rho_1, rho<i>} = density amplitude for differnt species</i><br>
<br>
<br>
<hr><br>
<br>
<br>
bcPHIfaceXright = Boundary Conditions to calculate the potential for the divergence cleaning. set 1 for Dirichilet BC.<br>
bcPHIfaceXleft  = Boundary Conditions to calculate the potential for the divergence cleaning. set 1 for Dirichilet BC.<br>
bcPHIfaceYright = Boundary Conditions to calculate the potential for the divergence cleaning. set 1 for Dirichilet BC.<br>
bcPHIfaceYleft  = Boundary Conditions to calculate the potential for the divergence cleaning. set 1 for Dirichilet BC.<br>

<h4>smoothing</h4>
Smooth = Smoothing value (5-points stencil)<br>
<h4>Linear solvers</h4>
CGtol = stopping criterium tolerance for CG solver for divergence cleaning <br>
GMRES = stopping criterium tolerance for CG solver for divergence cleaning<br>
<br>
<h4>output files</h4>
SaveDirName = "directory for the proc files";<br>
RestartDirName = "directory for the restart files";<br>
<br>
<br>
<hr><br>
<br>
<br>
ParticlesOutputCycle = each ParticlesOutputCycle, save the Particles data <br>
FieldOutputCycle = each FieldOutputCycle, save the Field and energies data <br>
RestartOutputCycle = each RestartOutputCycle, write the restart file<br>



<h2>Parallel Topology</h2>
To change the number of processors and their topology:<br>
# change the call to mpirun (in mpi2D.sh) specifying the right total number of processors<br>
# change XLEN, YLEN, ZLEN in '''VCTopology3D.h''' in the subdirectory processtopology<br>
<br>
<h2>Submitting a iPIC3D job on VIC (KU Leuven only)</h2>
The VIC cluster uses the PBS system to submit jobs. To submit a job on VIC, use:<br>
<br>
# '''qsub mpi3D.nasa'''<br>
<br>
where ''mpi3D.nasa'' is a script, that includes the number of processors and time required for the simulation. A typical script file, called ''mpi3D.nasa'', can be found in the ipic3D directory.<br>
You need to modify the directory where your executable(iPIC3D) is, after cd, and the name of the inputfile for iPIC3D. In addition you need to choose the number of processors after -lnodes, and the time -l walltime.<br>
<br>
<h2>Monitoring Parallel Jobs on VIC (KU Leuven only)</h2>

# '''qstat -a''' shows the status of all the jobs you are running.<br>
# '''qstat -n''' shows the status of the jobs you are running. In addition to the basic information, nodes allocated to a job are listed.<br>
# '''showq''' shows all the queu of jobs on VIC cluster. It includes running, in idle, an in hold jobs.<br>
# '''showstart job_ID''' shows an estimated time for the start of the submitted job with job_ID number.<br>
<br>
To have a graphical interface of the jobs running on VIC, visit<br>
<br>
<a href='http://login.vic.cc.kuleuven.be/ganglia/index.php'>http://login.vic.cc.kuleuven.be/ganglia/index.php</a>