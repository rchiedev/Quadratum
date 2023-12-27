extends Resource
class_name Rune

enum RARITY {SILVER, GOLD, PRISMATIC}

@export var name : String
@export var description : String
@export var rarity : RARITY = RARITY.SILVER
@export var effects : Array[Effect]
