extends HBoxContainer

var gems_initial = Storage.get_gems()
var gems_target = 0
var time: float = 0
var animation_time = 0.8

func _ready():
	reset()
	
	$CenterContainer/TextureRect.self_modulate = Themes.theme.on_background
	
	Storage.connect("storage_changed", self, "gems_changed")
	visible = false
	set_physics_process(false)

func gems_changed():
	
	if not SceneHandler.is_current(SceneHandler.SCENES.GAME):
		return reset()
	
	if Storage.get_gems() == gems_initial:
		return
	
	visible = true
	gems_target = Storage.get_gems()
	var diff = gems_target - gems_initial
	$Label.text = "+%d" % diff
	$Timer.start()


func _physics_process(delta):
	time += delta
	
	var prev = $Label.text
	$Label.text = "%d" % int(lerp(gems_initial, gems_target, time / animation_time))
	
	if $Label.text != prev and Storage.has_sound():
		var audio = AudioStreamPlayer.new()
		audio.stream = preload("res://assets/sounds/gem_ping_thud.wav")
		audio.volume_db = -10 + time / animation_time * 5
		audio.autoplay = true
		audio.connect("finished", audio, "queue_free")
		add_child(audio)
	
	if time >= animation_time:
		set_physics_process(false)
		reset()

func reset():
	gems_initial = Storage.get_gems()
	time = 0

func _show_animation():
	set_physics_process(true)
