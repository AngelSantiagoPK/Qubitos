class_name Player
extends CharacterBody2D

var TILE: Array[int] = [0,0]
var MAX_SIZE: int = 8
var tile_size: int = 64
var player_offset: Vector2 = Vector2(32, 50)
var move_speed: int = 1
var move_time: float = 0.15
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	self.position = Vector2(0, 0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		if TILE[0] + move_speed < 0 || TILE[0] + move_speed >= MAX_SIZE:
			return	
		TILE[0] += 1
		animation_player.play("step")

	if event.is_action_pressed("ui_left"):
		if TILE[0] - move_speed < 0 || TILE[0] - move_speed > MAX_SIZE:
			return
		TILE[0] -= move_speed
		animation_player.play("step")

	if event.is_action_pressed("ui_up"):
		if TILE[1] - move_speed < 0 || TILE[1] - move_speed > MAX_SIZE:
			return
		TILE[1] -= move_speed
		animation_player.play("step")

	if event.is_action_pressed("ui_down"):
		if TILE[1] + move_speed < 0 || TILE[1] + move_speed >= MAX_SIZE:
			return
		TILE[1] += move_speed
		animation_player.play("step")

func _physics_process(_delta: float) -> void:
	var tween: Tween = create_tween()
	var x = TILE[0] * tile_size + player_offset.x
	var y = TILE[1] * tile_size + player_offset.y
	var final_pos: Vector2 = Vector2(x, y)
	tween.tween_property(self, "position", final_pos, move_time)

func play_sfx() -> void:
	GameAudioManager.play_sound(GameAudio.STEP)
