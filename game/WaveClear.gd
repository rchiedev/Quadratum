extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	SignalBus.on_wave_clear.connect(on_wave_clear)

func on_wave_clear():
	self.visible = true
