extends MovementBehavior
class_name StayInPlace

var target : Player
var degree : float = 0
@export var rotate_in_place : bool = false

func init(parent : Enemy):
	super.init(parent)
	target = parent.target

func get_direction():
	return Vector2.ZERO

func get_rotation_angle():
	if rotate_in_place:
		degree += 1
		if degree >= 360:
			degree = 0
		return deg_to_rad(degree)
	else:
		return 0
