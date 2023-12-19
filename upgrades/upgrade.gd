extends Resource
class_name Upgrade

enum OPERATOR {ADD, SUBTRACT}

@export var id : String
@export var name : String
@export var description : String
@export var operator : OPERATOR
@export var value : float
