extends TextureButton

@onready var name_label = %Name
@onready var description = %Description
@onready var texture_rect = %TextureRect
@onready var gem_image = $GemImage
@onready var price_label = %Price

const CARD_UPGRADE_1 = preload("res://assets/Card-Upgrade1.png")
const CARD_UPGRADE_2 = preload("res://assets/Card-Upgrade2.png")
const CARD_UPGRADE_3 = preload("res://assets/Card-Upgrade3.png")

var upgrade : Upgrade
var price : int = 5

func _ready():
	SignalBus.on_gem_spent.connect(set_price_label)

func set_upgrade_data(first_shop : bool):
	upgrade = GameManager.get_upgrade(first_shop)
	name_label.text = upgrade.name
	description.text = upgrade.description
	if upgrade.rarity == 0:
		texture_rect.texture = CARD_UPGRADE_1
		price = 3 + GameManager.wave
	elif upgrade.rarity == 1:
		texture_rect.texture = CARD_UPGRADE_2
		price = 7 + GameManager.wave
	else:
		texture_rect.texture = CARD_UPGRADE_3
		price = 14 + GameManager.wave
		
	set_visibility(true)
	set_price_label()

func _on_pressed():
	GameManager.apply_upgrade(upgrade)
	GameManager.gems -= price
	
	SignalBus.on_gem_spent.emit()
	set_visibility(false)

func set_price_label():
	price_label.text = str(price)
	price_label.label_settings.font_color = Color.html("#232323")
	
	if GameManager.gems - price < 0:
		price_label.label_settings.font_color = Color.html("#d95763")
		self.disabled = true

func set_visibility(boolean):
	texture_rect.visible = boolean
	name_label.visible = boolean
	description.visible = boolean
	price_label.visible = boolean
	gem_image.visible = boolean
	self.disabled = !boolean
	
