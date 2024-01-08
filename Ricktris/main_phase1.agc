
// Project: Ricktris - Phase one, displaying the grid of blocks
// Created: 2017-02-13

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "Ricktris" )
SetWindowSize( 1024, 768, 0 )

// set display properties
SetVirtualResolution( 1024, 768 )
SetOrientationAllowed( 1, 1, 1, 1 )
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

// Variable size defines the size of the individual blocks, try changing this value
size=48
// gridx and gridy define the size of the game area 10 columns by 16 rows
#constant gridx=10
#constant gridy=16
// xoffset and yoffset set where the grid will be displayed on screen
xoffset=(getdevicewidth()-gridx*size)/2
yoffset=GetDeviceHeight()-gridy*size

//grid array will hold the data of the array
grid as integer[gridx,gridy] 

gosub load_images
gosub create_block_sprites
gosub fill_grid

do
	gosub fill_grid
	gosub update_grid
	gosub display_grid
    Sync()
loop

load_images:
// Load in each block image colour
red_image=loadimage("red.png")
orange_image=loadimage("orange.png")
pink_image=loadimage("pink.png")
black_image=loadimage("black.png")
blue_image=loadimage("blue.png")
green_image=loadimage("green.png")
purple_image=loadimage("purple.png")
Return

create_block_sprites:
count=1
for y=0 to gridy-1
	for x=0 to gridx-1
		createsprite(count,red_image)
		setspritesize(count,size,size)
//		SetSpritePosition(count,x*size+xoffset,y*size+yoffset)
		inc count
	next x
next y
Return

display_grid:
for y=1 to gridy
	text$=""
	for x=1 to gridx
	text$=text$+str(grid[x,y])+","
	next x
	print(text$)
next y
return

update_grid:
count=1
for y=0 to gridy-1
	for x=0 to gridx-1
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

fill_grid:
for x=1 to gridx
	for y=1 to gridy
		col=random(0,7)
		grid[x,y]=col
	next y
next x
return
