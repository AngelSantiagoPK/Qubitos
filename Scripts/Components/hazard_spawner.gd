class_name HazardSpawner
extends Node2D

#Loaded Scenes
var hazard_loaded: PackedScene = preload("res://Scenes/Components/hazard.tscn")
var hazard_warning: PackedScene = preload("res://Scenes/Components/hazard_mark.tscn")
# Variables
var tile_x: int = 0
var tile_y: int = 0
var tile_size: int = 64
var spawn_offset: Vector2 = Vector2(32, 40)

var spawn_tile: Array[int] = [0,0]
var MAX_SIZE: int = 8


func _ready() -> void:
	randomize()
	spawn_hazard()
	GlobalManager.collected.connect(spawn_hazard)

func show_warning() -> void:
	new_random_position()
	var instance = hazard_warning.instantiate()
	instance.position_warning(spawn_tile[0], spawn_tile[1])
	call_deferred("add_child", instance)

func spawn_hazard() -> void:	
	new_random_position()
	var instance: Hazard = hazard_loaded.instantiate()
	var calc_x: int = spawn_tile[0] * tile_size + spawn_offset.x
	var calc_y: int = spawn_tile[1] * tile_size + spawn_offset.y
	instance.global_position = Vector2(calc_x, calc_y)
	call_deferred("add_child", instance)

func new_random_position() -> void:
	spawn_tile[0] = randi_range(0, MAX_SIZE - 1)
	spawn_tile[1] = randi_range(0, MAX_SIZE - 1)

func _on_timer_timeout() -> void:
	spawn_hazard()
