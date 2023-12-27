extends CanvasLayer

@onready var new_game_btn = $Control/NewGame

func _ready():
	$AudioStreamPlayer.play()

func _on_new_game_pressed():
	GameManager.reset_game_stats()
	SceneManager.transition_to_game()
	
	SceneManager.transition_to_game(get_viewport().get_mouse_position() + Vector2(2.4, 2.4))
	#SceneManager.transition_to_game(new_game_btn.global_position + Vector2(40,11))

