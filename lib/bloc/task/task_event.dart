part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class LoadEvent extends TaskEvent{
  final int id;
  LoadEvent({this.id});
}

class LoadOrderEvent extends TaskEvent{
  final int id;
  final String order;
  LoadOrderEvent({this.id, this.order});
}


class DeleteEvent extends TaskEvent {
  final String name, date, status;

  DeleteEvent({this.name, this.date, this.status});
}

class ClearTableEvent extends TaskEvent {}
