extends CharacterBody2D
class_name Enemy

@onready var damaged_particle = $DamagedParticle
@onready var movement_behavior = %MovementBehavior
@onready var attacking_behavior = %AttackingBehavior

@export var max_health : float = 20.0
@export var growth_per_wave : float = 2.5
@export var speed : float = 20.0
@export var damage : float = 10.0
@export var gem_qty : int = 1

const GEM_SCENE = preload("res://units/gem/gem.tscn")

var health : float

var target : Player
var direction : Vector2

func _ready():
	max_health = max_health + (GameManager.wave * growth_per_wave)
	health = max_health
	damage = damage + GameManager.wave
	
	target = get_tree().get_first_node_in_group("player")
	movement_behavior.init(self)
	attacking_behavior.init(self)

func _physics_process(_delta):
	direction = get_direction()
	rotation = direction.angle()
	velocity = direction * speed
	move_and_slide()

func emit_particle():
	damaged_particle.restart()
	damaged_particle.emitting = true

func take_damage(value : float):
	emit_particle()
	health -= value
	
	if health <= 0.0:
		SignalBus.on_enemy_death.emit(self.global_position, self.gem_qty)
		queue_free()

func get_direction():
	return movement_behavior.get_direction()

func _on_attack_speed_timeout():
	attacking_behavior.shoot()
