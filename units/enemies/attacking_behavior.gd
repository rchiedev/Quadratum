extends Node2D
class_name AttackingBehavior

var _parent : Enemy
const ON_ENEMY_SHOOT_SOUND = preload("res://assets/sfx/onEnemyShoot.ogg")

func init(parent : Enemy):
	_parent = parent

func _physics_process(_delta):
	pass

func shoot():
	pass
