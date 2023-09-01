extends CharacterBody2D
@export var isJumper := false
const gravity := 50
var ySpeed := 0
var xSpeed := 50

func _ready() -> void:
	$KillBox.connect("body_entered", bodyEntered)
	
func bodyEntered(body:Node2D) -> void:
#	if body.name == "TileMap":
#		xSpeed *= -1
#
#	if body.is_in_group("enemy") and self and isJumper == false:
#		xSpeed *= -1
#
#	elif body.name == "player":
#		if body.global_position.y < global_position.y:
#			queue_free()
#		else:
#			get_tree().quit()
			
	if body != self:
		if body.name == "player":
			if body.global_position.y < global_position.y:
				queue_free()
			else:
				get_tree().quit()
		else:
			xSpeed *= -1
	
func _physics_process(delta: float) -> void:
	if not is_on_floor(): # if we are not on the floor
		ySpeed += gravity
		
	velocity = Vector2(xSpeed, ySpeed)
	move_and_slide()
	
	if not is_on_floor():
		$EnemyAnimation.play("jump")
		
	elif xSpeed != 0:
		$EnemyAnimation.play("Walk")
		
	elif is_on_floor() and ySpeed == 0:
		$EnemyAnimation.play("default")
	
func _on_timer_timeout() -> void:
	if isJumper == true:
		ySpeed = 0
		ySpeed += -500
	
