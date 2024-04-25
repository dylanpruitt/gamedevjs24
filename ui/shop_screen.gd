extends CanvasLayer

var quotes_idle = [
	"I like money.",
	"You get double money working overtime.",
]

var quotes_on_buy = [
	"Thankya thankya!",
	"I can pay 5 minutes of rent now.",
	"Ka-ching!"
]

var quotes_too_broke = [
	"This ain't a charity!",
	"Come back when you actually have the money.",
	"People like you are the reason I hate this job."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	update_money_label()

func _on_item_bought():
	print("buying")
	$BuySFX.play()
	$BrianText.text = quotes_on_buy.pick_random()
	update_money_label()

func _on_too_broke():
	$BrianText.text = quotes_too_broke.pick_random()
	$TooBrokeSFX.play()

func update_money_label():
	$MoneyLabel.text = "$%s" % GlobalVariables.player_money


func _on_continue_button_pressed():
	GlobalVariables.player_found_items.clear()
	get_tree().change_scene_to_file("res://main.tscn")


func _on_brian_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$BrianText.text = quotes_idle.pick_random()


func _on_item_tab_pressed():
	$Items.show()
	$Upgrades.hide()
	$TabContainer/ItemTab.disabled = true
	$TabContainer/UpgradeTab.disabled = false

func _on_upgrade_tab_pressed():
	$Items.hide()
	$Upgrades.show()
	$TabContainer/ItemTab.disabled = false
	$TabContainer/UpgradeTab.disabled = true
