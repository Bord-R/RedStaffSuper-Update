extends Sprite2D

#criando classe para ser usado como node
class_name DashEffect

#region Variables

@onready var EffectLight : PointLight2D = null #meu efeito de luz

#cor da luz
var Light_Color : Color = Color.WHITE

#endregion

#region Methods

#método que rodara quando eu for instanciado
func _init(_my_pos : Vector2, _my_sca : Vector2, _my_tex : Texture2D, _my_light : PointLight2D, _color_light : Color, _energy : float) -> void:
	
	#definindo minha posição
	position = _my_pos
	
	#definindo minha escala
	scale = _my_sca
	
	#definindo minha textura
	texture  = _my_tex

	#defino meu efeito de luz
	EffectLight = _my_light

	#defino a cor da luz
	Light_Color =  _color_light

	EffectLight.color = Light_Color #adiciono a cor a luz

	EffectLight.energy = _energy#defino a força inicial da luz
		
################################################################################

#método que rodara quando eu estiver pronto
func  _ready() -> void:
	
	Animação_Fantasma() #rodando animação

################################################################################

#endregion

#region My Methods

#método que criara uma animação 
func Animação_Fantasma():
	
	#criando animação
	var _Tween_Fade = get_tree().create_tween()
	
	#SÓ POR GARANTIA conecte o tween
	#a mim para quando eu for liberado da mémoria ele tambem va junto
	_Tween_Fade.bind_node(self)

	#interpolo meu alpha até ficar transparente
	_Tween_Fade.parallel().tween_property(self, "self_modulate", Color(1,1,1,0), 0.75)

	if  EffectLight: #SE effect light existir

		#interpolo a luminozidade do meu ponto luz até ficar invisivel
		_Tween_Fade.parallel().tween_property(EffectLight, "color", Color(Light_Color.r, Light_Color.g, Light_Color.b,0), 1.0)

		#interpolo o força do brilho até ficar invisivel
		_Tween_Fade.parallel().tween_property(EffectLight, "energy", 0.0, 1.0)
		
	#ESPERE QUE a animação acabe
	await _Tween_Fade.finished
	
	#me deleto 
	queue_free()

################################################################################

#endregion
