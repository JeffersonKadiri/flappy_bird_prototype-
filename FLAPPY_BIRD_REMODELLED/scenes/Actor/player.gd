extends Area2D

signal gameover

@onready var anim_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

const JUMP_VELOCITY = -200.0
const rot_speed = 300.0

var velocity: Vector2 = Vector2.ZERO

func _ready():
	gravity = 500
	show_player(false)
	player_move(false)
	random_bird()

func _on_body_entered(body):
	gameover.emit()

func _process(delta):
	velocity.y += gravity * delta
	if rotation_degrees <= 45.0 and velocity.y > 0:
		rotation_degrees += rot_speed * delta
	else:
		if rotation_degrees >= -45.0:
			rotation_degrees -= rot_speed * delta
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
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
