extends RigidBody2D

const SPEED : float = 100.0

var direction : Vector2

var can_damage : bool = true

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
	if body is Enemy and can_damage:
		can_damage = false
		body.take_damage()
		self.queue_free()
