extends CharacterBody2D

@export var health = 10
@export var speed = 225
@onready var player = get_node("/root/main/Player")

func _physics_process(delta) -> void:
	var dir = global_position.direction_to(player.global_position)
	velocity = dir * speed
	move_and_slide()

func take_damage(amount) -> void:
	print("Enemy took ", amount, " damage")
	health -= amount
	if health <= 0:
		print("Enemy dead")
		queue_free()
