extends MovementBehavior
class_name FollowPlayer

var target : Player

func init(parent : Enemy):
	super.init(parent)
	target = parent.target

func get_direction():
	return _parent.global_position.direction_to(target.global_position)
