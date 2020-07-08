enum AuthenticationStatus {
  unInitialized,
  authenticated,
  authenticating,
  unAuthenticated,
  sendPasswordReset,
}

//+++KanbanBoardFilter
enum KanbanBoardFilter {
  all,
  activeAuthor,
  activeTeam,
  publics,
  inactive,
}

extension KanbanBoardFilterExtension on KanbanBoardFilter {
  static const names = {
    KanbanBoardFilter.all: 'TODOS OS QUADRO (Dev)',
    KanbanBoardFilter.activeAuthor: 'Quadros que coordeno',
    KanbanBoardFilter.activeTeam: 'Quadros que estou na equipe',
    KanbanBoardFilter.publics: 'Quadros públicos',
    KanbanBoardFilter.inactive: 'Quadros arquivados',
  };
  String get name => names[this];
}
//---KanbanBoardFilter

//+++KanbanCardFilter
enum KanbanCardFilter {
  all, // so para desenvolvimento no mid
  active, //all=active+normal+priority
  inactive, //all=inactive+normal+priority
  normal, ////filter<all>= normal
  priority, //filter<all>= priority
}

extension KanbanCardFilterExtension on KanbanCardFilter {
  static const names = {
    KanbanCardFilter.all: 'Todos os cartões',
    KanbanCardFilter.active: 'Cartões ativos',
    KanbanCardFilter.inactive: 'Cartões inativos',
    KanbanCardFilter.normal: 'Prioridade normal',
    KanbanCardFilter.priority: 'Prioridade alta',
  };
  String get name => names[this];
}
//---KanbanCardFilter

enum UserFilter {
  all,
}
