class_name MenuPanel
extends Panel

@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var leave_button: Button = %LeaveButton

func _ready() -> void:
	play_button.mouse_entered.connect(on_hover)
	options_button.mouse_entered.connect(on_hover)
	leave_button.mouse_entered.connect(on_hover)
	play_button.focus_entered.connect(on_hover)
	options_button.focus_entered.connect(on_hover)
	leave_button.focus_entered.connect(on_hover)
	play_button.grab_focus()

func _on_play_button_button_up() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_SELECT)
	GlobalManager.play_game.emit()

func _on_options_button_button_up() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_SELECT)
	GlobalManager.options.emit()

func _on_leave_button_button_up() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_SELECT)
	GlobalManager.quit_game.emit()

func on_hover() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_HOVER)
