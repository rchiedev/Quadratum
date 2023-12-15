extends MovementBehavior
class_name RandomMovement

var target : Vector2 = Vector2.ZERO

func init(parent : Enemy):
	super.init(parent)

func get_direction():
	if target == Vector2.ZERO or target.distance_to(_parent.global_position) <= 10:
		target = get_new_target()
		
	return (target - _parent.global_position).normalized()

func get_new_target():
	var target_x = randi_range(16, 304)
	var target_y = randi_range(16, 164)
	
	return Vector2(target_x, target_y)
