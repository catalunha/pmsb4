import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/todo_card_page_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final List<Todo> listTodo;
  final Function(String) onDelete;
  final Function(String) onChangeComplete;
  final Function(Map<String, String>) onChangeTodoOrder;

  _ViewModel({
    this.listTodo,
    this.onDelete,
    this.onChangeComplete,
    this.onChangeTodoOrder,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      listTodo: store.state.kanbanCardState.currentKanbanCardModel?.todo != null
          ? store.state.kanbanCardState.currentKanbanCardModel.todo.entries
              .map((e) => e.value)
              .toList()
          : [],
      onChangeComplete: (String id) {
        store.dispatch(UpdateTodoKanbanCardModelAction(
            todo: Todo(
          id: id,
          complete: !store
              .state.kanbanCardState.currentKanbanCardModel.todo[id].complete,
        )));
        store.dispatch(UserViewOrUpdateKanbanCardModelAction(
            user: store.state.loggedState.firebaseUserLogged.uid,
            viewer: false));

        store.dispatch(UpdateKanbanCardDataAction(
            kanbanCardModel:
                store.state.kanbanCardState.currentKanbanCardModel));
      },
      onChangeTodoOrder: (Map<String, String> todoOrder) {
        KanbanCardModel _currentKanbanCardModel =
            store.state.kanbanCardState.currentKanbanCardModel;
        _currentKanbanCardModel.todoOrder = todoOrder;
        store.dispatch(UpdateKanbanCardDataAction(
            kanbanCardModel: _currentKanbanCardModel));
      },
      onDelete: (String id) {
        store.dispatch(RemoveTodoKanbanCardModelAction(id: id));
        store.dispatch(UserViewOrUpdateKanbanCardModelAction(
            user: store.state.loggedState.firebaseUserLogged.uid,
            viewer: false));
        store.dispatch(UpdateKanbanCardDataAction(
            kanbanCardModel:
                store.state.kanbanCardState.currentKanbanCardModel));
      },
    );
  }
}

class TodoCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return TodoCardPageDS(
          listTodo: _viewModel.listTodo,
          onChangeComplete: _viewModel.onChangeComplete,
          onChangeTodoOrder: _viewModel.onChangeTodoOrder,
          onDelete: _viewModel.onDelete,
        );
      },
    );
  }
}
