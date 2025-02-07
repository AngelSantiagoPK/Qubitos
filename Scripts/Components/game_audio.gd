class_name GameAudio
extends Node

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
# Player Sounds
const STEP: AudioStream = preload("res://Assets/Sounds/Step_01.wav")
const COLLECT: AudioStream = preload("res://Assets/Sounds/Collect.wav")
const EXPLOSION: AudioStream = preload("res://Assets/Sounds/explosion.wav")
const BLIP: AudioStream = preload("res://Assets/Sounds/Blip.wav")

# Menu Sounds
const MENU_HOVER: AudioStream = preload("res://Assets/Sounds/MenuHover.wav")
const MENU_SELECT = preload("res://Assets/Sounds/MenuSelect.wav")

func play_sound(sound: AudioStream):
	if not audio_stream_player_2d.finished:
		return
	
	if sound == null:
		return
	
	#audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.0)
	audio_stream_player_2d.stream = sound
	audio_stream_player_2d.play()
