CheckBelowShape:
//Routine that checks under each column of the shape
//We start with the left column and check up that column to see if any blocks are set on this part of the shape
//If we find a block then we check the next grid position below to see if we can move down
//We continue to do this for all four columns before moving the shape down

//These checky values will hold a number for each coloumn. If they are >0 then we will know where to check in the grid to see if we can move the shape down
checky1=0 : checky2=0 : checky3=0 : checky4=0

// Get the bottom line of the shape
string$=shape$[shape,moveshaperotation,4]

//If this cell doesn't =0 then it's empty, so set checky1 to 4 (4th cell in the column), do the same for the other 3 cells
if mid(string$,1,1)<>"0"
		checky1=4
endif
if mid(string$,2,1)<>"0"
		checky2=4
endif
if mid(string$,3,1)<>"0"
		checky3=4
endif
if mid(string$,4,1)<>"0"
		checky4=4
endif

// Get 2nd to bottom line of the shape
string$=shape$[shape,moveshaperotation,3]
if mid(string$,1,1)<>"0" and checky1=0
		checky1=3
endif
if mid(string$,2,1)<>"0" and checky2=0
		checky2=3
endif
if mid(string$,3,1)<>"0" and checky3=0
		checky3=3
endif
if mid(string$,4,1)<>"0" and checky4=0
		checky4=3
endif

// Get 3rd line to bottom line of the shape
string$=shape$[shape,moveshaperotation,2]
if mid(string$,1,1)<>"0" and checky1=0
		checky1=2
endif
if mid(string$,2,1)<>"0" and checky2=0
		checky2=2
endif
if mid(string$,3,1)<>"0" and checky3=0
		checky3=2
endif
if mid(string$,4,1)<>"0" and checky4=0
		checky4=2
endif		
// Get top line
string$=shape$[shape,moveshaperotation,1]
if mid(string$,1,1)<>"0" and checky1=0
		checky1=1
endif
if mid(string$,2,1)<>"0" and checky2=0
		checky2=1
endif
if mid(string$,3,1)<>"0" and checky3=0
		checky3=1
endif
if mid(string$,4,1)<>"0" and checky4=0
		checky4=1
endif	

// So now we will know at what points we need to check below the shape.
// If all the cells we marked are clear then we can move down, if not then this is where this shape lands

// Does this column have blocks?
if checky1<>0
	//Yes it does, so we set y1 to the x and y location of the shape + checky1
	y1=grid[moveshapex,moveshapey+checky1]
endif

//Check column 2
if checky2<>0
	y2=grid[moveshapex+1,moveshapey+checky2]
endif
//Check column 3
if checky3<>0
	y3=grid[moveshapex+2,moveshapey+checky3]
endif
//Check column 4
if checky4<>0
	y4=grid[moveshapex+3,moveshapey+checky4]
endif

//If any of the four checks do not equal 0 then we must be above a shape
if y1+y2+y3+y4<>0
	// Set the flag to change to another shape in the game
	changeshape=1
	y1=0 : y2=0: y3=0 : y4=0 
endif
	
Return

CheckLeftShape:
//Routine that checks to the left of the shape
//checkx1-4 will hold an offset per row of the shape. 0 will mean no blocks, 1-3 will mean columns 1-3 hold a block

checkx1=-2 : checkx2=-2 : checkx3=-2 : checkx4=-2

// Get the first line of the shape
string$=shape$[shape,moveshaperotation,1]

//If this cell doesn't =0 then it's empty, so set checkx1 to 1 (4th cell in the column), do the same for the other 3 cells
if mid(string$,1,1)<>"0"
		checkx1=-1
	elseif mid(string$,2,1)<>"0"
		checkx1=0
	elseif mid(string$,3,1)<>"0"
		checkx1=1
	elseif mid(string$,4,1)<>"0"
		checkx1=2
endif

// Get 2nd line
string$=shape$[shape,moveshaperotation,2]

if mid(string$,1,1)<>"0"
		checkx2=-1
	elseif mid(string$,2,1)<>"0"
		checkx2=0
	elseif mid(string$,3,1)<>"0"
		checkx2=1
	elseif mid(string$,4,1)<>"0"
		checkx2=2
endif

// Get 3rd line to bottom line of the shape
string$=shape$[shape,moveshaperotation,3]

if mid(string$,1,1)<>"0"
		checkx3=-1
	elseif mid(string$,2,1)<>"0"
		checkx3=0
	elseif mid(string$,3,1)<>"0"
		checkx3=1
	elseif mid(string$,4,1)<>"0"
		checkx3=2
endif		
// Get top line
string$=shape$[shape,moveshaperotation,4]

if mid(string$,1,1)<>"0"
		checkx4=-1
	elseif mid(string$,2,1)<>"0"
		checkx4=0
	elseif mid(string$,3,1)<>"0"
		checkx4=1
	elseif mid(string$,4,1)<>"0"
		checkx4=2
endif

// So now we will know at what points we need to check to the left of the shape.
// If all the cells we marked are clear then we can move left, if not then the shape cannot move left

// Does this column have blocks?
if checkx1<>-2
	//Yes it does, so we set x1 to the x and y location of the shape + checky1
	x1=grid[moveshapex+checkx1,moveshapey]
endif

//Check column 2
if checkx2<>-2
	x2=grid[moveshapex+checkx2,moveshapey+1]
endif
//Check column 3
if checkx3<>-2
	x3=grid[moveshapex+checkx3,moveshapey+2]
endif
//Check column 4
if checkx4<>-2
	x4=grid[moveshapex+checkx4,moveshapey+3]
endif

//If any of the four checks do not equal 0 then there must be a shape in the way
if x1+x2+x3+x4<>0
	// Set the flag to change to another shape in the game
	ok2moveleft=1
	x1=0 : x2=0: x3=0 : x4=0 
endif

Return


CheckRightShape:
//Routine that checks to the right of the shape
// checkx4-1 will hold an offset per row of the shape. 0 will mean no blocks, 1-3 will mean columns 1-3 hold a block

checkx1=-2 : checkx2=-2 : checkx3=-2 : checkx4=-2

// Get the first line of the shape
string$=shape$[shape,moveshaperotation,1]
//If this cell doesn't =0 then it's empty, so set checkx1 to 1 (4th cell in the column), do the same for the other 3 cells
if mid(string$,4,1)<>"0"
		checkx1=4
	elseif mid(string$,3,1)<>"0"
		checkx1=3
	elseif mid(string$,2,1)<>"0"
		checkx1=2
	elseif mid(string$,1,1)<>"0"
		checkx1=1
endif

// Get 2nd line
string$=shape$[shape,moveshaperotation,2]
if mid(string$,4,1)<>"0"
		checkx2=4
	elseif mid(string$,3,1)<>"0"
		checkx2=3
	elseif mid(string$,2,1)<>"0"
		checkx2=2
	elseif mid(string$,1,1)<>"0"
		checkx2=1
endif

// Get 3rd line to bottom line of the shape
string$=shape$[shape,moveshaperotation,3]
if mid(string$,4,1)<>"0"
		checkx3=4
	elseif mid(string$,3,1)<>"0"
		checkx3=3
	elseif mid(string$,2,1)<>"0"
		checkx3=2
	elseif mid(string$,1,1)<>"0"
		checkx3=1
endif		
// Get top line
string$=shape$[shape,moveshaperotation,4]
if mid(string$,4,1)<>"0"
		checkx4=4
	elseif mid(string$,3,1)<>"0"
		checkx4=3
	elseif mid(string$,2,1)<>"0"
		checkx4=2
	elseif mid(string$,1,1)<>"0"
		checkx4=1
endif

// So now we will know at what points we need to check to the left of the shape.
// If all the cells we marked are clear then we can move left, if not then the shape cannot move left

// Does this column have blocks?
if checkx1<>-2
	//Yes it does, so we set x1 to the x and y location of the shape + checky1
	x1=grid[moveshapex+checkx1,moveshapey]
endif

//Check column 2
if checkx2<>-2
	x2=grid[moveshapex+checkx2,moveshapey+1]
endif
//Check column 3
if checkx3<>-2
	x3=grid[moveshapex+checkx3,moveshapey+2]
endif
//Check column 4
if checkx4<>-2
	x4=grid[moveshapex+checkx4,moveshapey+3]
endif

//If any of the four checks do not equal 0 then there must be a shape in the way
if x1+x2+x3+x4<>0
	// Set the flag to change to another shape in the game
	ok2moveright=1
	x1=0 : x2=0: x3=0 : x4=0 
endif

Return

