extends TextureProgressBar

@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.on_hp_changed.connect(set_hp_bar)
	SignalBus.on_player_hurt.connect(shake_bar)

func set_hp_bar(health, max_health):
	self.value = health
	self.max_value = max_health

func shake_bar():
	animation_player.play("shake")
