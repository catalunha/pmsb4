import 'package:meta/meta.dart';
import 'package:pmsb4/middlewares/firebase/firestore/colecao/colecao_model.dart';

@immutable
class ColecaoState {
  final ColecaoModel colecaoModel;
  final List<ColecaoModel> listColecaoModel;
  ColecaoState({
    this.listColecaoModel,
    this.colecaoModel,
  });

  factory ColecaoState.initial() {
    return ColecaoState(
      colecaoModel: null,
      listColecaoModel: [],
    );
  }
  ColecaoState copyWith({
    ColecaoModel colecaoModel,
    List<ColecaoModel> listColecaoModel,
  }) {
    return ColecaoState(
      colecaoModel: colecaoModel,
      listColecaoModel: listColecaoModel,
    );
  }

  @override
  int get hashCode => colecaoModel.hashCode ^ listColecaoModel.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColecaoState &&
          runtimeType == other.runtimeType &&
          colecaoModel == other.colecaoModel &&
          listColecaoModel == other.listColecaoModel;

  @override
  String toString() {
    return 'ColecaoState{colecaoModel:$colecaoModel,listColecaoModel:$listColecaoModel}';
  }
}
