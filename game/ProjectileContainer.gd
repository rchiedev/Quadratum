extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.on_player_shoot.connect(spawn_bullet)
	SignalBus.on_enemy_shoot.connect(spawn_bullet)
	SignalBus.on_wave_clear.connect(clear_bullets)

func spawn_bullet(bullet : RigidBody2D, starting_pos : Vector2, direction : Vector2):
	bullet.global_position = starting_pos
	bullet.direction = direction
	self.add_child(bullet)

func clear_bullets():
	var bullets = get_children()
	for bullet in bullets:
		queue_free()
	
