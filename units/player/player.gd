extends CharacterBody2D
class_name Player

@onready var attack_cooldown = $AttackCooldown
@onready var invincible_timer = $InvincibleTimer
@onready var regeneration_timer = $RegenerationTimer

@onready var damaged_particle = $DamagedParticle

const PLAYER_BULLET_SCENE = preload("res://units/player/player_bullet.tscn")

var direction : Vector2
var mspd : float = 75.0

var can_shoot : bool = true
var can_be_damaged : bool = true
var can_move : bool = true
var is_dead : bool = false

@export var max_health : float = 10.0
var regen_value : float = 1.0
var health : float

func _ready():
	health = max_health
	SignalBus.on_hp_changed.emit(health, max_health)
	SignalBus.on_wave_clear.connect(disable_movement)

func _physics_process(delta):
	if not is_dead and can_move:
		look_at(get_global_mouse_position())
		
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * mspd
		move_and_slide()
	
		if get_last_slide_collision():
			if get_last_slide_collision().get_collider() is Enemy and can_be_damaged:
				take_damage(get_last_slide_collision().get_collider().damage)
	
		if Input.is_action_pressed("click") and can_shoot:
			shoot()

func shoot():
	var bullet = PLAYER_BULLET_SCENE.instantiate()
	var bullet_direction = global_position.direction_to(get_global_mouse_position()).normalized()
	bullet.rotation = bullet_direction.angle()
	SignalBus.on_player_shoot.emit(bullet, self.global_position, bullet_direction)
	can_shoot = false
	attack_cooldown.start(0.5)

func _on_attack_cooldown_timeout():
	can_shoot = true
	
func take_damage(damage : float):
	change_health(-damage)
	SignalBus.on_player_hurt.emit()
	
	if health <= 0:
		on_player_death()
	
	damaged_particle.restart()
	damaged_particle.emitting = true
	
	can_be_damaged = false
	invincible_timer.start(0.75)
	
	print("Current HP: ", health)

func regenerate_health(heal_value : float):
	change_health(heal_value)

func change_health(value : float):
	health = clamp(health + value, 0.0, max_health)
	SignalBus.on_hp_changed.emit(health, max_health)

func _on_invincible_timer_timeout():
	can_be_damaged = true

func _on_regeneration_timer_timeout():
	regenerate_health(regen_value)

func on_player_death():
	is_dead = true
	regen_value = 0
	SignalBus.on_player_death.emit()
	await get_tree().create_timer(3).timeout
	SceneManager.transition_to_game_over(self.get_global_transform_with_canvas().origin)


func disable_movement():
	can_move = false
