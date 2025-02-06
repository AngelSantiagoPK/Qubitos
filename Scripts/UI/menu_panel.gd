class_name MenuPanel
extends Panel

@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var leave_button: Button = %LeaveButton

func _ready() -> void:
	play_button.mouse_entered.connect(on_hover)
	options_button.mouse_entered.connect(on_hover)
	leave_button.mouse_entered.connect(on_hover)

func _on_play_button_button_up() -> void:
	GlobalManager.play_game.emit()

func _on_options_button_button_up() -> void:
	GlobalManager.options.emit()

func _on_leave_button_button_up() -> void:
	GlobalManager.leave_game.emit()

func on_hover() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_HOVER)
