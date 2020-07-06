# PMSB4

Versão independente do projeto PMSB para desenvolvimento dos môdulos Gestor de tarefas (Kanban) e Sintese (indicadores) usando controle de estados com Redux.

A integração do PMSB3 com esta versão, PMSB4 em Redux, será analisada futuramente.
# Titulo nata
# GitHub
Uma sequencia importante de comandos do git é
Local:
~~~
//etapa01
git checkout master
git pull origin master
git fetch --prune
git branch --all
// Verifique as branchs locais e remotas. Apague o que for necessario pra manter sincronizada sua área de trabalho local.
git branch -d issueX
~~~
~~~
//etapa02
// Veja q vc precisa ter concluido a etapa01
// Crie e, ou escolha uma issue pequena
// Trabalhe apenas na solução especifica dela. 
// Por exemplo issueY onde Y é sempre o numero da issue.
git branch issueY
git checkout issueY
// Resolva a issueY
// FAÇA TODOS OS TESTES NECESSÁRIOS PRA EVITAR REFATORAÇÃO COM NOVA ISSUE.
git add .
git commit -m 'sua msg para a issueY'
git push origin issueY
// Solicite um PullRequest desta issue para master. veja etapa03
// A aguarde minha resposta caso precise dela, acompanhando a issue.
// Escolha outra issue e volte para a etapa01 depois etapa02. 
~~~
Remote:
~~~
//etapa03
// No gitHub click Pull Request
// Escolha a branch a ser enviada para master.
// base: master <- compare: issueY
// Coloque o nome do PullRequest com o mesmo nome da issueY
// Click Create pull request
// Volte na issueY e link esta issue ao pull de nome issueY
// Aguarde pois irei fazer pull local desta branch entender o que vc fez.
// Caso inconpleta pode continuar atualizando a issue e a branch respectiva.
//  O PullRequest continua recebendo estes commits ate concluirmos a issue com a branch respectiva
// Concluida a issue darei o merge e irei apagar a branch. Por isto é importante a etapa01
~~~

# Branchs e Redux

Estou construindo esta app baseada no redux: [Fluxo Redux PMSB4](https://docs.google.com/drawings/d/177q-Ot3TkkmkMSeiArFg5LUSyGv8G18X30OyE8jtftg/edit?usp=sharing)

## Master
Ativa no hosting. Atualizada a cada issue.
Desta branch podem derivar outras para atender a issue.

## issueX
Baseada numa issue que aperfeiçõe ou resolve um problema na aplicação partindo de testes/otimização/refactoração/UI/UX 

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
		- counter_page_ds.dart
    + components
			- counter_button.dart
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

# Models

# Run for chrome and send to Hosting
Estando em .../pmsb4$ 
~~~
flutter channel
//Flutter channels:
//  master
//  dev
//* beta
//  stable

flutter run -d chrome

flutter build web

firebase deploy --only hosting:pmsbto
~~~