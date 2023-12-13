extends CharacterBody2D
class_name Enemy

const speed : float = 25.0

var hp : float = 20.0
var target : CharacterBody2D
var direction : Vector2

func _ready():
	target = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	direction = self.global_position.direction_to(target.global_position)
	
	look_at(target.global_position)
	
	velocity = direction * speed
	move_and_slide()

func take_damage():
	hp -= 10.0
	
	if hp <= 0.0:
		queue_free()
	
