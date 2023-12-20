extends Node

@export var silver_upgrades : Array[Upgrade]
@export var gold_upgrades : Array[Upgrade]
@export var prismatic_upgrades : Array[Upgrade]
@export var enemy_list : Array[PackedScene]

var wave : int = 1
var gems : int = 10
var upgrades : Dictionary

func _ready():
	reset_game_stats()
	
func reset_game_stats():
	wave = 1
	gems = 10
	upgrades = {}

func get_enemy():
	var max_index = clamp(wave - 1, 0, enemy_list.size())
	var random_index = randi_range(0, max_index)
	return enemy_list[random_index]

func get_upgrade():
	var x = randi_range(1, 100)
	
	var silver_chance = 90
	var gold_chance = 100
	
	if wave > 5: 
		silver_chance = 80
		gold_chance = 95
		
	if wave > 10: 
		silver_chance = 70
		gold_chance = 95
		
	if wave > 15: 
		silver_chance = 50
		gold_chance = 90
		
	if wave > 20: 
		silver_chance = 30
		gold_chance = 90
	
	#silver_chance = 33
	#gold_chance = 33

	if x <= silver_chance:
		return silver_upgrades.pick_random()
	elif x <= gold_chance:
		return gold_upgrades.pick_random()
	else:
		return prismatic_upgrades.pick_random()

func apply_upgrade(upgrade_data : Upgrade):
	if upgrades.has(upgrade_data.id):
		upgrades[upgrade_data.id] += upgrade_data.value
	else:
		upgrades[upgrade_data.id] = upgrade_data.value
	print(upgrades[upgrade_data.id])
