class_name Game
extends Node2D

var level: PackedScene = preload("res://Scenes/Levels/Level_01.tscn")
@onready var ui: UI = %UI

func _ready() -> void:
	GlobalManager.get_online_leaderboard()
	GlobalManager.load_leaderboard.emit()
	GlobalManager.play_game.connect(on_play)
	GlobalManager.game_over.connect(on_end_play)
	GlobalManager.accept_entry.connect(on_entry_accepted)

func on_play() -> void:
	ui.top_bar_ui.add_time()
	GlobalManager.reset_game()
	var instance: Level= level.instantiate()
	self.call_deferred("add_child", instance)
	ui.main_menu.hide()
	ui.top_bar_ui.show()

func on_end_play() -> void:
	ui.top_bar_ui.hide()
	GlobalManager.ask_for_entry.emit()

func on_entry_accepted() -> void:
	ui.main_menu.show()
	GlobalManager.reset_game()
	ui.top_bar_ui.add_time()
