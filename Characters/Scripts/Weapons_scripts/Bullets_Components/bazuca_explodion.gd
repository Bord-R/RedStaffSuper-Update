extends Bala

#métood que rodara quando a minha animação acabar
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	
	#SE o nome da animação for igual a Start, eu me deleto
	if _anim_name == "start": queue_free()
