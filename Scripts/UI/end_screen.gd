class_name EndScreen
extends Panel

@onready var label: Label = %Label
@onready var line_edit: LineEdit = %LineEdit

func on_enter_alias() -> void:
	var input: String = line_edit.text
	GlobalManager.add_entry(input)
	GlobalManager.accept_entry.emit()

func _on_line_edit_text_submitted(_new_text: String) -> void:
	on_enter_alias()
