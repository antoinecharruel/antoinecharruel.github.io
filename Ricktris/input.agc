
keychecks:
	//This routine checks keyboard inputs
	//Has left arrow been pressed? 37 is a scancode for left arrow, see the help for a full list
	if GetRawKeyPressed(37) and moveshapex<>1
		//Yes pressed so check if there's room to move left and if so decrease the shapes x position by 1
		ok2moveleft=0
		gosub CheckLeftShape
		if ok2moveleft=0
			dec moveshapex
			changeshape=0
		endif
	endif
	
	//Has right arrow been pressed? If so move right
	if GetRawKeyPressed(39) 
		ok2moveright=0
		gosub CheckRightShape
		if ok2moveright=0
			inc moveshapex
			changeshape=0
		endif
	endif
	
	//Has SPACE been pressed? If so rotate the shape
	if GetRawKeyPressed(32)
		Gosub GetShapeGrid
		tempstore=moveshaperotation
		inc moveshaperotation
		 if moveshaperotation=5
			moveshaperotation=1
		 endif
		
		// Can we rotate where we are?
 		z=CanShapeRotate(moveshaperotation,0)

		if z=0
 				playsound(2)
			//No we cannot rotate. See if we are on the left, if we move in one place can we rotate?
			if moveshapex=2
				z2=CanShapeRotate(moveshaperotation,1)
				if z2=1
					inc moveshapex
					changeshape=0
				else
					moveshaperotation=tempstore
				endif
			endif
			// Final check, are we on the right side?
			if moveshapex=>10
				z3=CanShapeRotate(moveshaperotation,-1)
				if z3=1
					dec moveshapex
	
				else
					dec moveshapex
					gosub GetShapeGrid
					z3=CanShapeRotate(moveshaperotation,-1)
					if z3=1
						dec moveshapex
					else
						dec moveshapex
						gosub GetShapeGrid
						z3=CanShapeRotate(moveshaperotation,-1)
						if z3=1
						changeshape=0
						else

							moveshaperotation=tempstore
						endif
					endif
				endif
			endif		
		endif
	endif


	
	//Has down arrow been pressed? If so move the shape down.
	if GetRawKeyPressed(40)
		if changeshape=0
			repeat
				inc moveshapey
				gosub CheckBelowShape
			until changeshape<>0
			movecount=moveshapespeed
//****************************************************
			grace=0
		endif
	endif
Return
