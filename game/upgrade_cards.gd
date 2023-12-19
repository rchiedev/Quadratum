extends TextureButton

@onready var name_label = %Name
@onready var description = %Description
@onready var texture_rect = $TextureRect

var data : Upgrade

func _ready():
	self.disabled = false
	self.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_upgrade_data():
	data = GameManager.upgrade_list.pick_random()
	name_label.text = data.name
	description.text = data.description
	
	texture_rect.visible = true
	name_label.visible = true
	description.visible = true
	self.disabled = false

func _on_pressed():
	GameManager.apply_upgrade(data)
	self.disabled = true
	texture_rect.visible = false
	name_label.visible = false
	description.visible = false
