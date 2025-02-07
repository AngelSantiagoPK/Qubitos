class_name Game
extends Node2D

var level: PackedScene = preload("res://Scenes/Levels/Level_01.tscn")
@onready var ui: UI = %UI

func _ready() -> void:
	GlobalManager.load_leaderboard.emit()
	GlobalManager.play_game.connect(on_play)
	GlobalManager.restart_game.connect(on_restart)
	GlobalManager.quit_game.connect(on_quit)
	GlobalManager.go_to_menu.connect(on_go_to_menu)
	GlobalManager.game_over.connect(on_end_play)
	GlobalManager.accept_entry.connect(on_entry_accepted)

func on_play() -> void:
	ui.top_bar_ui.add_time()
	GlobalManager.reset_game()
	add_gameplay_instance()
	ui.main_menu.hide()
	ui.top_bar_ui.show()

func on_restart() -> void:
	remove_gameplay_instance()
	add_gameplay_instance()
	GlobalManager.reset_game()
	ui.top_bar_ui.add_time()

func on_go_to_menu() -> void:
	remove_gameplay_instance()
	ui.top_bar_ui.hide()
	ui.main_menu.show()
	GlobalManager.reset_game()
	ui.top_bar_ui.add_time()
	ui.main_menu.grab_focus()

func on_end_play() -> void:
	remove_gameplay_instance()
	ui.top_bar_ui.hide()
	GlobalManager.ask_for_entry.emit()

func on_entry_accepted() -> void:
	ui.main_menu.show()
	GlobalManager.reset_game()
	ui.top_bar_ui.add_time()

func on_quit() -> void:
	get_tree().call_deferred("quit")

func add_gameplay_instance() -> void:
	var instance: Level= level.instantiate()
	self.call_deferred("add_child", instance)

func remove_gameplay_instance() -> void:
	var lvl: Level = get_tree().get_first_node_in_group("Level")
	if lvl != null:
		lvl.queue_free()
