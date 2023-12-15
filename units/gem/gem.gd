extends Area2D

@onready var movement_timer = $MovementTimer

var is_collected : bool = false

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_movement_timer_timeout():
	pass # Replace with function body.

func _on_body_entered(body):
	if body is Player:
		queue_free()
