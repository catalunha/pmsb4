import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pmsb4/actions/kanban_card_action.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/todo_card_create_ds.dart';
import 'package:pmsb4/presentations/kaban/components/todo_card_update_ds.dart';
import 'package:pmsb4/presentations/kaban/todo_card_crud_ds.dart';
import 'package:pmsb4/states/app_state.dart';
import 'package:redux/redux.dart';

class _ViewModel {
  final String title;
  final Function(String) onCreateOrUpdate;
  // final Function(String) onUpdate;

  _ViewModel({
    this.title,
    this.onCreateOrUpdate,
    // this.onUpdate,
  });
  static _ViewModel fromStore(Store<AppState> store, String id) {
    Todo todo = id != null
        ? store.state.kanbanCardState.currentKanbanCardModel.todo[id]
        : Todo(id: null);
    void onViewUpdate() {
      store.dispatch(UserViewOrUpdateKanbanCardModelAction(
          user: store.state.loggedState.firebaseUserLogged.uid, viewer: false));
      store.dispatch(UpdateKanbanCardDataAction(
          kanbanCardModel: store.state.kanbanCardState.currentKanbanCardModel));
    }

    return _ViewModel(
      title: todo?.title ?? '',
      onCreateOrUpdate: (String title) {
        todo.title = title;
        store.dispatch(UpdateTodoKanbanCardModelAction(todo: todo));
        onViewUpdate();
      },
      // onCreate: (String title) {
      //   todo.title = title;
      //   store.dispatch(UpdateTodoKanbanCardModelAction(todo: todo));
      //   onViewUpdate();
      // },
      // onUpdate: (String title) {
      //   todo.title = title;
      //   store.dispatch(UpdateTodoKanbanCardModelAction(todo: todo));
      //   onViewUpdate();
      // },
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
          isCreate: id == null ? true : false,
          title: _viewModel.title,
          onCreateOrUpdate: _viewModel.onCreateOrUpdate,
        );

        // if (id == null) {
        //   return TodoCardCreateDS(
        //     onCreate: _viewModel.onCreate,
        //   );
        // } else {
        //   return TodoCardUpdateDS(
        //     title: _viewModel.title,
        //     onUpdate: _viewModel.onUpdate,
        //   );
        // }
      },
    );
  }
}
