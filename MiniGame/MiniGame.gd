extends Node

var game 
var coffee
var art

var results
var done_game
var audio_player

signal done
var r = 26/255.0
var g = 24/255.0
var b = 4/255.0
var incr = 3/255.0
var is_pouring = false

func _ready():
	done_game = false
	game = get_node("Game")
	game.connect("done",self, "showCoffeeArt")
	coffee = get_node("CupnCoffee/Coffee")
	art = get_node("CupnCoffee/LatteArt")
	audio_player = get_node("AudioStreamPlayer2D")
	art.hide()
	coffee.modulate = Color(r,g,b,1)
	game.connect("pouring", self, "changeColor")
	

func showCoffeeArt(rs):
	results = rs
	art.show()
	done_game = true
	audio_player.stop()
	
	
func gameFinished():
	print("gamefinished")
	emit_signal("done", results)
	
func changeColor():
	is_pouring = true
	r += incr
	g += incr
	b += incr
	if r < 255/255.0:
		coffee.modulate = Color(r,g,b,1)
	if !audio_player.playing:
		audio_player.play()
	coffee.value += 1

func _process(delta):
	
	if is_pouring:
		changeColor()
	pass
func _input(event):
	if event.is_action_pressed('click') && done_game:
		gameFinished()