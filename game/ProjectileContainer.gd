extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.on_player_shoot.connect(spawn_player_bullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_player_bullet(bullet : RigidBody2D, starting_pos : Vector2, direction : Vector2):
	bullet.global_position = starting_pos
	bullet.direction = direction
	self.add_child(bullet)
