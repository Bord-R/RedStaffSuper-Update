extends Estado

#criando uma classe para ser usado como node
class_name EstadoMorto #estado morto

#region Variables

#minha animação
@export var Anim : AnimationPlayer

#minha colisão
@export var Collision : CollisionShape2D

#minha hit box
@export var Area2d : Area2D

#particula ao morrer
@export var Dead_particles : PackedScene

#quantidade de bonus de super que eu vou dar
var Quantity_Super : int = 0

#quantidade de pontos que eu vou dar 
var Quantity_Points : int = 0

#endregion

#region My Methods

#método que rodara ao eu iniciar
func Entrada():
	
	#trocando minha animação
	Pai_estados.Anim_nome = "Dead"
	
	#minha colisão é desativada
	Collision.disabled = true
	
	#minha Hitbox deixa de detectar corpos
	Area2d.monitorable = false
	
	#minha Hitbox deixa de detectar outras areas
	Area2d.monitoring = false
	
	#conecto o sinal ao método
	VM.Conected_Signals(Anim.animation_finished, Animacao_finalizada)

################################################################################

#método conectado com o sinal de quando a animação acabar
func Animacao_finalizada(_Anim : StringName):
	
	#SE a animação for igual a "Dead" (morto), eu executo o código
	if _Anim == "Dead":
		
		#instanciando as particulas
		var _Particles : GPUParticles2D = Dead_particles.instantiate()
		
		#adicionando ele a scenetree
		get_tree().root.add_child(_Particles)
		
		#definindo a posição das particulas
		_Particles.global_position = Character.global_position
		
		#meu character fica invisivel
		Character.visible = false
		
		#SE one shot for igual a falso
		if !(_Particles.one_shot):
			
			#ativo uma boleana das particulas 
			_Particles.one_shot = true
			
			#espero meio segundo 
			await get_tree().create_timer(0.8).timeout
			
			#as particulas se deletam
			_Particles.queue_free()
		
		add_Points()
		
		#o node raiz dessa cena se deleta
		Character.queue_free()

################################################################################

#método que adicionara os pontos
func add_Points():
	
	#SE o bonus for menor que o valor maximo de bonus de super
	if Game.Super_Bonus < Game.MAX_SUPER_BONUS: Game.Super_Bonus += Quantity_Super 
	
	#aumento os pontos
	Game.Acresim_Points(Quantity_Points)

################################################################################

#endregion
