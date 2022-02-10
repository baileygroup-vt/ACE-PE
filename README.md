# ACE-PE
The PE model is run using sample_localpe_v6\
The main modules in the model are:\
ace_common_blocks.prg- Common block for the PE model\ 
localpe_setup_pxsect.pro - Calculates the photoionization cross-sections of the major species O,O2 and N2\
localpe_setup_exsect.pro - Calculates the electron impact excitation cross-sections \
ace_setup_elasticx.pro - This procedure uses tabulated values of elastic cross section parameters for o, o2, and n2 and places them onto the chosen energy grid\
localpe_neutralatm.pro - calculates the netral density and colum densities of the N2, O2 and O\
localpe_approxden.pro\
localpe_ssflux.pro- Contains the input solar flux data\
localpe_photoionz.pro- Calculates the photoionizaiton rates of major species\
localpe.pro- Local calculation for photoelectron rates of major species\
ace_etransport.pro- Trasnport calculation for photoelectron rates of major species using two-stream approach, based on GLOW model two-stream transport calulation \



Important model parameters:\
nmaj:  number of major species\
nbins: number of electron energy levels\
nei: number of energy levels\
nst: number of electronic excitation states\
jmax : number of altitudes\
lmax : number of solar flux bins\
tpot : threshold energy (eV) of photoionization of different ionization states of  major species\
prob :branching probability of photoionization of major species\
primary: primary photoelectron ionization rate (cm-3 s-1)\

wv1: Solar flux wavelength (lower bound )\
wv2:  Solar flux wavelength (upper bound )\
ssflux: Solar flux\
sigabs: Photoabsorption cross-section (cm2)\
sigionx: : Photoabsorption cross-section (cm2)\
auger_energy: Auger Energy (eV) for major species\
auger_wvln: : Auger Wavelength for major species\


Electron Impact Cross-sections:\
sigloss: sigloss total loss cross section (cm2),i.e., production and loss due to cascade in energy through ionization & excitation and production of secondaries 
through ionization \
sec: cross section for cascade forming PE with lower energy by PE with higher energy and collisions (ionization) with species, cm^2\
siga: cross section for energy loss by PE of higher energy to PE of lower energy through collisions (ionizatin & excitation) with species, cm^2\
sigex:  excitation cross-section for each state, species, energy; cm2\
sigix:  ionization cross-section for each state, species, energy; cm2\

upflux: Upward Photoelectron flux (cm-2 s-1 eV-1)\
downflux: Downward Photoelectron flux (cm-2 s-1 eV-1)\
tflux: Total Photoelectron flux (cm-2 s-1 eV-1); from transport calculation\
pespec: Total Photoelectron flux (cm-2 s-1 eV-1); from local calculation\
zmaj:Number density of major species cm-3\
zz: Altitude in km\
lat: Latitude in degrees\
lon: : Longitude in degrees\
sza: Solar Zenith angle in radians\
idate: Date yyyydoy\
utsec: Universal Time in seconds\
f107: F10.7 daily index\
f107a: F10.7 81-day average index\
ap: Ap index\
zcol: Column density (cm-2) of major species\
tau: Optical depth\
eden: Electron Density (cm-3)\
etemp: ELectron Temperature (K)\
eiionz
eiionz_local1,
eiionzk,
exct_local,
eiexcit,
eiionz_transp,
eiionzk_transp,
exct_transp,
exct_transp1,
exct_local1,
eiionz_transp1

sigs:  elastic cross sections for each species, energy; cm2\
PE:     elastic backscatter probabilities for each species, energy\
PI:     inelastic backscatter probabilities for each species, energy\

WW:     energy threshold for each excited state, species; eV\
THI:    energy threshold for each ionized state, species; eV\
ener:   electron energy grid; eV\
del:    electron  energy grid spacing; eV\
NNN:    number of excited states for each species\
NINN:   number of ionized states for each species\
NUM:    number of points on elastic data trid for each species\
EC:     data energy grid of elastic xsects and backscatter ratios  for each species; eV\
CC:     elastic cross-sections on data grid for each species, cm2\
CE:     elastic backscat. probs on data grid for each species; cm2\
CI:     inelastic backscat. probs on data grid for each species; cm2\
