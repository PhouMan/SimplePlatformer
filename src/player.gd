extends CharacterBody2D

const gravity := 50
const jump_force := -500
const speed := 200
const max_jump_count := 2
var ySpeed := 0
var jumpCount := 0

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		#$playerAnimation.play("run")

	#if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		#$playerAnimation.play("default")
	
func _physics_process(delta: float) -> void:
	var xSpeed:= speed
	
	if is_on_ceiling():
		ySpeed = gravity
	
	if not is_on_floor(): # if we are not on the floor
		ySpeed += gravity
	
	else: #if on the floor
		ySpeed = 0
		jumpCount = 0
	
	if Input.is_action_just_pressed("ui_up") and jumpCount < max_jump_count:
		ySpeed = jump_force
		jumpCount += 1
		
		
	xSpeed = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	xSpeed *= speed
	
	if not is_on_floor():
		$playerAnimation.play("jump")
	elif xSpeed < 0:
		$playerAnimation.flip_h = true
		$playerAnimation.play("run")
	elif xSpeed > 0:
		$playerAnimation.play("run")
		$playerAnimation.flip_h = false
	elif is_on_floor() and ySpeed == 0:
		$playerAnimation.play("default")
	
	velocity = Vector2(xSpeed, ySpeed)
	move_and_slide()
	
