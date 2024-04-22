extends CanvasLayer

signal player_changed_item(idx)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()

func update_ui():
	var player = get_parent().get_node("Player")
	var player_inventory = player.inventory
	for i in range(player_inventory.size()):
		var item = player_inventory[i]

		var amount_component = item.find_child("AmountComponent")
		if amount_component != null:
			var stack_label = $Background.get_child(i + 1).get_node("StackLabel")
			stack_label.text = str(amount_component.amount)
			stack_label.show()

	for i in range(player_inventory.size(), 5):
		var item_sprite = $Background.get_child(i + 1)
		item_sprite.texture = null

	var current_idx = player_inventory.find(player.current_item)
	$Background/Current.position.x = 10 + (current_idx * 55)
	if player_inventory[current_idx].find_child("AmountComponent") != null:
		$Background/Current.size.x = 30
	else:
		$Background/Current.size.x = 40

func _process(_delta):
	if Input.is_action_just_pressed("slot1"):
		player_changed_item.emit(0)
		update_ui()
	if Input.is_action_just_pressed("slot2"):
		player_changed_item.emit(1)
		update_ui()
	if Input.is_action_just_pressed("slot3"):
		player_changed_item.emit(2)
		update_ui()
	if Input.is_action_just_pressed("slot4"):
		player_changed_item.emit(3)
		update_ui()
	if Input.is_action_just_pressed("slot5"):
		player_changed_item.emit(4)
		update_ui()

func _on_item_changed(idx):
	player_changed_item.emit(idx)


func _on_player_used_item():
	print("updating UI")
	update_ui()
