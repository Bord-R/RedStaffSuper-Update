extends Bala

#region Variables

#força do shake
@export var Shake_Force : float :
	#definindo como uma variavel do tipo setter
	set(_value): #pege o valor atribuido
		Shake_Force = _value #e adicione ele a shake force

#boleano que vereficara se eu posso tremer a tela
var isShake : bool = false

#endregion

#region Methods

#método que rodara a cada frame
func _process(_delta: float) -> void:

	if isShake: #SE eu posso tremer a tela
		Screen_shake.trigger_shake(Shake_Force) # eu tremo ela

################################################################################

#endregion

#region My Methods

func AlternHUD(): #método que alternara se eu posso estar removendo a HUD ou não
	
	Game.IsHUDRemove = !Game.IsHUDRemove #alterno o valor da permição 

################################################################################

func AlternShake(): #método que alternara o valor de is shake
	isShake = !isShake #Alterno o valor de is shake

################################################################################

#métood que rodara quando a minha animação acabar
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	
	#SE o nome da animação for igual a Start, eu me deleto
	if _anim_name == "start": queue_free()

################################################################################

#endregion