class_name UI
extends CanvasLayer

@onready var pause_menu_panel: Panel = %PauseMenuPanel
@onready var continue_button: Button = %ContinueButton
@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton
@onready var main_menu: Control = %MainMenu
@onready var top_bar_ui: HBoxContainer = %TopBarUI
@onready var end_screen_container: CenterContainer = %EndScreenContainer
@onready var end_screen: EndScreen = %EndScreen


func _ready() -> void:
	GlobalManager.pause.connect(on_pause)
	GlobalManager.unpause.connect(on_unpause)
	GlobalManager.ask_for_entry.connect(on_ask_for_entry)
	GlobalManager.accept_entry.connect(on_accept_entry)

func on_pause() -> void:
	pause_menu_panel.show()
	continue_button.grab_focus()

func on_unpause() -> void:
	pause_menu_panel.hide()
	
func on_ask_for_entry() -> void:
	end_screen_container.show()
	end_screen.line_edit.grab_focus()
	
func on_accept_entry() -> void:
	end_screen_container.hide()

func _on_continue_button_button_up() -> void:
	GlobalManager.unpause.emit()

func _on_restart_button_button_up() -> void:
	GlobalManager.reset.emit()

func _on_quit_button_button_up() -> void:
	queue_free()
