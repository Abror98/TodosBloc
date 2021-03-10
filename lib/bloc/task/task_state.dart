part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TaskLoadingState extends TaskState {}



class TaskLoadedState extends TaskState{
  final List<MyModel> list;
  TaskLoadedState({this.list});

  @override
  List<Object> get props => [list];
}

class TaskDeleteLoadedState extends TaskState{
   final int index;
   TaskDeleteLoadedState({this.index});

   @override
  // TODO: implement props
  List<Object> get props => [index];
}


class TaskListErrorState extends TaskState{
  final error;
  TaskListErrorState({this.error});
}



