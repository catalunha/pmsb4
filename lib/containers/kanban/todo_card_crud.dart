import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/todo_card_crud_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final bool isCreate;
  final String title;
  final Function(String) onCreateOrUpdate;

  _ViewModel({
    this.isCreate,
    this.title,
    this.onCreateOrUpdate,
  });
  static _ViewModel fromStore(Store<AppState> store, String id) {
    Todo todo = id != null
        ? store.state.kanbanCardState.currentKanbanCardModel.todo[id]
        : null;

    return _ViewModel(
      isCreate: id == null ? true : false,
      title: todo?.title ?? '',
      onCreateOrUpdate: (String title) {
        store.dispatch(UpdateTodoKanbanCardModelAction(
            todo: Todo(
          id: id,
          title: title,
        )));
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

class TodoCardCRUD extends StatelessWidget {
  final String id;

  const TodoCardCRUD({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, id),
      builder: (BuildContext context, _ViewModel _viewModel) {
        return TodoCardCRUDDS(
          isCreate: _viewModel.isCreate,
          title: _viewModel.title,
          onCreateOrUpdate: _viewModel.onCreateOrUpdate,
        );
      },
    );
  }
}