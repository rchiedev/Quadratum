extends Sprite2D
class_name Marker

@onready var animation_player = $AnimationPlayer
@onready var particle = $Particle

var enemy_scene : PackedScene

func _ready():
	emit_particle()
	rotation = deg_to_rad(randf_range(-20.0, 20.0))
	animation_player.play("spawn")
	
func emit_particle():
	particle.restart()
	particle.emitting = true

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	SignalBus.on_enemy_spawn.emit(enemy, self.global_position)
	self.queue_free()
