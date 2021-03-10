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


class DeleteEvent extends TaskEvent {
  final String name, date, status;

  DeleteEvent({this.name, this.date, this.status});
}

class ClearTableEvent extends TaskEvent {}
