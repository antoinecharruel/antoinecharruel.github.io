
// Project: Ricktris
// Created: 2017-02-13
// Free Music track "Psychedelic" by BenSound! http://www.bensound.com
// Sound effects from https://freesound.org
// Start Text logo made via https://cooltext.com

// Added since last version;
// - Grace period before a shape is settled - DONE
// - Title page, start & end of game - DONE
// - Add scoring DONE!
// - Add some sound & music - DONE!
// - Check for end of game - DONE!

SetPrintSize(26)
// set window properties
SetWindowTitle( "Ricktris" )
SetWindowSize( 1024, 768, 0 )

// set display properties
SetVirtualResolution( 1024, 768 )
SetOrientationAllowed( 1, 1, 1, 1 )
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

#include "loader.agc"
#include "grid.agc"
#include "shapes.agc"
#include "shape_checks.agc"
#include "input.agc"
#include "lines.agc"
#include "move_blocks.agc"

// Variable size defines the size of the individual blocks, try changing this value
size=48

// gridx and gridy define the size of the game area 10 columns by 16 rows
// I have added 2 more columns in the x for left and right borders
#constant gridx=14
#constant gridy=16
// xoffset and yoffset set where the grid will be displayed on screen
xoffset=(getdevicewidth()-gridx*size)/2
yoffset=GetDeviceHeight()-gridy*size

//grid array will hold the data of the array
global grid as integer[gridx,gridy] 

global grid6x6 as integer[6,6]

//Shape array, 7 shapes each with 4 4x4 grids 
global shape$ as string[7,4,4]

//An array for storing the status of each line
lines as integer[gridy]

//This is where the shape starts in the grid
global moveshapex=4
global moveshapey=1

//Choose a random shape
global shape as integer
shape=random(1,7)


//Set the score
score=0
bonus=0
//*******************************************
hiscore=0
gameover=0
nospace=0

//*******************************************
//Grace counter - used to wait for block to settle
grace=0

// The rotation version of the shape
global moveshaperotation=1

//Controls the speed of the shape moving down
moveshapespeed=15
movecount=moveshapespeed

//A flag used to remove the shape from the grid
shapeclear=0

//Flags for checking left and right movement
ok2moveleft=0
ok2moveright=0

//A flag to indicate when a new shape is needed
changeshape=0

//Setup the shapes 
gosub setup_shapes 
gosub load_images
gosub create_block_sprites
//*******************************************
gosub Load_titles
//Clear the grid 
gosub clear_grid 

//Create the text
Gosub Create_Text
resettimer()
//***********************************************
//                  MAIN LOOP
//***********************************************

//*******************************************
 PlayMusicOGG(1)
 
 //*******************************************
 mode=1
 do

//*******************************************
 Select mode
	 
	case 1
		// Wait on title page until mouse click to start the game
		if GetPointerPressed()
			//OK, game is starting, change Switch case mode
			mode=2
			// Hide titles
			SetSpriteVisible(logo_image,0)
			SetSpriteVisible(start_image,0)
			
			//Reset all the blocks
			gosub Reset_Blocks
			gosub create_block_sprites
			gosub clear_grid
			
			//Reset key variable
			gameover=0
			score=0		
			nospace=0			
		endif
	sync()
	endcase
	
	
	case 2
		//The game has started!
		
		//Check if it's OK to move the shape down or if it's blocked
		gosub CheckBelowShape
			
		//Has player pressed any keys?
		gosub keychecks

		//If the counter has been reached, move the shape down
		dec movecount
		if movecount=0
			inc moveshapey
			movecount=moveshapespeed
			grace=10
		endif

		//Move the shape
		gosub move_moveshape

		//Draw all the sprites in the grid
		gosub update_grid
		
		//****************************************************
		//If the block is at the base, leave it there and make a new one
		if changeshape=1 and grace=0
			//Check to see if any lines in the grid are solid and need removing
			gosub removelines
			score=score+(bonus*100)
			if hiscore<score
				hiscore=score
			endif
			moveshapex=4
			moveshapey=1
			moveshaperotation=random(1,4)
			shapeclear=0
			changeshape=0 
			shape=random(1,7)
		endif
		
			if timer()=500
				resettimer()
				dec moveshapespeed
				if moveshapespeed<10
					moveshapespeed=10
				endif
			endif
	//****************************************************
		if grace>0
			dec grace
			movecount=moveshapespeed
		endif
		
	//No more space at the top, game over!
		if nospace=1
			gameover=1
			mode=1
			gosub Game_Over
			SetSpriteVisible(logo_image,1)
			SetSpriteVisible(start_image,1)	
		endif
		SetTextString(2,str(score))
		SetTextString(4,str(hiscore))
		
		Sync()


	endcase
endselect

loop

//****************************************************
//Makes all blocks have Physics so they float off at end of the game
Game_Over:
SetPhysicsWallBottom(0)
SetPhysicsWallLeft(0)
SetPhysicsWallRight(0)
SetPhysicsWallTop(0)
SetPhysicsScale(1)
SetPhysicsGravity(0 , .2)
count=1
for y=1 to gridy
	for x=1 to gridx
		setspritesize(count,size,size)
		SetSpritePhysicsOn(count,2)
		SetSpritePhysicsVelocity(count,random(-500,500),random(-500,-500))
		SetSpriteShape(count,2)
		SetSpriteColorAlpha(count,50)
		inc count
	next x
	sync()

next y
Return

//****************************************************
// Reset the blocks after physics has been added to them
Reset_Blocks:
count=1
for y=1 to gridy
	for x=1 to gridx
		DeleteSprite(count)
		inc count
	next x
	sync()
next y
Return
