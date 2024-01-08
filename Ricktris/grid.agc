// Show a debug text of what's in the array grid
display_grid:
for y=1 to gridy
	text$=""
	for x=1 to gridx
		text$=text$+str(grid[x,y])+","
	next x
	print(text$)
next y
return

// Run through the grid array and display the correct blocks 
update_grid:
count=1
for y=0 to gridy-2
	for x=1 to gridx-2
			SetSpriteVisible(count,1)
			if grid[x+1,y+1]=0
				SetSpriteVisible(count,0)
			elseif grid[x+1,y+1]=1
				image=red_image
			elseif grid[x+1,y+1]=2
				image=orange_image
			elseif grid[x+1,y+1]=3
				image=pink_image
			elseif grid[x+1,y+1]=4
				image=black_image
			elseif grid[x+1,y+1]=5
				image=blue_image
			elseif grid[x+1,y+1]=6
				image=green_image
			elseif grid[x+1,y+1]=7
				image=purple_image
			endif
		setspriteimage(count,image)
		SetSpritePosition(count,x*size+xoffset,y*size+yoffset)
		inc count
	next x
next y
Return

// Clear the grid totally
clear_grid:
for x=1 to gridx
	for y=1 to gridy
		grid[x,y]=0
	next y
next x
for i=1 to gridx 
	grid[i,gridy-1]=1
next i

for i=1 to gridy
	grid[2,i]=1
	grid[13,i]=1
next i

return

// Create a grid sized 6x6 from around the current shape
// and remove the current shape from this array.
// We can then check this small grid to see if the current shape can 
// be rotated or moved and rotated

GetShapeGrid:
for y=0 to 3
	for x=0 to 3
		a=grid[moveshapex+x,moveshapey+y]
		string$=shape$[shape,moveshaperotation,y+1]
		if val(mid(string$,x+1,1))<>0
			grid6x6[x+1,y+1]=0
		else
			grid6x6[x+1,y+1]=a
		endif
	next x
next y

for y=1 to 6
	a$=""
	for x=1 to 6
		a=grid6x6[x,y]
		a$=a$+str(a)
	next x
//	print (a$)
next y
return

print_grid:
a$=""
	for y=1 to 6
		for x=1 to 6
			a$=a$+str(grid6x6[x,y])
		next x
		print(a$)
		a$=""
	next y
return

// Check to see if a rotated version of the shape is allowed in the grid
// We'll use a function
// Takes two inputs
// - rotation 1,2,3 or 4
// - offset = how many cells to check either side of current shape x an y
function CanShapeRotate(rotation,offset)
	result=1
	for y=0 to 3
		rotation$=shape$[shape,rotation,y+1]
		for x=0 to 3
			a=val(mid(rotation$,x+1,1))
			if a<>0
				b=grid6x6[x+1+offset,y+1]
				if b<>0
					result=0
				endif
			endif
		next x
	next y

//Exit with either 0 or 1 (0=no, cannot fit, 1=yes, allowed)
Endfunction(result)
