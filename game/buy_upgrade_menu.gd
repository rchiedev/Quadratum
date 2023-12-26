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

var first_shop : bool = true

func _ready():
	first_shop = true
	refresh_cost = 1 + floor(GameManager.wave / 2)
	
	set_wave_counter()
	set_gems_counter()
	set_refresh_label()
	set_upgrade_cards()
	set_bonus_list()
	
	SignalBus.on_gem_spent.connect(set_gems_counter)
	SignalBus.on_gem_spent.connect(set_refresh_label)
	SignalBus.on_upgrade_purchased.connect(set_bonus_list)
	
func set_wave_counter():
	next_wave_btn.text = "Next Wave (Wave " + str(GameManager.wave) + ")"
	
func set_gems_counter():
	gem_counter.text = str(GameManager.gems)
	
func _on_next_wave_pressed():
	SceneManager.transition_to_game(get_viewport().get_mouse_position() + Vector2(2.4, 2.4))
	#SceneManager.transition_to_game(next_wave_btn.global_position + Vector2(42.5,12.5))

func _on_refresh_button_pressed():
	first_shop = false
	GameManager.gems -= refresh_cost
	
	if GameManager.gems - refresh_cost < 0:
		disable_refresh()
		
	SignalBus.on_gem_spent.emit()
	set_upgrade_cards()

func set_refresh_label():
	refresh_cost_label.text = str(refresh_cost)
	refresh_cost_label.label_settings.font_color = Color.html("#d3d3d3")
	if GameManager.gems - refresh_cost < 0:
		refresh_cost_label.label_settings.font_color = Color.html("#d95763")
		disable_refresh()

func disable_refresh():
	refresh_button.disabled = true

func set_upgrade_cards():
	upgrade_card.set_upgrade_data(first_shop)
	upgrade_card2.set_upgrade_data(first_shop)
	upgrade_card3.set_upgrade_data(first_shop)

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
		bonus_list.add_child(label)
	
