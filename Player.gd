extends Node2D

var isShiftHeld = false

var point
var rotation_around_point = 0
var rotationState = 2

var memes = 1
var memeAux = 0

var spriteBox
var spriteSticky
var Pivot1Sprite
var Pivot2Sprite
var Pivot3Sprite
var Pivot4Sprite

var ccwPivot
var cwPivot

func changeStickyDirection():
	spriteSticky.rotation = (rotationState*PI/2)
	
	if(rotationState == 0):
		ccwPivot = Pivot1Sprite
		cwPivot = Pivot2Sprite
	
	elif(rotationState == 1):
		ccwPivot = Pivot2Sprite
		cwPivot = Pivot4Sprite
	
	elif(rotationState == 2):
		ccwPivot = Pivot4Sprite
		cwPivot = Pivot3Sprite
	
	elif(rotationState == 3):
		ccwPivot = Pivot3Sprite
		cwPivot = Pivot1Sprite
	

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
	pass

#func meme(event):
func _input(event):
	
	if event.is_action_pressed("shift_modifier"):
		isShiftHeld = true;
	elif event.is_action_released("shift_modifier"):
		isShiftHeld = false;
	
	
	
	if(memeAux == 0):	
		if event.is_action_pressed("ui_left"):
			if(isShiftHeld):
				rotationState = 3
				changeStickyDirection()
			else:
				if(rotationState == 2):
					rotatePlayer("CW", (+cwPivot.position).angle())
				elif(rotationState == 0):
					rotatePlayer("CCW", (-ccwPivot.position).angle())
		elif event.is_action_pressed("ui_right"):
			if(isShiftHeld):
				rotationState = 1
				changeStickyDirection()
			else:
				if(rotationState == 2):
					rotatePlayer("CCW", (-ccwPivot.position).angle())
				elif(rotationState == 0):
					rotatePlayer("CW", (+cwPivot.position).angle())
		elif event.is_action_pressed("ui_up"):
			if(isShiftHeld):
				rotationState = 0
				changeStickyDirection()
			else:
				if(rotationState == 1):
					rotatePlayer("CCW", (+ccwPivot.position).angle())
				elif(rotationState == 3):
					rotatePlayer("CW", (-cwPivot.position).angle())
		elif event.is_action_pressed("ui_down"):
			if(isShiftHeld):
				rotationState = 2
				changeStickyDirection()
			else:
				if(rotationState == 1):
					rotatePlayer("CW", (-cwPivot.position).angle())
				elif(rotationState == 3):
					rotatePlayer("CCW", (+ccwPivot.position).angle())
	

# Called when the node enters the scene tree for the first time.
func _ready():
	spriteBox = get_node("Sprite")
	spriteSticky = get_node("Sprite2")
	
	Pivot1Sprite = get_node("Pivots/Pivot1")
	Pivot2Sprite = get_node("Pivots/Pivot2")
	Pivot3Sprite = get_node("Pivots/Pivot3")
	Pivot4Sprite = get_node("Pivots/Pivot4")
	
	global_position = Vector2i(64*9+32, 64*7+32)
	
	rotationState = 2
	changeStickyDirection()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if(memeAux > 0):
		rotation_around_point += (PI/2)/16 *memes
		memeAux -= 1
		
#		if(rotation_around_point == 2*PI):
#			rotation_around_point=0
		
		global_position = point
		global_position += Vector2(sin(rotation_around_point), 
			cos(rotation_around_point)) * sqrt(32*32+32*32)
		spriteBox.rotation -= (PI/2)/16 *memes
	



func _on_area_2d_body_entered(_body):
	print("meme")
