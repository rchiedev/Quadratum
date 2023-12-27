extends CharacterBody2D
class_name Player

@onready var attack_cooldown = $AttackCooldown
@onready var invincible_timer = $InvincibleTimer
@onready var regeneration_timer = $RegenerationTimer

@onready var damaged_particle = $DamagedParticle

@onready var audio_player = $AudioStreamPlayer
const ON_PLAYER_HIT_SOUND = preload("res://assets/sfx/onPlayerHit.ogg")
const ON_PLAYER_SHOOT_SOUND = preload("res://assets/sfx/onPlayerShoot.ogg")

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
var bullet_amt : int = 1

func _ready():
	var bonus_health = GameManager.upgrades["health"] if GameManager.upgrades.has("health") else 0
	max_health += bonus_health
	health = max_health
	
	SignalBus.on_hp_changed.emit(health, max_health)
	SignalBus.on_wave_clear.connect(disable_movement)
	
	var bonus_mspd = GameManager.upgrades["mspd"] if GameManager.upgrades.has("mspd") else 0
	mspd = clamp(mspd * (1.0 + (bonus_mspd /100.0)), 0.1, 500.0)
	
	var bonus_regen = GameManager.upgrades["regen"] if GameManager.upgrades.has("regen") else 0
	regen_value += bonus_regen
	
	bullet_amt = 1 + GameManager.upgrades["multishot"] if GameManager.upgrades.has("multishot") else 1

func _physics_process(_delta):
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
	var angle_between : float = 360.0 / float(bullet_amt)
	
	for i in bullet_amt:
		var bullet = PLAYER_BULLET_SCENE.instantiate()
		
		var main_direction = global_position.direction_to(get_global_mouse_position()).normalized()
		var final_direction = main_direction.rotated(deg_to_rad(angle_between * float(i)))
		
		bullet.rotation = final_direction.angle()
		SignalBus.on_player_shoot.emit(bullet, self.global_position, final_direction)
		can_shoot = false
	
	var bonus_aspd = GameManager.upgrades["aspd"] if GameManager.upgrades.has("aspd") else 0
	var final_atk_cd = clamp(0.5 / (1.0 + (bonus_aspd /100.0)), 0.1, 2.5)
	
	audio_player.stream = ON_PLAYER_SHOOT_SOUND
	audio_player.play()
	
	attack_cooldown.start(final_atk_cd)

func _on_attack_cooldown_timeout():
	can_shoot = true
	
func take_damage(damage : float):
	if can_be_damaged:
		change_health(-damage)
		SignalBus.on_player_hurt.emit()
		
		if health <= 0:
			on_player_death()
		
		damaged_particle.restart()
		damaged_particle.emitting = true
		
		can_be_damaged = false
		invincible_timer.start(0.75)
		audio_player.stream = ON_PLAYER_HIT_SOUND
		audio_player.play()
	
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


func _on_collection_area_area_entered(area):
	if area is Gem:
		area.is_collected = true
