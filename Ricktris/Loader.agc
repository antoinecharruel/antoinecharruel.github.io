load_images:
// Load in each block image colour
backdrop_image=loadimage("game_backdrop.png")
logo_image=loadimage("ricktris.png")
start_image=loadimage("startgame.png")
red_image=loadimage("red.png")
orange_image=loadimage("orange.png")
pink_image=loadimage("pink.png")
black_image=loadimage("black.png")
blue_image=loadimage("blue.png")
green_image=loadimage("green.png")
purple_image=loadimage("purple.png")

//*******************************************
//Also load the sounds
LoadSound(1,"wood.wav")
LoadSound(2,"line.wav")
LoadMusicOGG(1,"bensound-psychedelic.ogg")
Return

//Generate sprites for every block location
create_block_sprites:
count=1
for y=1 to gridy
	for x=1 to gridx
		createsprite(count,red_image)
		setspritesize(count,size,size)
		SetSpritePosition(count,-500,-500)
		inc count
	next x
next y
Return

//*******************************************
Load_titles:
//Load the backdrop
backsprite=CreateSprite(backdrop_image)
SetSpritePosition(backsprite,0,0)
SetSpriteDepth(backsprite,200)

//Load the title and start game button
logosprite=CreateSprite(logo_image)
SetSpritePosition(logosprite,(getdevicewidth()-GetSpriteWidth(logosprite))/4,200)
SetSpriteScale(logosprite,1.5,1.5)
SetSpriteDepth(logosprite,199)

logosprite=CreateSprite(start_image)
SetSpritePosition(start_image,(getdevicewidth()-GetSpriteWidth(start_image))/2,450)
SetSpriteDepth(start_image,198)
Return

Create_Text:
CreateText(1,"Score: ")
SetTextPosition(1,10,0)
SetTextSize(1,50)
CreateText(2,str(score))
SetTextPosition(2,10,60)
SetTextSize(2,50)
CreateText(3,"Hi-Score: ")
SetTextPosition(3,820,0)
SetTextSize(3,50)
CreateText(4,str(hiscore))
SetTextPosition(4,820,60)
SetTextSize(4,50)

Return
