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

# Designer for UI

https://whimsical.com/MWMyhejqiEmC4LgAFC7eUe

## Pattern for Widgets Presentation
* Nao se esqueça variáveis tudo em ingles.
~~~
class WidgetParentDS extends StatelessWidget {
  final String text;
  final bool boolean;
  final int integer;
  final List<type> xList; // pattern for list
  final Function(String) onDelete; //pattern
  final Function(String) onX; // pattern for Functions
...
}

class WidgetParentDS extends StatefulWidget {
  final bool isCreate; //pattern
  final String text;
  final bool boolean;
  final int integer;
  final Function(String, [String,]) onCreateOrUpdate;//pattern
  final Function(String) onDelete; //pattern
...
}

class WidgetChildCDS extends StatelessWidget {
  // idem ao pattern
...
}

# Models

## KanbanBoardModel
  String title;
  String description;
  bool public;
  UserKabanRef author;
  Map<String, UserKabanRef> team = Map<String, UserKabanRef>();
  dynamic created;
  dynamic modified;
  bool active;

## KanbanCardModel
  String kanbanBoard;
  String title;
  String description;
  bool priority;
  UserKabanRef author;
  String stageCard;
  Map<String, UserKabanRef> team = Map<String, UserKabanRef>();
  Map<String, Todo> todo = Map<String, Todo>();
  Map<String, Feed> feed = Map<String, Feed>();
  int todoOrder;
  dynamic created;
  dynamic modified;
  bool active;
  int todoCompleted;
  int todoTotal;

### References

UserKabanRef
  String id;
  String displayName;
  String photoUrl;
  bool readedCard;
Todo
  String id;
  String title;
  bool complete;
Feed
  UserKabanRef author;
  String description;
  String link;
  dynamic created;
  String id;
  bool bot;

# Enumarations
enum StageCard{
  todo,
  doing,
  check,
  done,
}
enum AuthenticationStatus {
  unInitialized,
  authenticated,
  authenticating,
  unAuthenticated,
  sendPasswordReset,
}
enum CollectionFilter {
  all,
  checkTrue,
  checkFalse,
  checkNull,
}
enum KanbanBoardFilter {
  all, // so para desenvolvimento no mid
  active, //all=filter
  inactive, //all=filter
  publics, //all=filter
}
enum KanbanCardFilter {
  all, // so para desenvolvimento no mid
  active, //all=active+normal+priority
  inactive, //all=inactive+normal+priority
  normal, ////filter<all>= normal
  priority, //filter<all>= priority
}

~~~
# Send to Hosting
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