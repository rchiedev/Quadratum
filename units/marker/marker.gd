extends Sprite2D

@onready var animation_player = $AnimationPlayer
const _1 = preload("res://units/enemies/1/1.tscn")

func _ready():
	rotation = deg_to_rad(randi_range(-20, 20))
	animation_player.play("spawn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy():
	var enemy = _1.instantiate()
	SignalBus.on_enemy_spawn.emit(enemy, self.global_position)
	self.queue_free()
