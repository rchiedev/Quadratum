extends CharacterBody2D
class_name Enemy

@onready var damaged_particle = $DamagedParticle
@onready var movement_behavior = %MovementBehavior
@onready var attacking_behavior = %AttackingBehavior


@export var max_health : float = 20.0
@export var speed : float = 25.0
@export var damage : float = 10.0

var health : float

var target : Player
var direction : Vector2

func _ready():
	health = max_health
	target = get_tree().get_first_node_in_group("player")
	movement_behavior.init(self)
	#attacking_behavior.init(self)

func _physics_process(delta):
	direction = get_direction()
	rotation = direction.angle()
	velocity = direction * speed
	move_and_slide()

func emit_particle():
	damaged_particle.restart()
	damaged_particle.emitting = true

func take_damage():
	emit_particle()
	health -= 10.0
	
	if health <= 0.0:
		queue_free()

func get_direction():
	return movement_behavior.get_direction()