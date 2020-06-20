# PMSB4

Versão independente do projeto PMSB para desenvolvimento dos môdulos Gestor de tarefas (Kanban) e Sintese (indicadores) usando controle de estados com Redux.

A integração do PMSB3 com esta versão, PMSB4 em Redux, será analisada futuramente.

# Definições neste projeto

## Em ingles
* Código Dart e Flutter em ingles
* Coleções e campos novos do Firebase em ingles

## Em portugues
* coleções velhas em portugues (nao compensa mudar)
* dados para usuario em portugues (cliente em potencial)
* git em portugues. para quem nao escreve em ingles.
* TODOs em portugues. para quem nao escreve em ingles.
* Issues em portugues. para quem nao escreve em ingles.

# Pastas
Considerando um projeto basico do counter do flutter

+ actions
	- counter_action.dart
+ container
	+ components
		- counter_value.dart
	+ counter
		- counter_page.dart
+ middlewares
	+ firebase
		+ authentication
			- authentication_middleware.dart
		- firebase_model.dart
		+ counter
			- counter_model.dart
			- counter_middleware.dart
+ presentation
	+ components
		- counter_value_ds.dart
		- counter_text_cds.dart
	+ counter
		- counter_button_comp.dart
		- counter_page_ds.dart
+ reducers
	- app_reducer.dart
	- counter_reducer.dart
+ selectors
	- counter_selector.dart
+ states
	- app_state.dart
	- counter_state.dart
- main.dart
- routes.dart

