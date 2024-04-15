extends CanvasLayer

func update_health(health):
	$HealthBar.value = health
	$HealthDetailLabel.text = "%s/100" % health

func update_power(power):
	$PowerBar.value = power
	$PowerDetailLabel.text = "%s/1000" % power
