extends Node2D

@onready var enemy_timer = %EnemyTimer
@onready var wave_timer = %WaveTimer

const MARKER_SCENE = preload("res://units/marker/marker.tscn")

func _ready():
	SignalBus.on_enemy_spawn.connect(spawn_enemy)
	SignalBus.on_player_death.connect(stop_wave)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	SignalBus.on_wave_timer_countdown.emit(wave_timer.time_left)

func spawn_enemy(enemy : Enemy, starting_pos : Vector2):
	enemy.global_position.x = starting_pos.x + randf_range(0.0, 10.0)
	enemy.global_position.y = starting_pos.y + randf_range(0.0, 10.0)
	add_child(enemy)

func _on_enemy_timer_timeout():
	var global_position_x = randi_range(16, 304)
	var global_position_y = randi_range(16, 164)
	
	var marker = MARKER_SCENE.instantiate()
	marker.global_position = Vector2(global_position_x, global_position_y)
	marker.enemy_scene = GameManager.get_enemy()
	add_child(marker)

func _on_wave_timer_timeout():
	SignalBus.on_wave_clear.emit()
	clear_wave()

func clear_wave():
	stop_wave()
	GameManager.wave += 1
	await get_tree().create_timer(3).timeout
	SceneManager.transition_to_buy_menu(get_tree().get_first_node_in_group("player").get_global_transform_with_canvas().origin)

func stop_wave():
	enemy_timer.stop()
	wave_timer.stop()
	for marker in get_children().filter(func(node): return node is Marker):
		marker.queue_free()
	for enemy in get_children().filter(func(node): return node is Enemy):
		enemy.queue_free()
