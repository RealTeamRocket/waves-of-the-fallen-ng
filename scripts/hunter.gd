extends CharacterBody2D

@export var speed = 350
@export var attack_cooldown = 1.0
@onready var sword = $Sword
@onready var timer = $AttackTimer

func _ready():
	timer.wait_time = attack_cooldown
	timer.start()

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	var mouse_dir = get_global_mouse_position() - global_position
	sword.rotation = mouse_dir.angle()

func _on_AttackTimer_timeout():
	print("Attack!")
	sword.monitoring = true
	await get_tree().create_timer(0.2).timeout
	sword.monitoring = false

func _on_Sword_body_entered(body):
	print("Sword hit:", body.name)
	if body.has_method("take_damage"):
		body.take_damage(3)



func _on_attack_timer_timeout() -> void:
	print("Attack at:", Time.get_ticks_msec())
