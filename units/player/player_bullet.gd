extends RigidBody2D

var SPEED : float = 100.0

var direction : Vector2

var damage : float = 10.0
var pierce : int = 0
var can_damage : bool = true
var bounce : int = 0
var velocity : Vector2 = Vector2.ZERO

func _ready():
	var bonus_flat_dmg = GameManager.upgrades["flat_dmg"] if GameManager.upgrades.has("flat_dmg") else 0
	var bonus_dmg = GameManager.upgrades["dmg"] if GameManager.upgrades.has("dmg") else 0
	damage = clamp((damage + bonus_flat_dmg) * (1.0 + (bonus_dmg /100.0)), 1.0, 9999.0)
	
	var bonus_speed = GameManager.upgrades["proj_speed"] if GameManager.upgrades.has("proj_speed") else 0
	SPEED = SPEED * (1.0 + (bonus_speed /100.0))
	
	bounce = GameManager.upgrades["proj_bounce"] if GameManager.upgrades.has("proj_bounce") else 0
	
	pierce = GameManager.upgrades["pierce"] if GameManager.upgrades.has("pierce") else 0
	
	velocity = direction * SPEED
	rotation = velocity.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision and bounce > 0:
		velocity = velocity.bounce(collision.get_normal())
		rotation = velocity.angle()
		bounce -= 1
	elif collision and bounce <= 0:
		self.queue_free()

func _on_hitbox_body_entered(body):
	if body is Enemy and can_damage:
		body.take_damage(damage)
		
		pierce -= 1
		if pierce < 0:
			can_damage = false
			self.queue_free()
