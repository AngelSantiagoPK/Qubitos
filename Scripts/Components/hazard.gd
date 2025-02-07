class_name Hazard
extends Area2D

var projectile_loaded: PackedScene = preload("res://Scenes/Components/projectile.tscn")
var hazard_mark: PackedScene = preload("res://Scenes/Components/hazard_mark.tscn")
var points_loaded: PackedScene = preload("res://Scenes/Components/points.tscn")

const HAZARD_MARK = preload("res://Scenes/Components/hazard_mark.tscn")
@onready var shape: Node2D = $Shape
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var audio_player: AudioStreamPlayer2D = %AudioPlayer
const SPAWN: AudioStream = preload("res://Assets/Sounds/Spawn.wav")
const WIND_UP: AudioStream = preload("res://Assets/Sounds/WindUp.wav")
const PROJECTILE_LAUNCH: AudioStream = preload("res://Assets/Sounds/ProjectileLaunch.wav")
const KILL_PX = preload("res://Scenes/Particles/kill_px.tscn")

func _ready() -> void:
	audio_player.stream = SPAWN
	audio_player.play()
	await animation_player.animation_finished
	animation_player.play('idle')

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		show_points()
		GlobalManager.disarmed.emit()
		var instance = KILL_PX.instantiate()
		instance.global_position = self.global_position
		get_parent().call_deferred("add_child", instance)
		queue_free()

func _on_timer_timeout() -> void:
	show_warning()
	await get_tree().create_timer(1.0).timeout
	spawn_projectile()

func spawn_projectile() -> void:
	var instance: Projectile = projectile_loaded.instantiate()
	instance.global_position = self.global_position
	get_parent().call_deferred("add_child", instance)
	audio_player.stream = PROJECTILE_LAUNCH
	audio_player.play()

func show_warning() -> void:
	var instance = hazard_mark.instantiate()
	instance.global_position = self.global_position
	get_parent().call_deferred("add_child", instance)
	audio_player.stream = WIND_UP
	audio_player.play()
	

func show_points()-> void:
	var instance = points_loaded.instantiate()
	instance.global_position = self.global_position
	instance.display_points(100 * GlobalManager.score_multiplier)
	get_tree().current_scene.call_deferred("add_child", instance)
	GlobalManager.score_multiplier += 1

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pickup") || area.is_in_group("Hazard"):
		GlobalManager.disarmed.emit()
		queue_free()
