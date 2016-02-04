## Pressure Tensor ##

The first three moments are defined as

n\_s = sum\_p q\_p for all particles of species s

u_{is} = sum\_p q\_p u_{ip}/n\_s for all components i=x,y,z

P_{ijs} = sum\_p q\_p u_{ip}u_{jp}_

The sums are taken over each cell (with appropriate weighting factors as explained in my class Tuesday).

Note that the pressure tensor is defined with the full velocity and not the velocity relative to mean, so that part needs to be removed if you want the true pressure tensor. Note also the sum is over the particle charge, not mass, so you need also to rescale by m/q for that species to get the usual definitions.

Here are the derivations,


Usual Pi_{ijs} = sum\_p m\_p du_{ip}du_{jp} = (1/qom) sum\_p q_{ip} (u_{ip}-u{is}) (u_{jp}-u{js}) =(1/qom) P_{ijs} -n\_s u_{is} u_{js}_

## What happens to unresolved waves? ##
This is typically the case of Langmuir waves but for extreme cases (such as the study of turbulence with Grigol Gogoberitze where we use huge time steps and grid spacings) othe rwaves can also not be resolved. The questions was investigated in depth in the early days of implicit pic and its solution is reported in the following paper:

[An implicit method for electromagnetic plasma simulation in two dimensions by Brackbill and Forslund](http://www.sciencedirect.com/science?_ob=ArticleURL&_udi=B6WHY-4DD1RW6-5Y&_user=10&_coverDate=05%2F31%2F1982&_alid=687272172&_rdoc=2&_fmt=summary&_orig=search&_cdi=6863&_sort=d&_docanchor=&view=c&_ct=2&_acct=C000050221&_version=1&_urlVersion=0&_userid=10&md5=c0b4c03ab850c438c55a385ce325a4ec)

There a complete analysis of the dispersion relation for the numerical plasma of the pic simulation is derived. One can then compare the dispersion relation of the physical and of the simulated plasma giving complete information on the real and imaginary part of the /omega for both. If you note especially figure 1 and 2, you can see what happens to the dispersion relation of the waves as k is increased. The bottom line is that for small k the Langmuir waves are resolved correctly, for large k, they are still present but distorted. However, non-linear simulations show that the non-linear energy dissipation (by Landau damping) of the large k waves is still present. The end effect is that unresolved waves are not unstable but rather provide still the physical channel for dissipating the energy cascade as in the physical system. In extreme summary the Langmuir waves are there correctly for small k and are approximately present for large k. The details are in the paper.

It will be interesting to see how well the electron holes are produced. But this means resolving the scale of the electron holes, which we do with great resolution and therefore the scales of interest are those that are well resolved and there should be no problem. The comparison already done of electron hole simulations (for 2-stream) confirm this point of view.


## ConservedQunatities.txt ##

**the second column is total energy,** then total momentum,
**electric field energy,** magnetic field energy
