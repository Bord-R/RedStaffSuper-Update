extends Node

#criando uma classe para ser usado como node
class_name SpinMove #girando e movendo

#region Variables

#criando uma referencia ao node pai
@onready var Bullet = get_parent()

#tempo em que eu ficarei parado
@export var Timer_mov : float 

#impulso
const IMPULSO : float = 2

#suavização para um lerp
const SUAVIZACAO : float = 0.25

#ZERO
const ZERO : float = 0.0

#velocidade do giro
var Vel_rotate : float = 10.0

#bolano que  verecidara se eu posso girar
var Bool_spin : bool = false

#endregion

#region Methods

#método que rodara no inicio do game
func _ready() -> void:
	
	#SE o sinal já não foi conectado ao método animacao finalizada, eu...
	if !Bullet.Anim.animation_finished.is_connected(Animacao_finalizada):
		
		#conecto o sinal ao método
		Bullet.Anim.animation_finished.connect(Animacao_finalizada)

#método que rodara quando o sinal animation finished
func Animacao_finalizada(_Anim : StringName):
	
	#SE o nome da animação for igual a "start", eu...
	if _Anim == "start":
		
		#posso girar
		Bool_spin = true

#método que rodara a cada frame do game
func _process(_delta: float) -> void:
	
	#SE eu NÃO posso girar OU o timer for menor que zero, eu...
	if Bool_spin == false or Timer_mov <= ZERO: 
		
		#movendo o node pai
		Bullet.position += Bullet.transform.x * Bullet.Vel
		
		#vou girar
		Bullet.texture.rotation_degrees += Vel_rotate
	
	#SE NÃO, SE eu posso girar
	elif Bool_spin == true: 
		
		#vou girar
		Bullet.texture.rotation_degrees += Vel_rotate
		
		#vou diminuir o timer
		Timer_mov -= VM.MINOS_TIMER
		
		#SE o timer for menor que zero
		if Timer_mov <= ZERO:
			
			#dando impulso
			Bullet.Vel *= IMPULSO

#endregion
