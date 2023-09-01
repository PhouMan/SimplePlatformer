extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DeadDrop.connect("body_entered", bodyEntered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func bodyEntered(body: Node2D) -> void:
	if body.name == "player":
		get_tree().quit()
	else:
		queue_free()
