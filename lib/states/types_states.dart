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
  activeAuthor, //all=filter
  activeTeam, //all=filter
  publics, //all=filter
  inactive, //all=filter
}

enum KanbanCardFilter {
  all, // so para desenvolvimento no mid
  active, //all=active+normal+priority
  inactive, //all=inactive+normal+priority
  normal, ////filter<all>= normal
  priority, //filter<all>= priority
}

class KanbanCardFilter2 {
  static String all = 'all';
  static String label(String value) {
    return 'allll';
  }
}

enum UserFilter {
  all,
}
