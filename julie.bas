
main:
	' Init
	low C.0
	low C.4
	let w1 = time
	goto listen
	
listen: ' Main loop
	
	' Read buton state
	if pinC.3 = 1 then gosub music
	
	' Check for light level every second
	if w1 <> time and time < 120 then
		readadc C.1, b0
		
		' If light level is low, flash the led
		if b0 < 150 then 
			if w1 < time then
				let w1 = time + 1
				high C.0 
				pause 250
				low C.0
			endif	
		endif
	endif
	
	' Check if in sleep mode
	if time < 120 then goto listen
	
	
	gosub zzz
	goto listen
		
music:
	' Reset timer .
	w1 = 0
	time = 0
	
	' Play spooky music
	high C.4
	tune 0, 4,($29,$C0,$29,$C0,$29,$00,$29,$27,$25,$0C,$29,$C0,$29,$C0,$29,$E5)
	low C.4
	
	return
	
zzz:
	disablebod
	sleep 2
	enablebod
	
	return