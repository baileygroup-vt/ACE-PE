# ACE-PE
The PE model is run using sample_localpe_v6\
The main modules in the model are:\
ace_common_blocks.prg- Common block for the PE model\
localpe_setup_pxsect.pro - Calculates the photoionization cross-sections of the major species N2, O2 and O\
localpe_setup_exsect.pro - Calculates the electron impact excitation cross-sections \
ace_setup_elasticx.pro - This procedure uses tabulated values of elastic cross section parameters for o, o2, and n2 and places them onto the chosen energy grid\
localpe_neutralatm.pro - calculates the netral density and colum densities of the N2, O2 and O\
localpe_approxden.pro\
localpe_ssflux.pro\
localpe_photoionz.pro\
localpe.pro\
ace_etransport.pro\

