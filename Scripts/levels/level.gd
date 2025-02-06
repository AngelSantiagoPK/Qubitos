class_name Level
extends Node

func _ready() -> void:
	GlobalManager.pause.connect(on_pause)
	GlobalManager.unpause.connect(on_unpause)
	GlobalManager.exploded.connect(on_game_over)
	GlobalManager.time_up.connect(on_game_over)

func on_pause() -> void:
	get_tree().paused = true

func on_unpause() -> void:
	get_tree().paused = false

func on_game_over() -> void:
	GlobalManager.game_over.emit()
	self.queue_free()
