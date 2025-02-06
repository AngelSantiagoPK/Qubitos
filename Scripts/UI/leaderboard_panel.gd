class_name LeaderboardPanel
extends Panel

@onready var leaderboard: VBoxContainer = %Leaderboard
@onready var entries: VBoxContainer = %Entries

func _ready() -> void:
	
	GlobalManager.accept_entry.connect(on_game_over)
	GlobalManager.load_leaderboard.connect(show_entries)

func on_game_over() -> void:
	show_entries()

func show_entries() -> void:
	clear_entries()
	await GlobalManager.get_online_leaderboard()
	
	for i in GlobalManager.LEADERBOARD.size():
		var label = Label.new()
		var player_name: String = str(GlobalManager.LEADERBOARD.scores[i].player_name) + " - " + str(GlobalManager.LEADERBOARD.scores[i].score)
		label.text = player_name
		label.add_to_group("ScoreEntry")
		label.add_theme_font_size_override("font_size", 10)
		entries.call_deferred("add_child", label)

func clear_entries() -> void:
	for entry in get_tree().get_nodes_in_group("ScoreEntry"):
		entry.queue_free()
