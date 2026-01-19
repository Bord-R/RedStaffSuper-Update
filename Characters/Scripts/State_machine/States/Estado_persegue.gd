extends Estado

#criando uma classe para eu ser usado como node
class_name EstadoPersegue #estado de perseguição

#region Variables

#criando um Agente2D
@export var Agent : NavigationAgent2D

#boleano que indentificara se eu posso usar a rayCast
var Ray_bool : bool = false

#meu rayCast
@export var Ray : RayCast2D 

#constante para reduzir algum valor
const REDUCAO : float = 0.60 #equivalente a 60%

#criando uma varivel que definara minha próxima posição
var Direction : Vector2

#endregion

#region My Methods

#criando um método para perseguir o jogador
func Perseguindo():
	#dando um alvo(target) para eu serguir
	Agent.target_position = Character.player.global_position
	
	#dando uma direção para eu seguir
	Direction = Character.to_local(Agent.get_next_path_position()).normalized()
	
	#adicionando o movimento
	Character.velocity = (Direction * Character.Enemie_vel)
	
	#movendo
	Character.move_and_slide()

################################################################################

#método que rodara a fisica a cada frame
func Atualizacao_Fisica(_delta : float):
	
	#colocando a animação de andar
	Pai_estados.Anim_nome = "Walk"
	
	#mudando minha direção
	Character.Flip_Direcao()
	
	# a posição alvo do raycast é o player
	Ray.target_position = Character.to_local(Character.player.global_position)
	
	#SE o ray collidir com o player, eu executo o código
	if Ray.get_collider() == Character.player:
		
		#ray_bool é verdadeiro
		Ray_bool = true
	
	else: #SE NÃO
		
		#ray_bool é falso
		Ray_bool = false
	
	#distancia do node raiz até o player
	var _Distance_player : float = Character.global_position.distance_to(Character.player.global_position)
	
	#SE a distancia for menor que minha distancia maxima,eu executo o código
	if _Distance_player < Character.FOLLOW_DISTANCE:
		
		#eu o persigo
		Perseguindo()
	
	#SE NÃO, SE a distancia for maior que a distancia maxima, eu executo o código
	elif _Distance_player > Character.FOLLOW_DISTANCE:
		
		#troco meu estado para o estado de guarda
		Pai_estados.Troca_Estado(State[1])
	
	#SE NÃO, SE a distancia for menor que minha distancia maxima reduzida E ray bool for verdadeiro,
	#eu executo o código
	if _Distance_player < Character.FOLLOW_DISTANCE * REDUCAO and Ray_bool:
		
		#trocando de estado para um estado escolhido no inspetor
		Pai_estados.Troca_Estado(State[0])

################################################################################

#endregion
