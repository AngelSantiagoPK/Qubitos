class_name EndScreen
extends Panel

var player_name: String

@onready var label: Label = %Label
@onready var line_edit: LineEdit = %LineEdit

func on_enter_alias() -> void:
	player_name = line_edit.text
	await submit_new_score()
	GlobalManager.accept_entry.emit()

func _on_line_edit_text_submitted(_new_text: String) -> void:
	on_enter_alias()

func submit_new_score() -> void:
	await Leaderboards.post_guest_score(LeaderboardsManager.leaderboard_id, GlobalManager.score, player_name)
