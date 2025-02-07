class_name Global
extends Node

#Pickups Signal
signal collected
signal expired

#Hazard Signal
signal exploded
signal dissolved
signal disarmed

#Pause Menu Signals
signal play_game
signal options
signal leave_game
signal pause
signal unpause


#Game Signal
signal update_ui
signal time_up
signal reset
signal game_over

# Leaderboard Signal
signal load_leaderboard
signal ask_for_entry
signal accept_entry

var time_crystal_value: float = 7.0
var score_multiplier: int = 1
var score: int = 0
var lives: int = 1

func _ready() -> void:
	#TODO: initialize online database connection to leaderboards
	pass

func get_score() -> int:
	return score

func set_score(score: int) -> void:
	self.score = score

func add_score(add: int) -> void:
	self.score += add

func get_lives() -> int:
	return lives

func set_lives(lives: int) -> void:
	self.lives = lives

func remove_life() -> void:
	self.lives -= 1

func frame_freeze() -> void:
	Engine.time_scale = 0.25
	await get_tree().create_timer(0.2).timeout
	Engine.time_scale = 1.0

func reset_game() -> void:
	score_multiplier = 1
	score = 0
	lives = 1
