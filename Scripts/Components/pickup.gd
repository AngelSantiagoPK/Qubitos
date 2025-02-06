class_name Pickup
extends Area2D

func on_collected() -> void:
	GameAudioManager.play_sound(GameAudio.COLLECT)
	GlobalManager.score_multiplier = 1
	GlobalManager.collected.emit()
	queue_free()

func on_expired() -> void:
	GlobalManager.expired.emit()
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		on_collected()
