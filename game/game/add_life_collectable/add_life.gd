extends Area2D

signal life_added

var number
var data

var collectable_access

func _init():
	collectable_access = collectable_dao.new()

func _ready():
	number = get_meta("colelctable_number")

func _on_body_entered(body):
	Kevin.add_life()
	emit_signal("life_added")
	$AnimationPlayer.play("bounce")
	set_collision_mask_value(1, false)
	await collectable_access.set_is_reached(self.data["id"], self.data["level_id"])
	

func _on_animation_player_animation_finished(anim_name):
	queue_free()


func _on_level_1_collectables_setup(collectables_data):
	self.data = collectables_data[number]
	
	if self.data["is_reached"]:
		queue_free()
