extends Area2D

signal gameover

@onready var anim_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var sound: AudioStreamPlayer = get_node("Sound")

const JUMP_VELOCITY = -200.0
const rot_speed = 300.0
const wing_sound = preload("res://assets/Music/wing.ogg")
const hit_sound = preload("res://assets/Music/hit.ogg")

var velocity: Vector2 = Vector2.ZERO
var screen_touch = InputEventScreenTouch.new()

func _ready():
	sound.stream = wing_sound
	gravity = 500
	show_player(false)
	player_move(false)
	random_bird()

func _on_body_entered(_body):
	sound.stream = hit_sound
	sound.play()
	anim_sprite.stop()
	gameover.emit()

func _process(delta):
	velocity.y += gravity * delta
	if rotation_degrees <= 45.0 and velocity.y > 0:
		rotation_degrees += rot_speed * delta
	else:
		if rotation_degrees >= -45.0:
			rotation_degrees -= rot_speed * delta
	if Input.is_action_just_pressed("jump") or screen_touch.is_pressed():
		velocity.y = JUMP_VELOCITY
		sound.play()
		anim_sprite.play(anim_sprite.animation)
	position += velocity * delta

func random_bird() -> void:
	var animations = anim_sprite.sprite_frames.get_animation_names()
	anim_sprite.animation = animations[randi() % animations.size()]

func show_player(value: bool) -> void:
	visible = value

func player_move(value: bool) -> void:
	set_process(value)

func ready_anim_play(value: bool) -> void:
	if value:
		anim_player.play("get_ready")
	else:
		anim_player.stop()
