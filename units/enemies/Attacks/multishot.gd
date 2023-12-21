extends AttackingBehavior
class_name Multishot

const ENEMY_BULLET_SCENE = preload("res://units/enemies/enemy_bullet.tscn")

var target : Player

@export_range(1, 12, 1) var n_of_bullets : int = 1
@export var shoot_at_player : bool = true

var angle_between : float = 0.0

func init(parent : Enemy):
	super.init(parent)
	target = parent.target
	
	angle_between = 360.0 / float(n_of_bullets)

func shoot():
	
	for n in n_of_bullets:
		var bullet = ENEMY_BULLET_SCENE.instantiate()
		bullet.damage = _parent.damage
		
		var main_direction = Vector2.UP
		if shoot_at_player:
			main_direction = _parent.global_position.direction_to(target.global_position)
			
		var final_direction = main_direction.rotated(deg_to_rad(angle_between * float(n)))
		
		var direction = final_direction
		SignalBus.on_enemy_shoot.emit(bullet, _parent.global_position, direction)
