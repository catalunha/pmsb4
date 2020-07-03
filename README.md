# PMSB4

Versão independente do projeto PMSB para desenvolvimento dos môdulos Gestor de tarefas (Kanban) e Sintese (indicadores) usando controle de estados com Redux.

A integração do PMSB3 com esta versão, PMSB4 em Redux, será analisada futuramente.

# Branchs e Redux

Estou construindo este modelo para o redux: [Fluxo Redux PMSB4](https://docs.google.com/drawings/d/177q-Ot3TkkmkMSeiArFg5LUSyGv8G18X30OyE8jtftg/edit?usp=sharing)

## Master
Ativa no hosting. Atualizada a cada issue.
Desta branch podem derivar outras para atender a issue.

## Xissue
Desenvolvimento básico da aplicação para testes e dev/otimização/refactoração do padrão Redux.

Branch básica para desenvolvimento das ui ou presentation


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
		- counter_value1.dart
	+ counter
		- counter_page.dart
    + components
      - counter_value2.dart
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
		- counter_value1_ds.dart
		- counter_text1_cds.dart
	+ counter
		- counter_button_comp.dart
		- counter_page_ds.dart
    + components
      - counter_value2_ds.dart
      - counter_text2_cds.dart
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

# Designer for UI

https://whimsical.com/MWMyhejqiEmC4LgAFC7eUe

## Pattern for Widgets Presentation
* Nao se esqueça tudo em ingles.
~~~
class WidgetParentDS extends StatelessWidget/StatefulWidget {
  final bool isCreate; //pattern
  final String text;
  final bool boolean;
  final int integer;
  final List<type> xList; // pattern for list
  final Function(String, [String,]) onCreateOrUpdate;//pattern
  final Function(String) onDelete; //pattern
  final Function(String) onX; // pattern for Functions
...
}

class WidgetChildCDS extends StatelessWidget/StatefulWidget {
  // idem ao pattern
  // pegar var e function do parent WidgetParentDS
...
}
~~~

# Models

# Run for chrome and send to Hosting
/pmsb4$ flutter channel
Flutter channels:
  master
  dev
* beta
  stable

/pmsb4$ flutter run -d chrome

/pmsb4$ flutter build web

/pmsb4$ firebase deploy --only hosting:pmsbto
~~~