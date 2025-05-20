extends Node

@onready var ingamesfx: AudioStreamPlayer = $ingamesfx

func play_music():
	ingamesfx.play()

func stop_music():
	ingamesfx.stop()
