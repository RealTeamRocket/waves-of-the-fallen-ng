extends CharacterBody2D

@export var health = 10
@export var speed = 225
@onready var player = get_node("/root/main/Player") # passe ggf. Pfad an

func _physics_process(delta):
	var dir = global_position.direction_to(player.global_position)
	velocity = dir * speed
	move_and_slide()

func take_damage(amount):
	print("Enemy took", amount, "damage")
	health -= amount
	if health <= 0:
		print("Enemy dead")
		queue_free()
