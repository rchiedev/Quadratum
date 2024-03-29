extends CharacterBody2D
class_name Enemy

@onready var damaged_particle = $DamagedParticle
@onready var movement_behavior = %MovementBehavior
@onready var attacking_behavior = %AttackingBehavior

@export var max_health : float = 20.0
@export_range(1.00, 1.20, 0.01) var growth_per_wave : float = 1.0
@export var speed : float = 20.0
@export var damage : float = 5.0
@export var gem_qty : int = 1

@onready var audio_player = $AudioStreamPlayer
const ON_ENEMY_HIT_SOUND = preload("res://assets/sfx/onEnemyHit.wav")

const GEM_SCENE = preload("res://units/gem/gem.tscn")

var health : float

var target : Player
var direction : Vector2
var is_dead : bool = false
var growth : float = 0.0

func _ready():
	is_dead = false
	growth = growth_per_wave
	
	if GameManager.wave > 20:
		growth = growth_per_wave + (float(GameManager.wave - 20) / 10.0)
		
	max_health = max_health * pow(growth, GameManager.wave)
	health = max_health
	damage = damage * pow(growth, GameManager.wave)
	
	var fixed_bonus_gem = floor(GameManager.wave / 10)
	gem_qty = gem_qty + fixed_bonus_gem 
	
	var bonus_gem_change = GameManager.wave % 10
	if bonus_gem_change > 0:
		if randi_range(1, 11) <= bonus_gem_change:
			gem_qty = gem_qty + 1 
	
	
	target = get_tree().get_first_node_in_group("player")
	
	movement_behavior.init(self)
	attacking_behavior.init(self)

func _physics_process(_delta):
	direction = get_direction()
	rotation = get_rotation_angle()
	velocity = direction * speed
	move_and_slide()

func emit_particle():
	damaged_particle.restart()
	damaged_particle.emitting = true

func take_damage(value : float):
	emit_particle()
	health -= value
	audio_player.stream = ON_ENEMY_HIT_SOUND
	audio_player.play()
	
	if health <= 0.0 and !is_dead:
		is_dead = true
		SignalBus.on_enemy_death.emit(self.global_position, self.gem_qty)
		queue_free()

func get_direction():
	return movement_behavior.get_direction()
	
func get_rotation_angle():
	return movement_behavior.get_rotation_angle()

func _on_attack_speed_timeout():
	attacking_behavior.shoot()
