extends AttackingBehavior
class_name SplitShot

const ENEMY_BULLET_SCENE = preload("res://units/enemies/enemy_bullet.tscn")

var target : Player

var angle_between : float = 20.0

func init(parent : Enemy):
	super.init(parent)
	target = parent.target

func shoot():
	for n in [-1, 1]:
		var bullet = ENEMY_BULLET_SCENE.instantiate()
		bullet.damage = _parent.damage
		
		var main_direction = _parent.global_position.direction_to(target.global_position)
		var final_direction = main_direction.rotated(deg_to_rad(angle_between * n))
		
		var direction = final_direction
		SignalBus.on_enemy_shoot.emit(bullet, _parent.global_position, direction)
	
