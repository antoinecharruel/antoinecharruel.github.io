// Move the shape down the grid
move_moveshape:
//Clear the current shape from the grid
	if shapeclear=1
		// Only clear cells that have a filled item
		for i=1 to 4
			string$=shape$[shapestore,storerotation,i]
			cell=val(mid(string$,1,1))
			if cell<>0
				grid[Storex,Storey+i-1]=0
			Endif
			cell=val(mid(string$,2,1))
			if cell<>0
				grid[Storex+1,Storey+i-1]=0
			endif
			cell=val(mid(string$,3,1))
			if cell<>0
				grid[Storex+2,Storey+i-1]=0
			endif
			cell=val(mid(string$,4,1))
			if cell<>0
				grid[Storex+3,Storey+i-1]=0
			endif		
		next i
		shapeclear=0
	endif


	// Draw the shape in the new position (only the filled items)
	for i=1 to 4
		string$=shape$[shape,moveshaperotation,i]

		cell=val(mid(string$,1,1))
		if cell<>0
			if grid[moveshapex,moveshapey+i-1]=0
				grid[moveshapex,moveshapey+i-1]=cell
			else
				nospace=1
			endif
		endif
		cell=val(mid(string$,2,1))
		if cell<>0
			if grid[moveshapex+1,moveshapey+i-1]=0
				grid[moveshapex+1,moveshapey+i-1]=cell
			else
				nospace=1
			endif
		endif
		cell=val(mid(string$,3,1))
		if cell<>0
			if grid[moveshapex+2,moveshapey+i-1]=0
				grid[moveshapex+2,moveshapey+i-1]=cell
			else
				nospace=1
			endif
		endif
		cell=val(mid(string$,4,1))
		if cell<>0
			if grid[moveshapex+3,moveshapey+i-1]=0
				grid[moveshapex+3,moveshapey+i-1]=cell
			else
				nospace=1
			endif
		endif
	next i
	shapeclear=1 : Storex=moveshapex : Storey=moveshapey : storerotation=moveshaperotation : shapestore=shape
Return
