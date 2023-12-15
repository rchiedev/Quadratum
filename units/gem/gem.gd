extends Area2D
class_name Gem

@onready var movement_timer = $MovementTimer

var is_collected : bool = false
var speed : float = 75.0
var direction : Vector2

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_collected:
		direction = global_position.direction_to(get_tree().get_first_node_in_group("player").global_position)
		global_position.x += direction.x * speed * delta
		global_position.y += direction.y * speed * delta

func _on_movement_timer_timeout():
	pass # Replace with function body.

func _on_body_entered(body):
	if body is Player:
		GameManager.gems += 1
		SignalBus.on_gem_collected.emit()
		queue_free()
