class_name PauseMenu
extends CenterContainer

# Components
@onready var pause_menu_panel: Panel = %PauseMenuPanel
@onready var continue_button: Button = %ContinueButton
@onready var restart_button: Button = %RestartButton
@onready var menu_button: Button = %MenuButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	GlobalManager.pause.connect(on_pause)
	GlobalManager.unpause.connect(on_unpause)
	
	continue_button.focus_entered.connect(on_hover)
	restart_button.focus_entered.connect(on_hover)
	menu_button.focus_entered.connect(on_hover)
	quit_button.focus_entered.connect(on_hover)
	continue_button.mouse_entered.connect(on_hover)
	restart_button.mouse_entered.connect(on_hover)
	menu_button.mouse_entered.connect(on_hover)
	quit_button.mouse_entered.connect(on_hover)

func on_pause() -> void:
	pause_menu_panel.show()
	continue_button.grab_focus()

func on_unpause() -> void:
	pause_menu_panel.hide()

func _on_continue_button_button_up() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_SELECT)
	GlobalManager.unpause.emit()

func _on_restart_button_button_up() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_SELECT)
	GlobalManager.unpause.emit()
	GlobalManager.restart_game.emit()

func _on_quit_button_button_up() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_SELECT)
	GlobalManager.quit_game.emit()

func _on_menu_button_button_up() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_SELECT)
	GlobalManager.unpause.emit()
	GlobalManager.go_to_menu.emit()

func on_hover() -> void:
	GameAudioManager.play_sound(GameAudio.MENU_HOVER)
