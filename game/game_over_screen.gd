extends CanvasLayer

@onready var new_game_btn = $Control/NewGame

func _on_new_game_pressed():
	GameManager.reset_game_stats()
	SceneManager.transition_to_game()
	
	SceneManager.transition_to_game(new_game_btn.position + Vector2(40,11))

