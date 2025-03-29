extends Node2D

@export var enemy_scene = preload("res://scenes/mob.tscn")
@export var spawn_distance = 10
@export var spawn_time = 5
@onready var player = $Player
@onready var spawn_timer = $SpawnTimer

func _ready() -> void:
	spawn_timer.wait_time = spawn_time
	spawn_timer.start()
	spawn_timer.connect("timeout",Callable(self,"_on_SpawnTimer_timeout"))

func _on_SpawnTimer_timeout():
	print("Spawned Mob")
	var new_mob = enemy_scene.instantiate()
	var center = player.global_position

	var side = randi() % 4
	var offset = Vector2.ZERO

	match side:
		0: offset = Vector2(randf_range(-1, 1), -1)
		1: offset = Vector2(randf_range(-1, 1), 1)
		2: offset = Vector2(-1, randf_range(-1, 1))
		3: offset = Vector2(1, randf_range(-1, 1))

	offset = offset.normalized() * spawn_distance
	new_mob.global_position = center + offset

	await get_tree().process_frame
	add_child(new_mob)
	
