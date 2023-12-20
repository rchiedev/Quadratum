extends Resource
class_name Upgrade

enum OPERATOR {ADD, SUBTRACT}
enum RARITY {SILVER, GOLD, PRISMATIC}

@export var id : String
@export var name : String
@export var description : String
@export var rarity : RARITY = RARITY.SILVER
@export var operator : OPERATOR = OPERATOR.ADD
@export var value : float
