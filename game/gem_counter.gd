extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	set_gem_counter()
	SignalBus.on_gem_collected.connect(set_gem_counter)

func set_gem_counter():
	self.text = str(GameManager.gems)
