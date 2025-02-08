class_name LeaderboardPanel
extends Panel

@onready var leaderboard: VBoxContainer = %Leaderboard
@onready var entries: VBoxContainer = %Entries

func _ready() -> void:
	GlobalManager.load_leaderboard.connect(on_game_over)
	GlobalManager.accept_entry.connect(on_game_over)

func on_game_over() -> void:
	await show_entries()

func show_entries() -> void:
	clear_entries()
	var lb = await Leaderboards.get_scores(LeaderboardsManager.leaderboard_id, 0, 32)

	for i in lb.scores.size():
		var label = Label.new()
		var player_rank: String = str(lb.scores[i].rank)
		var player_name: String = str(lb.scores[i].name)
		var player_score: String = str(lb.scores[i].score)
		label.text = player_rank + ". " + player_name + " ~ " + player_score
		label.add_to_group("ScoreEntry")
		label.add_theme_font_size_override("font_size", 32)
		entries.call_deferred("add_child", label)

func clear_entries() -> void:
	for entry in get_tree().get_nodes_in_group("ScoreEntry"):
		entry.queue_free()
