extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var texture_rect = $TextureRect

const GAME_SCENE = preload("res://game/game.tscn")
const GAME_OVER_SCREEN_SCENE = preload("res://game/game_over_screen.tscn")

var new_scene : PackedScene

func _ready():
	texture_rect.visible = false

func transition_to_game(pos : Vector2 = Vector2(32, -38)):
	self.layer = 3
	new_scene = GAME_SCENE
	texture_rect.texture.gradient.set_color(0, Color.html("#d3d3d3"))
	
	texture_rect.position.x = pos.x - 128
	texture_rect.position.y = pos.y - 128
	
	animation_player.play("transition")

func transition_to_game_over(pos : Vector2 = Vector2(32, -38)):
	self.layer = 3
	new_scene = GAME_OVER_SCREEN_SCENE
	texture_rect.texture.gradient.set_color(0, Color.html("#d95763"))
	
	texture_rect.position.x = pos.x - 128
	texture_rect.position.y = pos.y - 128
	
	animation_player.play("transition")

func change_scene():
	self.layer = 2
	get_tree().change_scene_to_packed(new_scene)

func center_texture_rect():
	texture_rect.position.x = 32
	texture_rect.position.y = -38
	
