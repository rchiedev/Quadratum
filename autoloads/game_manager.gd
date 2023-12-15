extends Node

var wave : int = 1
var gems : int = 0

func _ready():
	reset_game_stats()
	
func reset_game_stats():
	wave = 1
	gems = 0
