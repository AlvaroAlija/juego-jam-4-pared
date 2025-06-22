extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = 400.0
@export var gravity: float = 1200.0

@export var key_left: String = "a"
@export var key_right: String = "d"
@export var key_jump: String = "space"

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var input_dir := 0
	
	if Input.is_physical_key_pressed(OS.find_keycode_from_string(key_left)):
		input_dir -= 1
	if Input.is_physical_key_pressed(OS.find_keycode_from_string(key_right)):
		input_dir += 1
	
	velocity.x = input_dir * speed

	# Gravedad y salto
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_physical_key_pressed(OS.find_keycode_from_string(key_jump)):
			velocity.y = -jump_force

	move_and_slide()

	# Flip horizontal según la dirección
	if input_dir != 0:
		sprite.flip_h = input_dir < 0

	# Animaciones
	if not is_on_floor():
		sprite.play("jump")
	elif input_dir != 0:
		sprite.play("run")
	else:
		sprite.play("idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("pincho"):
		get_tree().reload_current_scene()
		
	elif body.is_in_group("checkpointfinal"):
		get_tree().change_scene_to_file("res://level_finish.tscn")
		
		
