# PMSB4

Versão independente do projeto PMSB para desenvolvimento dos môdulos Gestor de tarefas (Kanban) e Sintese (indicadores) usando controle de estados com Redux.

A integração do PMSB3 com esta versão, PMSB4 em Redux, será analisada futuramente.

# GitHub
Uma sequencia importante de comandos do git é
Local:
~~~
//inicio
git fetch --prune
git branch --all
// Verifique as branchs locais e remotas. Apague o que for necessario pra manter sincronizada sua área de trabalho local.
git branch -d <issue-x>
// Escolha uma issue e trabalhe na solução especifica dela. Por exemplo <issue-y>
git checkout master
git pull origin
git branch <issue-y>
git checkout <issue-y>
// Resolva a <issue-y>
git add .
git commit -m 'sua msg para a <issue-y>'
git push origin <issue-y>
// Solicite um PullRequest desta issue para master.
// A aguarde minha resposta caso precise dela, ou 
// Escolha outra issue e volte para o inicio desta rotina. 
~~~
Remote:
~~~
// Click Pull Request
// Escolha a branch a ser enviada para master.
// base: master <- compare: <issue-y>
// Click Create pull request

~~~

# Branchs e Redux

Estou construindo este modelo para o redux: [Fluxo Redux PMSB4](https://docs.google.com/drawings/d/177q-Ot3TkkmkMSeiArFg5LUSyGv8G18X30OyE8jtftg/edit?usp=sharing)

## Master
Ativa no hosting. Atualizada a cada issue.
Desta branch podem derivar outras para atender a issue.

## outras
Desenvolvimento básico da aplicação para testes e dev/otimização/refactoração do padrão Redux.

Branch básica para desenvolvimento das ui ou presentation e para redux criada a partir de issues ou para demandas específicas


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
    + components
      - counter_factorial.dart
+ middlewares
	+ firebase
		+ authentication
			- authentication_middleware.dart
		- firebase_model.dart
		+ counter
			- counter_middleware.dart
+ model
	- counter_model.dart
+ presentation
	+ components
		- counter_value_ds.dart
		- counter_text1_cds.dart
	+ counter
		- counter_button.dart
		- counter_page_ds.dart
    + components
      - counter_factorial_ds.dart
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

## Telas
~~~
+ KanbanBoardPage->KanbanBoardPageDS
	+ KanbanBoardCRUD->KanbanBoardCRUDDS
		- TeamBoard->TeamBoardDS
	- ShortBoardCDS
		+ KanbanBoardCRUD->KanbanCardCRUDDS
			- TeamBoard->TeamBoardDS
		+ KanbanCardPage->KanbanCardPageDS
			- ShortCard
				- KanbanCardCRUD->KanbanCardCreateDS
				+ KanbanCardCRUD->KanbanCardUpdateDS
					- EquipeWrapCDS
						- TeamCard->TeamCardDS
					- FeedCardList->FeedCardListDS
						- FeedCardCRUD->FeedCardCreateDS
						- FeedCardOne->
							- FeedCardCRUD->FeedCardUpdateDS
					- TodoCardList->TodoCardListDS
						- TodoCardCRUD->TodoCardCreateDS
						- TodoCardCRUD->TodoCardUpdateDS
						
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