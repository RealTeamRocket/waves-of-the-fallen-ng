extends CharacterBody2D

@export var speed = 350
@export var attack_cooldown = 1.0
@onready var sword = $Sword
@onready var timer = $AttackTimer

func _ready() -> void:
	timer.wait_time = attack_cooldown
	timer.start()
	sword.connect("body_entered",Callable(self, "_on_Sword_body_entered"))

func _physics_process(delta) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	var mouse_dir = get_global_mouse_position() - global_position
	sword.rotation = mouse_dir.angle()

func _on_Sword_body_entered(body) -> void:
	if body.name == "Mob":
		print("Sword hit: ", body.name)
		if body.has_method("take_damage"):
			body.take_damage(3)

func _on_attack_timer_timeout() -> void:
	# print("Attack at:", Time.get_ticks_msec())
	sword.monitoring = true
	await get_tree().create_timer(0.1).timeout
	sword.monitoring = false
