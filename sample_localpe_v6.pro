; This version tests the SQ'05 +FE line provided in 
; M5_stanbads_myver.pro and X9_stanbands_myver.pro
;testing for a total of 4 time periods
;m5 time=0, time= 316. x9 time=0, time= 720

;____________________________________________________________________________________________________________________________________________________________________

;_______________________________________________Main photoelectron calling function__________________________________________________________________________________

;Electron impact ionisation cross-sections
@localpe_setup_exsect
@ace_etransport  
@ace_common_blocks.prg ; common blocks used for all atmospheric chemistry and energetics (ace) software
    
;________________________________________________Model constants and Inputs_____________________________________________________________________________________________________

nbins=176
lmax=46 ;32
nmaj=3

lat=5.    ;x9 flare
lon=0.0

;
;lat=5.    ;x9 flare 60 degrees
;lon=60.0

;lat=75.    ;x9 flare  85 degrees
;lon=85.0




;lat=20.  ;m5 flare low sza
;lon=105.0

;lat=35.  ;m5 flare  60 degrees sza
;lon=40.0
;
;lat=20.  ;m5 flare   85 degrees sza
;lon=15.



;altitude bins
z0=40.
zz=findgen(161)*1.+z0  
;zz=findgen(17)*10.+z0  
;zz=findgen(400)*0.5+z0  
jmax=n_elements(zz)
dz=(zz(1:*)-zz(0:-2))
dz=[dz[0],dz]

idate=2002089 ;SQ'05
;idate =2016205  ;m5 flare
idate=2017249   ;x9 flare
;idate=2017253 ;x8 flare



;________________________________________________F10.7 and ap values _____________________________________________________________________________________________________


restore,'f107datafile.sav'
;this file was created from f107_values.pro from
;data available from
;https://lasp.colorado.edu/lisird/data/penticton_radio_flux/
; file has: month, day, year, hour, minute, second,yyyyddd,f107d,f107_81
f107_ii=where(yyyyddd eq idate,count)
if count gt 0 then begin
  f107= f107d[f107_ii[0]]
  f107a=f107_81[f107_ii[0]]
  print, f107,f107a
endif else begin
  f107=70.
  f107a=70.
  print,'F107 values not found for the given date, taking default value of (f107, f107-81day) ',f107, f107a
endelse


;OR USE YOUR OWN VALUES
;f107=70.
;f107a=70.

ap=15
;_______________________________________________________________________________________________________________________________________________________________________


tic
;_______________________________________________________________________________________________________________________________________________________________________


localpe_setup_pxsect
if fix((total(size(first_exsect))) eq 0) then begin
  localpe_setup_exsect
  ace_setup_elasticx,ener,nbins,nmaj,sigs,pe,pi
 
endif

   
    dum=min(abs(ener-20.),ia20)
    dum=min(abs(ener-100.),ia100)
    dum=min(abs(ener-1000.),ia1000)
;____________________________________________________________If you need to loop over time in a day________________________________________________________________________________
;    n_hours=14
;    glow20=fltarr(n_hours)
;    glow100=fltarr(n_hours)
;    glow1000=fltarr(n_hours)
;    ace20=fltarr(n_hours)
;    ace100=fltarr(n_hours)
;    ace1000=fltarr(n_hours)
;    asza=fltarr(n_hours)




    ;for i=0,n_hours-1 do begin
;     i=6  ;i th hour
;     hour= 5  ; m5 flare UT time
     hour =12  ; x9 flare UT time
;    hour=float(i)+6.
    utsec=3600.*hour
    
              
    localpe_neutralatm
;    asza[i]=sza

    localpe_approxeden;,zz,f107,f107a,eden,etemp,idate,lat,lon,utsec
    
;______________________________________________________________________  Solar flux__________________________________________________________________________________________

;______________________________________________________________________________________________________________________________________________________________________-



for hi=0, 5 do begin  ;solar flux loop   
     
      localpe_ssflux,hi

      localpe_photoionz
  
      localpe,idate,lat,hour,local_zz,local_ener,local_pespec,local_del;,/demo

      ace_etransport
    
;     Printing out parameters for optical depth tau=1
      
      
      
      min_tau=min(abs(reform(tau(*,hi))-1.),min_i)
      

     
      print,'Optical Depth: ' ,min_tau
      print,'Height of unit optical depth:',hi,'.',zz[min_i],'Wavelength',wv1[hi],'-',wv2[hi]
     
     
   
      print,wv1[hi],wv2[hi],eiionz_transp[0,min_i]/photoi[0,min_i],$   ;O
           eiionzk_transp[0,0,min_i]/photoi[0,min_i],$
           eiionzk_transp[1,0,min_i]/photoi[0,min_i],$
           eiionzk_transp[2,0,min_i]/photoi[0,min_i]

   
     print,wv1[hi],wv2[hi],eiionz[1,min_i]/photoi[1,min_i],$   ;O2
           total(eiionzk[0:3,1,min_i])/photoi[1,min_i],$
           total(eiionzk[4:6,1,min_i])/photoi[1,min_i]
          
     
     
      print,wv1[hi],wv2[hi],eiionz_transp[2,min_i]/photoi[2,min_i],$    ;N2
            total(eiionzk_transp[0:2,2,min_i])/photoi[2,min_i],$
            total(eiionzk_transp[3:5,2,min_i])/photoi[2,min_i],$
            total(exct_transp[4:6,2,min_i])/photoi[2,min_i] 
             
  
endfor
  toc
;____________________________________________________________________________________________________________________________________________________________________


end