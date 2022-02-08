pro localpe_approxeden;,zz,f107,f107a,eden,etemp,idate,lat,lon,utsec

@ace_common_blocks.prg ; common blocks used for all atmospheric chemistry and energetics (ace) software
                       ; see this file for definitions


;;
;; this procedure estimates and electron density profile by doing
;; a simple scaling between hi and lo f107 profiles (from iri by web)
;
common localpe_approxden,ziri,ehi,elo,tehi,telo,f10hi,f10lo,localpe_approxden_readonce,$
ei_hi,ei_lo,tei_hi,tei_lo

if (total(size(localpe_approxden_readonce)) lt 1.0) then begin

openr,lun,'localpe_approxeden.dat',/get_lun
s='a string'
readf,lun,s
readf,lun,s

nz=500-60+1
ziri=fltarr(nz)
ehi=ziri
elo=ziri
tehi=ziri
telo=ziri

for i=0,nz-1 do begin
  readf,lun,a,b,c,f10lo
  ziri[i]=a
  elo[i]=b
  telo[i]=c
  endfor
  
  for i=0,nz-1 do begin
  readf,lun,a,b,c,f10hi
  ehi[i]=b
  tehi[i]=c
  endfor

free_lun,lun

ehi=ehi>0.
elo=elo>0.
tehi=tehi>0.
telo=telo>0.

; interpolate to input grid and put in units of cm^-3
ei_hi=interpol(ehi,ziri,zz)/1e6
ei_lo=interpol(elo,ziri,zz)/1e6
tei_hi=interpol(tehi,ziri,zz)
tei_lo=interpol(telo,ziri,zz)
   
localpe_approxden_readonce=1
endif ; readonce

nout=n_elements(zz)
eden=fltarr(nout)
etemp=fltarr(nout)

for i=0,nout-1 do begin

eslope=(ei_hi[i]-ei_lo[i])/(f10hi-f10lo)
eden[i]=ei_lo[i] + eslope*(f107-f10lo)
teslope=(tei_hi[i]-tei_lo[i])/(f10hi-f10lo)
etemp[i]=tei_lo[i] + teslope*(f107-f10lo)

endfor


end
