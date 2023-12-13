extends Node

#Player Related
signal on_player_shoot(bullet : RigidBody2D, starting_pos : Vector2, direction : Vector2)

#Enemy Related
signal on_enemy_spawn(enemy : Enemy, starting_pos : Vector2)
