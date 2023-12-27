extends Resource
class_name Effect

enum OPERATOR {ADD, SUBTRACT}

@export var id : String
@export var operator : OPERATOR = OPERATOR.ADD
@export var value : float

func apply():
	if GameManager.upgrades.has(id):
		if operator == OPERATOR.ADD:
			GameManager.upgrades[id] += value
		if operator == OPERATOR.SUBTRACT:
			GameManager.upgrades[id] -= value
		
	else:
		if operator == OPERATOR.ADD:
			GameManager.upgrades[id] = value
		if operator == OPERATOR.SUBTRACT:
			GameManager.upgrades[id] = -value
