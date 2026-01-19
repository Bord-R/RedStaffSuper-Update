extends Node

#criando uma classe para criar nodes que descendam de mim
class_name Estado

#region Variables

#criando uma referencia ao minha maquina de estados que ira gerenciar seus filhos
var Pai_estados : MaquinaEstados

#referencia ao inimigo
@export var Character : EnemiesFruits

#estado que eu vou trocar
@export var State : Array[String]

#endregion

#region My Methods

#criando um método para quando eu iniciar no estado
func Entrada():
	pass #ignore esse método

#criando método para quando eu sair do estado
func Saida():
	pass #ignore esse método

#criando um método para atualizar meu estado enquanto ele estiver ativo
func Atualizacao(_delta : float):
	pass #ignore esse método

#criando um método para atualizar a fisica do meu estado enquanto ele estiver ativo
func Atualizacao_Fisica(_delta : float):
	pass #ignore esse método

#endregion
