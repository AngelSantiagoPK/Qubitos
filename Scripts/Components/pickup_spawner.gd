class_name PickupSpawner
extends Node2D

var pickup_loaded: PackedScene = preload("res://Scenes/Components/pickup.tscn")
var spawn_tile: Array[int] = [0,0]
var MAX_SIZE: int = 8
var tile_size: int = 64
var spawn_offset: Vector2 = Vector2(32, 50)

func _ready() -> void:
	randomize()
	spawn_pickup()
	GlobalManager.collected.connect(spawn_pickup)
	GlobalManager.expired.connect(spawn_pickup)

func spawn_pickup() -> void:	
	new_random_position()
	var instance: Pickup = pickup_loaded.instantiate()
	var calc_x: int = spawn_tile[0] * tile_size + spawn_offset.x
	var calc_y: int = spawn_tile[1] * tile_size + spawn_offset.y
	instance.global_position = Vector2(calc_x, calc_y)
	call_deferred("add_child", instance)

func new_random_position() -> void:
	spawn_tile[0] = randi_range(0, MAX_SIZE - 1)
	spawn_tile[1] = randi_range(0, MAX_SIZE - 1)
