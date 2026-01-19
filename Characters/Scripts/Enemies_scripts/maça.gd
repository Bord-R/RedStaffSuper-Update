extends EnemiesFruits

#region Variables

#minha velocidade maxima
const MAX_VEL : float = 60.0

#minha vida maxima
const MAX_LIFE : int = 20

#minha distancia maxima
const MAX_DISTANCE : float = 250.0

#constante que representa o valor maximo do meu timer
const MAX_TIMER_SPLASH : float = 15.0

#timer 
var Timer_splash : float = MAX_TIMER_SPLASH

#endregion

#region Methods

#método que ira rodar no inicio do game
func _ready() -> void:
	
	#conectando um sinal da minha hit box ao método Carregamento
	VM.Conected_Signals(Area.area_entered, Maquina_estados.Carregando)


	#minha distancia maxima
	FOLLOW_DISTANCE = MAX_DISTANCE
	
	#definindo minha vida
	Enemie_life = MAX_LIFE
	
	#minha velocidade é igual a minha velocidade maxima
	Enemie_vel = MAX_VEL

################################################################################

#método que ira rodar a fisica
func _physics_process(_delta: float) -> void:
	
	#método que fara meu ciclo de vida
	Cicle_Dead_and_Splash()
	
	#SE o player morreu, eu tambem morro (pensamento perigoso em)
	if Game.Player_Dead: queue_free()

	#SE eu estou sendo carregado
	elif visible == true:
		
		#método para mudar minha animação
		Troca_animacao(Maquina_estados.Anim_nome)

################################################################################

#endregion

#region My Methods

#ciclo de morte e splash
func Cicle_Dead_and_Splash():
	
	#SE minha vida for menor ou igual que 0, eu morro
	if Enemie_life <= 0: Maquina_estados.Troca_Estado("EstadoMorto")
	
	#SE meu estado atual for da classe EstadoPersegue ou EstadoGuarda, eu...
	if Maquina_estados.Estado_Atual is EstadoGuarda or Maquina_estados.Estado_Atual is EstadoPersegue:
		
		#SE timer Splash for maior que 0, eu
		if Timer_splash > 0.0:
			
			Timer_splash -= VM.MINOS_TIMER #diminuo o timer
		
		#SE NÃO
		else: 
			
			#troco para o estado de splash
			Maquina_estados.Troca_Estado("EstadoSplash")
			
			#meu timer volta ao seu valor original
			Timer_splash = MAX_TIMER_SPLASH

################################################################################

#endregion
