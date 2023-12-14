extends Node

#Player Related
signal on_player_shoot(bullet : RigidBody2D, starting_pos : Vector2, direction : Vector2)
signal on_player_hurt()
signal on_hp_changed(value, max_value)

#Enemy Related
signal on_enemy_spawn(enemy : Enemy, starting_pos : Vector2)

#Game Related
signal on_wave_timer_countdown(time : float)
