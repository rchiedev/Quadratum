extends CanvasLayer

@onready var next_wave_btn = %NextWave
@onready var gem_counter = %GemCounter
@onready var refresh_button = %RefreshButton
@onready var refresh_cost_label = %RefreshCost

@export var refresh_cost : int = 1

@onready var upgrade_card = %UpgradeCard
@onready var upgrade_card2 = %UpgradeCard2
@onready var upgrade_card3 = %UpgradeCard3

@onready var bonus_list = %BonusList

@onready var audio_player = $AudioStreamPlayer
const SHOP_ENTER_SOUND = preload("res://assets/sfx/Shop_Enter.ogg")
const SHOP_EXIT_SOUND = preload("res://assets/sfx/Shop_Exit.ogg")

var first_shop : bool = true

func _ready():
	first_shop = true
	refresh_cost = 1 + floor(GameManager.wave / 2)
	
	set_wave_counter()
	set_gems_counter()
	set_refresh_label()
	set_rune_cards()
	set_bonus_list()
	
	SignalBus.on_gem_spent.connect(set_gems_counter)
	SignalBus.on_gem_spent.connect(set_refresh_label)
	SignalBus.on_upgrade_purchased.connect(set_bonus_list)
	
	audio_player.stream = SHOP_ENTER_SOUND
	audio_player.play()
	
func set_wave_counter():
	next_wave_btn.text = "Next Wave (Wave " + str(GameManager.wave) + ")"
	
func set_gems_counter():
	gem_counter.text = str(GameManager.gems)
	
func _on_next_wave_pressed():
	audio_player.stream = SHOP_EXIT_SOUND
	audio_player.play()
	SceneManager.transition_to_game(get_viewport().get_mouse_position() + Vector2(2.4, 2.4))

func _on_refresh_button_pressed():
	first_shop = false
	GameManager.gems -= refresh_cost
	
	if GameManager.gems - refresh_cost < 0:
		disable_refresh()
		
	SignalBus.on_gem_spent.emit()
	set_rune_cards()

func set_refresh_label():
	refresh_cost_label.text = str(refresh_cost)
	refresh_cost_label.label_settings.font_color = Color.html("#d3d3d3")
	if GameManager.gems - refresh_cost < 0:
		refresh_cost_label.label_settings.font_color = Color.html("#d95763")
		disable_refresh()

func disable_refresh():
	refresh_button.disabled = true

func set_rune_cards():
	upgrade_card.set_rune_data(first_shop)
	upgrade_card2.set_rune_data(first_shop)
	upgrade_card3.set_rune_data(first_shop)

func set_bonus_list():
	var labels = bonus_list.get_children()
	for n in labels:
		n.queue_free()
	
	var title_label = Label.new()
	title_label.text = "Current Bonus:"
	bonus_list.add_child(title_label)
	
	for n in GameManager.upgrades:
		var label = Label.new()
		
		label.text = n + ": " + str(GameManager.upgrades[n])
		
		label.label_settings = LabelSettings.new()
		label.label_settings.font = preload("res://assets/m5x7.ttf")
		label.label_settings.font_size = 8
		
		if GameManager.upgrades[n] < 0:
			label.label_settings.font_color = Color.html("#d95763")
		else:
			label.label_settings.font_color = Color.html("#d3d3d3")
	
		bonus_list.add_child(label)
	
