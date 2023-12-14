extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.on_wave_timer_countdown.connect(set_timer_label)

func set_timer_label(time : float):
	self.text = str(snappedf(time, 1))
