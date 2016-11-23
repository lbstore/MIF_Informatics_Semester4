;Laimonas Beniušis MIF informatika 2 kursas 1 grupe
;Syd Matters - Obstacles
<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs  = 1
instr 1
	prints "delay%n"
endin
instr 2
	prints "%n -------------------------------------------- %n%tSyd Matters - Obstacles %n -------------------------------------------- %n"
endin
instr 3
	prints "%n -------------------------------------------- %n%tEnd of performance%n -------------------------------------------- %n%tArranged By Laimonas Beniusis%n -------------------------------------------- %n"
endin
;instr [string][tab]
;instr [styga][skirsnis]
;Main Riff notes

instr 56

	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 155, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin

instr 46
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 207, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin

instr 33
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 234, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin
instr 35
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 263, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin
instr 24
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 310, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin
instr 26
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 348.5, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin
instr 13
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 390.5, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin

;D cord strings
instr 40
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 146.8, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin
instr 32
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 221.5, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin
instr 23
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 293, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin
instr 12
	kcps = 220 ;kcps = 220
	icps = 220 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck 0.8, 368, 250, ifn, imeth, .1, 10
     	outs asig, asig
endin
</CsInstruments>
<CsScore>

i2 0 1
;Main Riff
{ 4
	;first part
	i46 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i13 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i26 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i13 ^+[0.24]  [0.5] 1
	i26 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	;second part
	i56 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i13 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i26 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i13 ^+[0.24]  [0.5] 1
	i26 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
}
;the end
	;first part complete
	i46 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i13 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i26 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i13 ^+[0.24]  [0.5] 1
	i26 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i35 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	;second part incomplete
	i56 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i13 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i33 ^+[0.24]  [0.5] 1
	i24 ^+[0.24]  [0.5] 1
	i26 ^+[0.24]  [0.5] 1
;chord at the end
;i46 ^+[0.025] [1+0.025*1] 1
i35 ^+[0.025] [1+0.025*1] 1
i24 ^+[0.025] [1+0.025*2] 1
i13 ^+[0.025] [1+0.025*3] 1
/* D chord
i40 ^+[0.025] [0.5(1'4)] 1
i32 ^+[0.025] [0.5(2'4)] 1
i23 ^+[0.025] [0.5(3'4)] 1
i12 ^+[0.025] [0.5(4'4)] 1
*/
i3 ^+1 1
e 							; e - end
</CsScore>
</CsoundSynthesizer>

<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
