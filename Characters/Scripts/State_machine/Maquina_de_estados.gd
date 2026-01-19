extends Node

#criando uma classe que adiministrara os nodes do tipo Estado
class_name MaquinaEstados

#region Variables

#criando uma variavel para definir meu estado inicial que posso mudar no inspetor
@export var Estado_Incial : Estado

#criando um dicionario que organizara meus estados (nodes filhos)
var Meus_Estados : Dictionary = {}

#criando uma variavel para meu estado atual
var Estado_Atual : Estado

#criando uma variavel de controle para minhas animações
var Anim_nome : String = ""

#endregion

#region Methods

#método que rodara no inicio do jogo
func _ready() -> void:
	
	#criando um loop que parara até ele armazenar todos os meus nodes filhos 
	for Filho : Estado in get_children():
		
		#adicionando uma chave ao meu dicionario que tera o meu node filho como valor
		Meus_Estados[Filho.name.to_lower()] = Filho
		
		#dando um valor para uma variavel do meu filho
		Filho.Pai_estados = self #ela sera usada de referencia para quando eu for chamado

################################################################################

#método que atualizara meu código a cada frame do jogo
func _process(_delta: float) -> void:
	
	#SE eu tenho um estado atual definido, eu executo o código
	if Estado_Atual:
		
		#atualizarei o código escrito no método do meu estado atual
		Estado_Atual.Atualizacao(_delta)

################################################################################

#método que atualizara a fisica do meu código a cada frame do jogo
func _physics_process(_delta: float) -> void:
	
	#SE eu tenho um estado atual definido, eu executo o código
	if Estado_Atual:
		
		#atualizarei (a fisica) o(do) código escrito no método do meu estado atual
		Estado_Atual.Atualizacao_Fisica(_delta)

################################################################################

#endregion

#region My Methods

#criando um método que trocara o estado atual
func Troca_Estado(_Nome_Estado_novo : String):
	
	#SE eu tenho um estado atual, eu executo o código
	if Estado_Atual:
		
		#meu estado atual vai rodar o método de saida
		Estado_Atual.Saida()
	
	#trocando o valor do meu estado atual (trocando o estado)
	Estado_Atual = Meus_Estados.get(_Nome_Estado_novo.to_lower())
	
	#SE eu tenho um estado atual (agora com outro estado sendo o atual), executo o código
	if Estado_Atual:
		
		#chamando o método de quando eu entrar nesse estado
		Estado_Atual.Entrada()

################################################################################

#método que fara eu ser carregado
func Carregando(_area : Area2D):
	
	#meu pai é carregado
	if _area.name == "Carregador":
		
		get_parent().visible = true
		
		#SE eu tenho um estado inicial definido, eu executo o código
		if Estado_Incial:
			
			#trocando o estado, para o Estado inicial
			Troca_Estado(Estado_Incial.name.to_lower())

################################################################################


#endregion
