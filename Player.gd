extends Node2D

var width = 64
var height = 64

enum dir {RIGHT = 0, DOWN = 1, LEFT = 2, UP = 3}

var isShiftHeld = false

var point
var rotation_around_point = 0
var rotationState = dir.DOWN

var memes = 1
var memeAux = 0

var spriteBox
var spriteSticky
var Pivot1Sprite: Sprite2D
var Pivot2Sprite: Sprite2D
var Pivot3Sprite: Sprite2D
var Pivot4Sprite: Sprite2D

var currentTileMap: TileMap

var ccwPivot
var cwPivot

func changeStickyDirection():	
	if(rotationState == dir.RIGHT):
		ccwPivot = Pivot1Sprite
		cwPivot = Pivot2Sprite
		spriteSticky.rotation = (1*PI/2)
	
	elif(rotationState == dir.DOWN):
		ccwPivot = Pivot2Sprite
		cwPivot = Pivot3Sprite
		spriteSticky.rotation = (2*PI/2)
	
	elif(rotationState == dir.LEFT):
		ccwPivot = Pivot3Sprite
		cwPivot = Pivot4Sprite
		spriteSticky.rotation = (3*PI/2)
	
	elif(rotationState == dir.UP):
		ccwPivot = Pivot4Sprite
		cwPivot = Pivot1Sprite
		spriteSticky.rotation = (0*PI/2)
	

func rotatePlayer(direction: String, angle):
	memeAux = 16
	rotation_around_point = angle
	
	if(direction == "CCW"):
		point = ccwPivot.global_position
		memes = -1
	elif(direction == "CW"):
		point = cwPivot.global_position
		memes = 1
	else:
		print("Direção de Giro Inválida?")
	

func setPivots():
	var surroundingCells = currentTileMap.get_surrounding_cells(
		currentTileMap.getMapPosition(global_position)
	)
	var surroundingWalls = surroundingCells.map(
		func(cell): return currentTileMap.get_cell_source_id(0, cell)
	)
	var i = 0
	
	Pivot1Sprite.visible = false
	Pivot2Sprite.visible = false
	Pivot3Sprite.visible = false
	Pivot4Sprite.visible = false
	
	surroundingWalls.reduce(
		func(i, wall):
			if(i == 0 && wall == 0):
				Pivot1Sprite.visible = !Pivot1Sprite.visible
				Pivot2Sprite.visible = !Pivot2Sprite.visible
			if(i == 1 && wall == 0):
				Pivot2Sprite.visible = !Pivot2Sprite.visible
				Pivot3Sprite.visible = !Pivot3Sprite.visible
			if(i == 2 && wall == 0):
				Pivot3Sprite.visible = !Pivot3Sprite.visible
				Pivot4Sprite.visible = !Pivot4Sprite.visible
			if(i == 3 && wall == 0):
				Pivot4Sprite.visible = !Pivot4Sprite.visible
				Pivot1Sprite.visible = !Pivot1Sprite.visible
			return i+1
	, i)
	
	#print(surroundingWalls)

#func meme(event):
func _input(event):
	
	if event.is_action_pressed("shift_modifier"):
		isShiftHeld = true;
	elif event.is_action_released("shift_modifier"):
		isShiftHeld = false;
	
	
	
	if(memeAux == 0):	
		if event.is_action_pressed("ui_left"):
			if(isShiftHeld):
				rotationState = dir.LEFT
				changeStickyDirection()
			else:
				if(rotationState == dir.DOWN):
					rotatePlayer("CW", (+cwPivot.position).angle())
				elif(rotationState == dir.UP):
					rotatePlayer("CCW", (-ccwPivot.position).angle())
		elif event.is_action_pressed("ui_right"):
			if(isShiftHeld):
				rotationState = dir.RIGHT
				changeStickyDirection()
			else:
				if(rotationState == dir.DOWN):
					rotatePlayer("CCW", (-ccwPivot.position).angle())
				elif(rotationState == dir.UP):
					rotatePlayer("CW", (+cwPivot.position).angle())
		elif event.is_action_pressed("ui_up"):
			if(isShiftHeld):
				rotationState = dir.UP
				changeStickyDirection()
			else:
				if(rotationState == dir.RIGHT):
					rotatePlayer("CCW", (+ccwPivot.position).angle())
				elif(rotationState == dir.LEFT):
					rotatePlayer("CW", (-cwPivot.position).angle())
		elif event.is_action_pressed("ui_down"):
			if(isShiftHeld):
				rotationState = dir.DOWN
				changeStickyDirection()
			else:
				if(rotationState == dir.RIGHT):
					rotatePlayer("CW", (-cwPivot.position).angle())
				elif(rotationState == dir.LEFT):
					rotatePlayer("CCW", (+ccwPivot.position).angle())
	

# Called when the node enters the scene tree for the first time.
func _ready():
	spriteBox = get_node("Sprite")
	spriteSticky = get_node("Sprite2")
	
	Pivot1Sprite = get_node("Pivots/Pivot1")
	Pivot2Sprite = get_node("Pivots/Pivot2")
	Pivot3Sprite = get_node("Pivots/Pivot3")
	Pivot4Sprite = get_node("Pivots/Pivot4")
	
	currentTileMap = get_node("../TileMap")
	
	global_position = Vector2i(64*9+32, 64*7+32)
	
	rotationState = dir.DOWN
	changeStickyDirection()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if(memeAux > 0):
		rotation_around_point += (PI/2)/16 *memes
		
		memeAux -= 1
		if(memeAux == 0):
			setPivots()
			
		
		global_position = point
		global_position += Vector2(sin(rotation_around_point), 
			cos(rotation_around_point)) * sqrt(width/2*width/2+height/2*height/2)
		spriteBox.rotation -= (PI/2)/16 *memes
	



func _on_area_2d_body_entered(_body):
	print("meme")
