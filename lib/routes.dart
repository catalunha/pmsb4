import 'package:flutter/material.dart';

class Routes {
  static final home = '/';
  static final profile = '/profile';
  static final profileUpdate = '/profile_update';
  static final kanbanBoardPage = '/kanban_board_page';
  static final kanbanBoardCRUD = '/kanban_board_crud';
  static final teamBoard = '/team_board';
  static final kanbanCardPage = '/kanban_card_page';
  static final kanbanCardCRUD = '/kanban_card_crud';
  static final teamCard = '/team_card';
  static final todoCardPage = '/todo_card_page';
  static final todoCardCRUD = '/todo_card_crud';
  static final feedCardPage = '/feed_card_page';
  static final feedCardCRUD = '/feed_card_crud';
}

class Keys {
  static final navKey = GlobalKey<NavigatorState>();
}
