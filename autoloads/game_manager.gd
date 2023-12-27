extends Node

@export var silver_runes : Array[Rune]
@export var gold_runes : Array[Rune]
@export var prismatic_runes : Array[Rune]
@export var enemy_list : Array[PackedScene]

var wave : int = 1
var gems : int = 10
var upgrades : Dictionary

func _ready():
	reset_game_stats()
	
func reset_game_stats():
	wave = 1
	gems = 1000
	upgrades = {
	
	}

func get_enemy():
	
	if wave == 13:
		return get_enemy_scene(0, 2, 4, 5)
	elif wave == 12:
		return get_enemy_scene(2, 2, 3, 3)
	elif wave == 11:
		return get_enemy_scene(1, 2, 3, 4)
	elif wave == 10:
		return get_enemy_scene(1, 2, 3, 3)
	elif wave == 9:
		return get_enemy_scene(1, 1, 3, 4)
	elif wave == 8:
		return get_enemy_scene(0, 1, 3, 3)
	elif wave == 7:
		return get_enemy_scene(0, 1)
	elif wave == 6:
		return get_enemy_scene(0, 2, 3, 4)
	elif wave == 5:
		return get_enemy_scene(0, 2, 4, 4)
	elif wave == 4:
		return get_enemy_scene(0, 2, 3, 3)
	elif wave < 4:
		return get_enemy_scene(0, wave - 1)
	else:
		return enemy_list.pick_random()

func get_enemy_scene(min_melee_index : int = 0, max_melee_index : int = 0, min_ranged_index : int = 0, max_ranged_index : int = 0):
	var enemy_scene : PackedScene
	if max_melee_index == 0 and max_ranged_index == 0:
		enemy_scene = enemy_list[0]
	elif max_ranged_index == 0:
		enemy_scene = enemy_list[randi_range(min_melee_index, max_melee_index)]
	elif max_melee_index == 0:
		enemy_scene = enemy_list[randi_range(min_ranged_index, max_ranged_index)]
	else:
		var is_ranged = randi_range(1, 10)
		if is_ranged <= 7:
			enemy_scene = enemy_list[randi_range(min_melee_index, max_melee_index)]
		else:
			enemy_scene = enemy_list[randi_range(min_ranged_index, max_ranged_index)]
	
	return enemy_scene
		

func get_rune(first_shop : bool):
	var x = randi_range(1, 100)
	
	var silver_chance = 90
	var gold_chance = 100
	
	if wave > 4: 
		silver_chance = 80
		gold_chance = 95
		
	if wave > 8: 
		silver_chance = 70
		gold_chance = 95
		
	if wave > 12: 
		silver_chance = 50
		gold_chance = 90
		
	if wave > 16: 
		silver_chance = 30
		gold_chance = 90
	
	if wave % 5 == 0 and first_shop:
		return prismatic_runes.pick_random()
	if x <= silver_chance:
		return silver_runes.pick_random()
	elif x <= gold_chance:
		return gold_runes.pick_random()
	else:
		return prismatic_runes.pick_random()

func apply_rune(rune_data : Rune):
	for effect in rune_data.effects:
		effect.apply()
