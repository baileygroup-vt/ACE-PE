pro localpe_setup_pxsect

@ace_common_blocks.prg ; common blocks used for all atmospheric chemistry and energetics (ace) software
; see this file for definitions
 
  nst=10 ; NST     number of states produced by photoionization/dissociation, According to Conway 1988
;  nst=3
;___________________________________________________________________________________________________________________________________________________________________  
;  Input cross-section files


probstate_crss='new_prob_states.sav'
;  file has : O_prob_state,O2_prob_state,N2_prob_state
ionabs_crss='new_crosssec.sav'
;  file has: spec_wave,sigi_o,sigi_o2,sigi_n2,sigab_o,sigab_o2,sigab_n2


;____________________________________________________________________________________________

restore, probstate_crss
restore, ionabs_crss

lmax= n_elements(spec_wave)

;___________________________________________________________________________________________________________________________________________________________________

;;     TPOT    ionization potentials for each species, state    ; eV 

;    tpot=[[13.61, 16.93, 18.63, 28.50, 40.00,  0.00],$    ; Dr Bailey's compilation 
;     [12.07, 16.10, 18.20, 20.00,  0.00,  0.00],$
;     [15.60, 16.70, 18.80, 30.00, 34.80, 25.00]]
;


      tpot=[[13.6, 16.9, 18.6, 28.50, 40.00, 531.70,0.0,0.0,0.0,0.0],$  ;adding extra potentials for N2 and O2 for extra states
        [12.1, 16.10, 18.20, 20.3,23.2,27.2, 33.0,39.8,531.70,0.0],$      ;Conway 1988
        [15.60,16.70, 18.80, 25.3,29.0,33.40,36.80,37.8, 43.6,400.]] ;Srimoyee was here !!

;  ___________________________________________________________________________________________________________________________


tpot=transpose(tpot)


;  ___________________________________________________________________________________________________________________________
;From Conway 1988

auger_energy=[531.70,531.70,400.]
auger_wvln=12397./auger_energy; O, O2 and N2


;___________________________________________________________________________________________________________________________________________________________________

;     ..............................................................   
;;    C PROBO, PROBO2, PROBN2; branching ratio data arrays............Dr. Bailey's file
;    filename='read_ephotn2.sav'  ;from read_ephotn2.pro
;    restore,file=filename ; gives aa,bb,probn2,sigin2,sigan2
;    filename='read_ephotoO2.sav'  ;from read_ephotoO2.pro
;    restore,file=filename  ; gives aa,bb,probo2,sigio2,sigao2
;    filename='read_ephotoO.sav'  ;from read_ephotn2.pro
;    restore,file=filename ; gives aa,bb,probo,sigio,sigao
;.....................................................................
;.....................................................................
    
; SIGABS  photoabsorption cross sections,0- O, 1-O2, 2-N2; cm2
; SIGIONx  photoionization cross sections,0- O,1- O2,2- N2; cm2

sigionx=fltarr(nmaj,lmax)
sigabs=fltarr(nmaj,lmax)
     
sigabs(0,*)=sigab_o
sigabs(1,*)=sigab_o2
sigabs(2,*)=sigab_n2

sigionx(0,*)=sigi_o
sigionx(1,*)=sigi_o2
sigionx(2,*)=sigi_n2

     

;PROB    branching ratios for each state, species, and wavelength bin:

prob=fltarr(nst,nmaj,lmax) ;states species and energies, 0-O, 1-O2, 2- N2


;0-O    
n_cols=(size(O_prob_state))[1]  ;number of states

for l=0,lmax-1 do begin
    for k=1,n_cols-1 do $
        prob(k-1,0,l)=O_prob_state(k,l)
    endfor

;1-O2    
n_cols=(size(O2_prob_state))[1]  ;number of states

for l=0,lmax-1 do begin
      for k=1,n_cols-1 do $
        prob(k-1,1,l)=O2_prob_state(k,l)
    endfor


;2-N2    
n_cols=(size(N2_prob_state))[1]  ;number of states

for l=0,lmax-1 do begin
      for k=1,n_cols-1 do $
        prob(k-1,2,l)=N2_prob_state(k,l)
    endfor



first_pxsect=1

return
END




