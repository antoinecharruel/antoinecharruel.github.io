//Find a line that is complete and ready to be removed
//Shift all the lines above that line down so they cover the line
//Re-check the lines, any more to shift
//Repeat until done.

Removelines:
bonus=0
gosub check4lines
yline=gridy-2
Repeat
	// Is this line full?
	if lines[yline]=0
		//Yes, OK shift all above it down one line and cover this line
			for movey=yline to 1 step -1
				for xline=3 to gridx-2
					grid[xline,movey]=grid[xline,movey-1]
				next xline
			next movey
		// Increase bonus count
			playsound(2)
			if bonus=0
				inc bonus
			else
				bonus=bonus*2
			endif
			gosub check4lines
			yline=gridy-2
	else
		dec yline
		playsound(1)
	endif
until yline=1
return

// Check the grid for any lines of solid blocks
check4lines:
for y=1 to 15
	line=0

// Check across this line, if any cells are zero then this line is not complete

	for x=3 to gridx-2
		if grid[x,y]=0
			line=1
			exit
		endif
	next x
	//If lines[y]=0 then the line is marked for removal
	lines[y]=line
next y
Return





