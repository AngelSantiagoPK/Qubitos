class_name Projectile
extends Area2D

var speed: float = 100
var direction: Vector2

@onready var shape: Node2D = $Shape
@onready var projectile_sfx: AudioStreamPlayer2D = $ProjectileSFX
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fireball_sprite: AnimatedSprite2D = %"Fireball Sprite"

func _ready() -> void:
	direction = get_random_direction()
	update_sprite_direction()
	projectile_sfx.play()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameAudioManager.play_sound(GameAudio.EXPLOSION)
		await GameAudioManager.audio_stream_player_2d.finished
		await GlobalManager.frame_freeze()
		GlobalManager.exploded.emit()
		queue_free()

func get_random_direction() -> Vector2:
	var option: int = randi_range(0, 3)
	var dir: Vector2
	match option:
		0: dir = Vector2.LEFT
		1: dir = Vector2.RIGHT
		2: dir = Vector2.UP
		3: dir = Vector2.DOWN
	return dir

func update_sprite_direction() -> void:
	var change: float = 0
	match direction:
		Vector2.LEFT:
			change = 180
		Vector2.RIGHT:
			change = 0
		Vector2.UP:
			change = -90
		Vector2.DOWN:
			change = 90
	fireball_sprite.rotate(deg_to_rad(change))


func _on_timer_timeout() -> void:
	queue_free()
