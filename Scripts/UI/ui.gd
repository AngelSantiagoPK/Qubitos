class_name UI
extends CanvasLayer

@onready var main_menu: Control = %MainMenu
@onready var top_bar_ui: HBoxContainer = %TopBarUI
@onready var end_screen_container: CenterContainer = %EndScreenContainer
@onready var end_screen: EndScreen = %EndScreen


func _ready() -> void:
	GlobalManager.ask_for_entry.connect(on_ask_for_entry)
	GlobalManager.accept_entry.connect(on_accept_entry)

func on_ask_for_entry() -> void:
	end_screen_container.show()
	end_screen.line_edit.grab_focus()
	
func on_accept_entry() -> void:
	end_screen_container.hide()
