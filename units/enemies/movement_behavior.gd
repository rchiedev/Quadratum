extends Node2D
class_name MovementBehavior

var _parent : Enemy

func init(parent : Enemy):
	_parent = parent

func get_direction():
	return Vector2.ZERO

func get_rotation_angle():
	return _parent.direction.angle()
