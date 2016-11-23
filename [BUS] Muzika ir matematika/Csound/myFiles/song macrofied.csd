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
#define volume #0.8#
#define param0 #220#
#define param1 #220#
#define param2 #250#

#define string(freq)#
	kcps = $param0 ;kcps = 220
	icps = $param1 ; icps = 220
	ifn  = 0
	imeth = p4
	asig pluck $volume, $freq, $param2, ifn, imeth, .1, 10
     	outs asig, asig
     	#
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
	$string(155)
endin

instr 46
	$string(207)
endin

instr 33
	$string(234)
endin
instr 35
	$string(263)
endin
instr 24
	$string(310)
endin
instr 26
	$string(348.5)
endin
instr 13
	$string(390.5)
endin

;D cord strings
instr 40
	$string(146.8)
endin
instr 32
	$string(221.5)
endin
instr 23
	$string(293)
endin
instr 12
	$string(368)
endin
</CsInstruments>
<CsScore>
#define timesToPlay # 5# 		;first two columns =10,  fullsong =26
#define delay # 0.24#			;original 0.24
#define notePlayTime #0.5#	;
#define chordStrumTimePerString #0.025#
#define chordPlayTime(stringOrder#stringTotal) # [$notePlayTime*2 + [$chordStrumTimePerString *[$stringTotal - $stringOrder +1]] ]# 	;equalize each note play time in a chord


i2 0 1
;Main Riff
{ $timesToPlay
	;first part
	i46 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i13 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i26 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i13 ^+[$delay]  [$notePlayTime] 1
	i26 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	;second part
	i56 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i13 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i26 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i13 ^+[$delay]  [$notePlayTime] 1
	i26 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
}
;the end
	;first part complete
	i46 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i13 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i26 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i13 ^+[$delay]  [$notePlayTime] 1
	i26 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i35 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	;second part incomplete
	i56 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i13 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i33 ^+[$delay]  [$notePlayTime] 1
	i24 ^+[$delay]  [$notePlayTime] 1
	i26 ^+[$delay]  [$notePlayTime] 1
;chord at the end
;i46 ^+[$chordStrumTimePerString] [$chordPlayTime(1'4)] 1
i35 ^+[$chordStrumTimePerString] [$chordPlayTime(2'4)] 1
i24 ^+[$chordStrumTimePerString] [$chordPlayTime(3'4)] 1
i13 ^+[$chordStrumTimePerString] [$chordPlayTime(4'4)] 1
/* D chord
i40 ^+[$chordStrumTimePerString] [$chordPlayTime(1'4)] 1
i32 ^+[$chordStrumTimePerString] [$chordPlayTime(2'4)] 1
i23 ^+[$chordStrumTimePerString] [$chordPlayTime(3'4)] 1
i12 ^+[$chordStrumTimePerString] [$chordPlayTime(4'4)] 1
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
