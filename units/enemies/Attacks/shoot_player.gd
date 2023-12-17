extends AttackingBehavior

const ENEMY_BULLET_SCENE = preload("res://units/enemies/enemy_bullet.tscn")

var target : Player

func init(parent : Enemy):
	super.init(parent)
	target = parent.target

func shoot():
	var bullet = ENEMY_BULLET_SCENE.instantiate()
	bullet.damage = _parent.damage
	
	var direction = _parent.global_position.direction_to(target.global_position)
	SignalBus.on_enemy_shoot.emit(bullet, _parent.global_position, direction)
