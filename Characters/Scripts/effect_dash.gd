extends Sprite2D

#criando classe para ser usado como node
class_name DashEffect

#region Methods

#método que rodara quando eu for instanciado
func _init(_my_pos : Vector2, _my_sca : Vector2, _my_tex : Texture2D) -> void:
	
	#definindo minha posição
	position = _my_pos
	
	#definindo minha escala
	scale = _my_sca
	
	#definindo minha textura
	texture  = _my_tex

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
	
	#definindo os comportamentos da animação
	_Tween_Fade.tween_property(self, "self_modulate", Color(1,1,1,0), 0.75)
	
	#ESPERE QUE a animação acabe
	await _Tween_Fade.finished
	
	#me deleto 
	queue_free()

################################################################################

#endregion
