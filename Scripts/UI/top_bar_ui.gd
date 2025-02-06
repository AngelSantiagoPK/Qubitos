class_name TopBarUI
extends HBoxContainer

@onready var label: Label = %Label
@onready var bar: ProgressBar = %ProgressBar
@onready var score: Label = %Score
@onready var timer: Timer = %Timer

func _ready() -> void:
	GlobalManager.play_game.connect(on_update_ui)
	GlobalManager.update_ui.connect(on_update_ui)
	GlobalManager.collected.connect(add_time)

func _physics_process(_delta: float) -> void:
	on_update_ui()

func on_update_ui() -> void:
	bar.max_value = GlobalManager.time_crystal_value
	bar.value = timer.time_left
	score.text = "Score: " + str(GlobalManager.get_score())

func _on_timer_timeout() -> void:
	await GlobalManager.frame_freeze()
	GlobalManager.time_up.emit()

func add_time() -> void:
	timer.stop()
	timer.wait_time = GlobalManager.time_crystal_value
	timer.start()
