extends Estado

#criando uma classe para ser usado como node
class_name EstadoHit #estado tomando dano

#region Variables

#minha animação
@export var Anim : AnimationPlayer

#velocidade para o empurrão
var Knock_vel : float = 0.0

#direção para o empurrão
var Knock_dir : Vector2 = Vector2.ZERO

#endregion

#region My Methods

#método que rodara quando eu iniciar
func Entrada():
	
	#mudando animação
	Pai_estados.Anim_nome = "Hit"
	
	#conecto o sinal ao método
	VM.Conected_Signals(Anim.animation_finished, Animacao_finalizada)

################################################################################

#método que rodar a fisica a cada instante
func Atualizacao_Fisica(_delta : float):
	
	#usando método para mover
	Knock_back(Knock_vel, Knock_dir)

################################################################################

#criando um método para eu receber knokback
func Knock_back(_Knock : float, _position : Vector2):
	
	#criando uma variavel local para definir minha direção
	var _Direction : Vector2 = Character.global_position - _position
	
	#adicionando essa direção ao velocity e aplicando o knock
	Character.velocity = _Direction * _Knock
	
	#movendo
	Character.move_and_slide()

################################################################################

#método que ira rodar quando a animação acabar
func Animacao_finalizada(_Anim : String):
	
	#SE a animação for igual "Hit", eu executo o código
	if _Anim == "Hit" and State != []: #E SE state for diferente de []
		
		#troco de estado para o estado de guarda
		Pai_estados.Troca_Estado(State[0])

################################################################################

#endregion
