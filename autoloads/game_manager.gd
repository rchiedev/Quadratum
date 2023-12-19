extends Node

@export var upgrade_list : Array[Upgrade]

var wave : int = 1
var gems : int = 10
var upgrades : Dictionary

func _ready():
	reset_game_stats()
	
func reset_game_stats():
	wave = 1
	gems = 10
	upgrades = {}

func apply_upgrade(upgrade_data : Upgrade):
	if upgrades.has(upgrade_data.id):
		upgrades[upgrade_data.id] += upgrade_data.value
	else:
		upgrades[upgrade_data.id] = upgrade_data.value
	print(upgrades[upgrade_data.id])
