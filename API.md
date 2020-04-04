Macromoney API de referencia sem-versão
=======================================


Summary
-------
* Introdução
* Operações gerais
* Funcionalidades
* Métodos
* Tabelas globais
* Definições de tabelas


Introdução
----------
O objetivo principal dessa documentação é tornar facil o entendimento 
e a utilização dos métodos do sistema macromoney.


Operações gerais
----------------
Esse sistema é basicamente um registrador de valores em um banco de 
dados separado do banco de dados do servidor. É possivel que outras 
modificações registrem sua propria moeda ou outro registro semelhante.


Funcionalidades
---------------
Veja aqui algumas das coisas úteis em macromoney

#### Salvando dados das contas
As contas ficam salvas na pasta ´macronodes´ dentro da pasta do mundo 
correspondente bastando apenas copiar a pasta para obter os dados e 
coloca-lo no mundo onde quiser no futuro. Lembre-se de manter as mesmas 
contas no mundo pois a conta no sistema macromoney corresponde aos 
jogadores ativos no servidor.

#### Registrando novos valores
É possivel criar novos valores (moedas, medalahs, xp, etc). 
Mas lembresse que os dados de todas os valores registrados ficarão salvos 
junto, mas caso um valor será desativado futuramente não há problema em 
usar o mesmo banco de dados pois os registros do valor ficaram inacessiveis 
no banco de dados.


Métodos
-------
Veja os métodos de acordo com sua finalidade.

#### Registrar valores
* `macromoney.register_value(value_id, {definições de valor})`: Register value

#### Manipular valores em contas
* `macromoney.get_account(player_name, value_id)`: Pega um valor em uma conta
* `macromoney.add_account(player_name, value_id, add_value)`: Adiciona um valor em uma conta
* `macromoney.subtract_account(player_name, value_id, subtract_value)`: Subtrai um valor em uma conta
* `macromoney.exist_account(player_name)`: Verifica se uma conta existe


Tabela global
-------------
* `macromoney.registered_values`: Valores registrados, indexado pelo ID do valor


Definições de tabelas
---------------------

### Definições de valor (`register_value`) 
    {
	description = "Macro money", 	-- Descrição do valor
	specimen_prefix = "M¢", 	-- Prefixo do valor moeda (exemplo: $, £, etc)
	specimen_name = "Macro", 	-- Nome da moeda. Não é recomendado usar 'specimen_prefix' e 'specimen_name' simultaneamente. Escolha só um deles.
	value_type = "number", 		-- Tipo de valor. Apenas "number" para valores numéricos.
	initial_value = 0, 		-- Valor inicial
	tag = "money", 			-- Termo simples para ser usado em comandos de console
    }





