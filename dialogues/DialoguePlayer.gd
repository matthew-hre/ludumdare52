extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_id = 0
var is_dialogue_active = false

var option1 = false;
var option2 = false;
var option3 = false;

func _ready():
	$NinePatchRect.visible = false
	$Option1.visible = false
	$Option2.visible = false
	$Option3.visible = false
	
func play():
	if is_dialogue_active:
		return

	if (option1):
		$NinePatchRect/Message.text = dialogues[0]["option1Picked"]
		$NinePatchRect.visible = true
		return
	elif (option2):
		$NinePatchRect/Message.text = dialogues[0]["option2Picked"]
		$NinePatchRect.visible = true
		return
	elif (option3):
		$NinePatchRect/Message.text = dialogues[0]["option3Picked"]
		$NinePatchRect.visible = true
		return
	
	
	dialogues = load_dialogue()
	
	turn_off_the_player()
	is_dialogue_active = true
	$NinePatchRect.visible = true
	current_dialogue_id = -1
	next_line()
	
func _input(event):
	if not is_dialogue_active:
		return
	
	if event.is_action_pressed("game_usage"):
		next_line()
		
func next_line():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogues):
		$Timer.start()
		$NinePatchRect.visible = false
		$Option1.visible = false
		turn_on_the_player()
		return
		
	var pfpTexture = load(dialogues[current_dialogue_id]["pfp"]);

	# if there is a option1, 2, or 3 in the dialogue
	if "option1" in dialogues[current_dialogue_id]:
		$Option1/Text.text = dialogues[current_dialogue_id]["option1"]
		$Option1.visible = true
	else:
		$Option1.visible = false

	if "option2" in dialogues[current_dialogue_id]:
		$Option2/Text.text = dialogues[current_dialogue_id]["option2"]
		$Option2.visible = true
	else:
		$Option2.visible = false

	if "option3" in dialogues[current_dialogue_id]:
		$Option3/Text.text = dialogues[current_dialogue_id]["option3"]
		$Option3.visible = true
	else:
		$Option3.visible = false

	# if option1, 2, or 3 is selected
	if option1:
		$NinePatchRect/Message.text = dialogues[current_dialogue_id]["option1Response"]
	elif option2:
		$NinePatchRect/Message.text = dialogues[current_dialogue_id]["option2Response"]
	elif option3:
		$NinePatchRect/Message.text = dialogues[current_dialogue_id]["option3Response"]
	else:
		$NinePatchRect/Message.text = dialogues[current_dialogue_id]["text"]
	
	$NinePatchRect/pfp.set_texture(pfpTexture)
	$NinePatchRect/Name.text = dialogues[current_dialogue_id]["name"]	
	
	
func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func _on_Timer_timeout():
	is_dialogue_active = false
	
func turn_on_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)

func turn_off_the_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		next_line()


func _on_Area2D_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		next_line()



func _on_Option3_gui_input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print("Option 3")
		option3 = true
		next_line()

func _on_Option2_gui_input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print("Option 2")
		option2 = true
		next_line()

func _on_Option1_gui_input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print("Option 1")
		option1 = true
		next_line()
