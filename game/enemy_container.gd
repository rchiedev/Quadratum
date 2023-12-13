extends Node2D

const MARKER_SCENE = preload("res://units/marker/marker.tscn")

func _ready():
	SignalBus.on_enemy_spawn.connect(spawn_enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	var global_postion_x = randi_range(16, 304)
	var global_postion_y = randi_range(16, 164)
	
	var marker = MARKER_SCENE.instantiate()
	marker.global_position = Vector2(global_postion_x, global_postion_y)
	add_child(marker)

func spawn_enemy(enemy : Enemy, starting_pos : Vector2):
	enemy.global_position = starting_pos
	add_child(enemy)
