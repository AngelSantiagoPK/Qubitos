class_name Pickup
extends Area2D

const COLLECT_PX = preload("res://Scenes/Particles/collect_px.tscn")

func on_collected() -> void:
	GameAudioManager.play_sound(GameAudio.COLLECT)
	GlobalManager.score_multiplier = 1
	GlobalManager.collected.emit()
	var instance = COLLECT_PX.instantiate()
	instance.global_position = self.global_position
	get_parent().call_deferred("add_child", instance)
	queue_free()

func on_expired() -> void:
	GlobalManager.expired.emit()
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		on_collected()
