extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var texture_rect = $TextureRect
@onready var paused_menu = $PausedMenu

const GAME_SCENE = preload("res://game/game.tscn")
const GAME_OVER_SCREEN_SCENE = preload("res://game/game_over_screen.tscn")
const BUY_UPGRADE_MENU_SCENE = preload("res://game/buy_upgrade_menu.tscn")

var new_scene : PackedScene
var can_pause : bool = true

func _ready():
	texture_rect.visible = false
	paused_menu.visible = false
	can_pause = true
	
func _process(_delta):
	if Input.is_action_just_pressed("pause") and can_pause:
		paused_menu.visible = !paused_menu.visible
		get_tree().paused = paused_menu.visible

func transition_to_game(pos : Vector2 = Vector2(32, -38)):
	new_scene = GAME_SCENE
	texture_rect.texture.gradient.set_color(0, Color.html("#d3d3d3"))
	transition(pos)

func transition_to_game_over(pos : Vector2 = Vector2(32, -38)):
	texture_rect.texture.gradient.set_color(0, Color.html("#d95763"))
	new_scene = GAME_OVER_SCREEN_SCENE
	transition(pos)
	can_pause = false

func transition_to_buy_menu(pos : Vector2 = Vector2(32, -38)):
	new_scene = BUY_UPGRADE_MENU_SCENE
	texture_rect.texture.gradient.set_color(0, Color.html("#d3d3d3"))
	transition(pos)

func transition(pos : Vector2 = Vector2(32, -38)):
	self.layer = 3
	texture_rect.position.x = pos.x - 128
	texture_rect.position.y = pos.y - 128
	
	can_pause = false
	animation_player.play("transition")

func change_scene():
	self.layer = 2
	get_tree().change_scene_to_packed(new_scene)
	can_pause = true

func center_texture_rect():
	texture_rect.position.x = 32
	texture_rect.position.y = -38

func _on_resume_button_pressed():
		paused_menu.visible = false
		get_tree().paused = false
