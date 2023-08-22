extends Node2D

var isShiftHeld = false

var point
var rotation_around_point = 0
var rotationState = 2

var memes = 1
var memeAux = 0

var spriteBox
var spriteSticky
var redPivotSprite
var	bluePivotSprite

func rotatePlayer():
	spriteSticky.rotation = (rotationState*PI/2)
	
	if(rotationState == 0):
		redPivotSprite.global_position = Vector2(global_position.x-32, global_position.y-32)
		bluePivotSprite.global_position = Vector2(global_position.x+32, global_position.y-32)
		
	elif(rotationState == 1):
		redPivotSprite.global_position = Vector2(global_position.x+32, global_position.y-32)
		bluePivotSprite.global_position = Vector2(global_position.x+32, global_position.y+32)
		
	elif(rotationState == 2):
		redPivotSprite.global_position = Vector2(global_position.x+32, global_position.y+32)
		bluePivotSprite.global_position = Vector2(global_position.x-32, global_position.y+32)
		
	elif(rotationState == 3):
		redPivotSprite.global_position = Vector2(global_position.x-32, global_position.y+32)
		bluePivotSprite.global_position = Vector2(global_position.x-32, global_position.y-32)

func setPivots():
	pass

#func meme(event):
func _input(event):
	
	if event.is_action_pressed("shift_modifier"):
		isShiftHeld = true;
	elif event.is_action_released("shift_modifier"):
		isShiftHeld = false;
	
	
	
	if event.is_action_pressed("ui_left"):
		if(isShiftHeld):
			rotationState = 3
			rotatePlayer()
		else:
			if(memeAux == 0):
				if(rotationState == 2):
					memeAux = 16
					point = bluePivotSprite.global_position
					rotation_around_point = (+bluePivotSprite.position).angle()
					memes = 1
				elif(rotationState == 0):
					memeAux = 16
					point = redPivotSprite.global_position
					rotation_around_point = (-redPivotSprite.position).angle()
					memes = -1
	elif event.is_action_pressed("ui_right"):
		if(isShiftHeld):
			rotationState = 1
			rotatePlayer()
		else:
			if(memeAux == 0):
				if(rotationState == 2):
					memeAux = 16
					point = redPivotSprite.global_position
					rotation_around_point = (-redPivotSprite.position).angle()
					memes = -1
				elif(rotationState == 0):
					memeAux = 16
					point = bluePivotSprite.global_position
					rotation_around_point = (+bluePivotSprite.position).angle()
					memes = 1
	elif event.is_action_pressed("ui_up"):
		if(isShiftHeld):
			rotationState = 0
			rotatePlayer()
		else:
			if(memeAux == 0):
				if(rotationState == 1):
					memeAux = 16
					point = redPivotSprite.global_position
					rotation_around_point = (+redPivotSprite.position).angle()
					memes = -1
				elif(rotationState == 3):
					memeAux = 16
					point = bluePivotSprite.global_position
					rotation_around_point = (-bluePivotSprite.position).angle()
					memes = 1
	elif event.is_action_pressed("ui_down"):
		if(isShiftHeld):
			rotationState = 2
			rotatePlayer()
		else:
			if(memeAux == 0):
				if(rotationState == 1):
					memeAux = 16
					point = bluePivotSprite.global_position
					rotation_around_point = (-bluePivotSprite.position).angle()
					memes = 1
				elif(rotationState == 3):
					memeAux = 16
					point = redPivotSprite.global_position
					rotation_around_point = (+redPivotSprite.position).angle()
					memes = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	spriteBox = get_node("Sprite")
	spriteSticky = get_node("Sprite2")
	
	redPivotSprite = get_node("Sprite3")
	bluePivotSprite = get_node("Sprite4")
	
	global_position = Vector2i(64*9+32, 64*7+32)
	
	rotationState = 2
	rotatePlayer()

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
