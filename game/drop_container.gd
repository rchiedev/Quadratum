extends Node2D

const GEM_SCENE = preload("res://units/gem/gem.tscn")

func _ready():
	SignalBus.on_enemy_death.connect(spawn_drop)
	SignalBus.on_wave_clear.connect(clear_gems)
	SignalBus.on_player_death.connect(clear_gems)

func spawn_drop(pos : Vector2, qty : int):
	for i in qty:
		var gem = GEM_SCENE.instantiate()
		gem.global_position.x = pos.x + randf_range(0.0, 5.0)
		gem.global_position.y = pos.y + randf_range(0.0, 5.0)
		call_deferred("add_child", gem)

func clear_gems():
	var gems = get_children()
	for gem in gems:
		if !gem.is_collected:
			queue_free()
