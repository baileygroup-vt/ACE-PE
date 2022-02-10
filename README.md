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
sec=fltarr(nmaj,nbins,nbins) ; (species,lower energy, upper energy) cross section for cascade forming PE with lower energy by 
; PE with higher energy and collisions (ionization) with species, cm^2
siga=sec ; (species, lost energy, higher energy) cross section for energy loss by PE of higher energy to PE of lower energy
                                ; through collisions (ionizatin & excitation) with species, cm^2, note it is different in format / use from
                                ; sec in that the second dimension is energy lost by electron rather than energy of electron after collision
sigloss=fltarr(nmaj,nbins) ; = total loss cross section
; we consider production and loss due to cascade in energy through ionization & excitation and production of secondaries 
; through ionization



Important model parameters:\
nmaj:  number of major species
nbins: number of electron energy levels
nei: number of energy levels
nst: number of electronic excitation states
jmax : number of altitudes
lmax : number of solar flux bins
tpot : threshold energy (eV) of photoionization of different ionization states of  major species
prob :branching probability of photoionization of major species
primary: primary photoelectron ionization rate (cm-3 s-1)
sigloss:
iimax,
upflux,
downflux,
tflux,
toaflux,
pespec,$
wv1,
wv2,
ssflux,$
sigabs,
sigionx,
auger_energy,
auger_wvln,
di,
flag_states,$
zmaj,
zz,
z,
zt,$
lat,
lon,
sza,
idate,
utsec,
f107,
f107a,
ap,$
first_neutral,
first_ssflux,
first_pxsect,
first_exsect, $
zcol,
tau,
tau_wv,
flux,
photoki,
photoi,
photoi_wv,
aprod,
aloss,$
ts,
tb, 
ta, 
eistates,$
eden,
etemp,$
eiionz,
eiionz_local1,
eiionzk,
exct_local,
eiexcit,
vem5577,
vem6300,
vem2972,
n2a,o1d,o1s,$
branch,
tot_solflux,
eiionz_transp,
eiionzk_transp,
exct_transp,
exct_transp1,
exct_local1,
eiionz_transp1

;NOTE: Added eiionz_ht,tflux_ht,eiionz_v2,tot_solflux       
;C Definitions:
;C SIGS   elastic cross sections for each species, energy; cm2
;C PE     elastic backscatter probabilities for each species, energy
;C PI     inelastic  "
;C SIGA   energy loss cross section for each species, loss, energy; cm2
;C SEC    secondary production xsect for species, Esec, Epri; cm2
;C SIGEX  excitation xsect for each state, species, energy; cm2

;C SIGIX  ionization xsect for each state, species, energy; cm2
;C IIMAX  number of bins for secondary production for each primary energy
;C WW     energy threshold for each excited state, species; eV
;C WW, AO, OMEG, ANU, BB: revised excitation cross section parameters,
;C        from Green & Stolarski (1972) formula (W, A, omega, nu, gamma)
;C AUTO   autoionization coefs (= 0 as autoion. included in ion xsects)
;C THI    energy threshold for each ionized state, species; eV
;C AK, AJ, TS, TA, TB, GAMS, GAMB:  Jackman et al (1977) ioniz. params
;C ENER   energy grid; eV
;C DEL    energy grid spacing; eV
;C NNN    number of excited states for each species
;C NINN   number of ionized states for each species
;C NUM    number of points on elastic data trid for each species
;C EC     data energy grid of elastic xsects and backscatter ratios
;C        for each species; eV
;C CC     elastic xsects on data grid for each species, cm2
;C CE     elastic backscat. probs on data grid for each species; cm2
;C CI     inelastic "
;C
;C Array dimensions:

