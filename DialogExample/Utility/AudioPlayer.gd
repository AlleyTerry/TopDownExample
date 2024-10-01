extends AudioStreamPlayer

const bedroom_scene = preload("res://Assets/Sound/sound_track.mp3")
const level_one_scene = preload("res://Assets/Sound/Level 1 GREY V1-1.mp3")
const level_two_scene = preload("res://Assets/Sound/Level 2 RED V1-1.mp3")
const level_three_scene = preload("res://Assets/Sound/Level 3 YELLOW V1-1.mp3")
const level_four_scene = preload("res://Assets/Sound/Level 4 BLUE V1-1.mp3")
const level_five_scene = preload("res://Assets/Sound/Level 5 GREEN V1-1.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	process_mode = Node.PROCESS_MODE_ALWAYS
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_bedroom_scene():
	_play_music(bedroom_scene, -20)

func play_level_one_scene():
	_play_music(level_one_scene, -20)

func play_level_two_scene():
	_play_music(level_two_scene, -20)

func play_level_three_scene():
	_play_music(level_three_scene, -20)
	
func play_level_four_scene():
	_play_music(level_four_scene, -20)
	
func play_level_five_scene():
	_play_music(level_five_scene, -20)
