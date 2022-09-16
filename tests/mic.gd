extends Control


var effect: AudioEffectRecord
var recording
var mic_list

@onready var play_button: Button = $PlayButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var option_button: OptionButton = $OptionButton

func _ready() -> void:
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx, 0)
	
	print(AudioServer.capture_device)
	print("-----")
	mic_list = AudioServer.capture_get_device_list()
	for i in range(len(mic_list)):
		option_button.add_item(mic_list[i], i)


func _on_record_button_pressed() -> void:
	if effect.is_recording_active():
		recording = effect.get_recording()
		effect.set_recording_active(false)
		play_button.disabled = false
	else:
		effect.set_recording_active(true)
		play_button.disabled = true


func _on_play_button_pressed() -> void:
	print(recording)
	print(recording.format)
	print(recording.mix_rate)
	var data = recording.get_data()
	print(data)
	print(data.size())
	audio_stream_player.stream = recording
	audio_stream_player.play()


func _on_option_button_item_selected(index: int) -> void:
	print(mic_list)
	print(AudioServer.capture_get_device_list())
	AudioServer.capture_device = mic_list[index]
	print(AudioServer.capture_device)
	print("---")
