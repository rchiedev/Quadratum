extends CanvasLayer

@onready var next_wave_btn = %NextWave
@onready var gem_counter = %GemCounter

# Called when the node enters the scene tree for the first time.
func _ready():
	set_wave_counter()
	set_gems_counter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_wave_counter():
	next_wave_btn.text = "Next Wave (Wave " + str(GameManager.wave) + ")"
	
func set_gems_counter():
	gem_counter.text = str(GameManager.gems)
	
func _on_next_wave_pressed():
	SceneManager.transition_to_game(get_viewport().get_mouse_position() + Vector2(2.4, 2.4))
	#SceneManager.transition_to_game(next_wave_btn.global_position + Vector2(42.5,12.5))
	print(next_wave_btn.global_position)
