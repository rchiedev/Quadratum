extends RigidBody2D

var SPEED : float = 50.0

var direction : Vector2

var can_damage : bool = true
var damage : float = 1.0

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = direction * SPEED
	rotation = velocity.angle()
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()

func _on_hitbox_body_entered(body):
	if body is Player and can_damage:
		if body.can_be_damaged:
			can_damage = false
			body.take_damage(damage)
			self.queue_free()
