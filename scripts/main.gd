extends Node2D

@export var enemy_scene = preload("res://scenes/mob.tscn")
@export var spawn_distance = 1
@export var spawn_time = 10
@onready var player = $Player
@onready var spawn_timer = $SpawnTimer

func _ready() -> void:
	spawn_timer.start()
	spawn_timer.wait_time = spawn_time
	spawn_timer.connect("timeout",Callable(self,"_on_SpawnTimer_timeout"))

func _on_SpawnTimer_timeout():
	print("Spawned Enemy")
	var enemy = enemy_scene.instantiate()
	var center = player.global_position
	enemy.global_position = center
	add_child(enemy)
