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

enum KanbanCardFilter {
  all, // so para desenvolvimento no mid
  active, //all=active+normal+priority
  inactive, //all=inactive+normal+priority
  normal, ////filter<all>= normal
  priority, //filter<all>= priority
}

enum UserFilter {
  all,
}
