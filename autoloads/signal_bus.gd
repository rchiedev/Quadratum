extends Node

#Player Related
signal on_player_shoot(bullet : RigidBody2D, starting_pos : Vector2, direction : Vector2)
signal on_player_hurt()
signal on_hp_changed(value, max_value)
signal on_player_death()
signal on_gem_collected()

#Enemy Related
signal on_enemy_spawn(enemy : Enemy, starting_pos : Vector2)
signal on_enemy_shoot(bullet : RigidBody2D, starting_pos : Vector2, direction : Vector2)
signal on_enemy_death(pos : Vector2, qty : int)

#Game Related
signal on_wave_timer_countdown(time : float)
signal on_wave_clear()
