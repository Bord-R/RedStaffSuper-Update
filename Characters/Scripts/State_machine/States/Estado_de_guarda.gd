extends Estado

#criado a classe para ser usado como nó
class_name EstadoGuarda #estado de guarda

#region Variables

#minha proxima posição
var Next_position : Vector2 = Vector2.ZERO

#meu timer com valor maximo
var MAX_TIMER_SPLEEP : float = 0.0

#meu timer de descansando
var Sleep_timer : float = 0.0

#meu timer de guarda com valor maximo
var MAX_TIMER_GUARD : float = 0.0

#meu timer de guarda
var Guard_timer : float = 0.0

#endregion

#region My Methods

#método que rodara quando eu iniciar
func Entrada():
	
	#colocando o valor maximo do timer como um valor aletório
	MAX_TIMER_SPLEEP = randf_range(1.0, 10.0)
	
	#definindo que meu tempo dormindo é igual ao meu MAX TIMER
	Sleep_timer = MAX_TIMER_SPLEEP
	
	#colocando o valor maximo do timer com um valor maximo entre 20.0 e 40.0
	MAX_TIMER_GUARD = randf_range(5.0, 2.5)
	
	#definindo que meu tempo de guarda é igual ao meu MAX TIMER
	Guard_timer = MAX_TIMER_GUARD
	
	#definindo uma posição aleatória para eu ir depois
	Next_position = Vector2(randi_range(-1,1), randi_range(-1,1))

################################################################################

#método que vai fazer meu inimigo fazer patrulha
func Guarda_sonolento():
	
	#SE o meu Sleep_timer for maior que 0, eu executo o cógido
	if Sleep_timer > 0.0:
		
		#definindo qual animação sera rodada
		Pai_estados.Anim_nome = "Idle"
		
		#meu timer é diminuido
		Sleep_timer -= VM.MINOS_TIMER
	
	#SE NÃO, SE meu tempo dormindo for menor ou igual que 0, eu executo o código
	elif Sleep_timer <= 0.0:
		
		#definindo a animação a ser rodada
		Pai_estados.Anim_nome = "Walk"
		
		#fazendo meu pai andar
		Character.velocity = Next_position * (Character.Enemie_vel)
		
		#SE meu Guard_timer for maior que 0, eu executo o código
		if Guard_timer > 0.0:
			
			#diminuindo o valor do timer
			Guard_timer -= VM.MINOS_TIMER
		
		#SE NÃO, SE meu Guard_timer for menor ou igual que 0, eu executo o código
		elif Guard_timer <= 0.0:
			
			#chamando o método novamente
			Entrada()
		
		#movendo meu pai
		Character.move_and_slide()

################################################################################

#método que rodara a fisica enquanto eu estiver rodando
func Atualizacao_Fisica(_delta : float):
	
	#mudando minha direção
	Character.Flip_Direcao()
	
	#distancia do jogador
	var _Distance : float = Character.global_position.distance_to(Character.player.global_position)
	
	#SE a distancia for maior que a distancia maxima eu continuo nesse estado
	if _Distance > Character.FOLLOW_DISTANCE:
		
		#método que roda as caracteristicas desse estado
		Guarda_sonolento()
	
	#SE NÃO, SE a distancia for menor que a distancia maxima eu executo o código
	elif _Distance < Character.FOLLOW_DISTANCE and State != []: #E state for diferente de []
		
		#troco meu estado para perseguir
		Pai_estados.Troca_Estado(State[0])

################################################################################

#endregion
