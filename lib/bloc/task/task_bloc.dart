import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/di/locator.dart';
import 'package:bloc_sample/model/mymodel.dart';
import 'package:bloc_sample/repository/repository.dart';
import 'package:bloc_sample/widgets/error_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DataRepository dataRepository = locator.get<DataRepository>();
  List<MyModel> list = [];
  List<Map<String, dynamic>> deleteIndex;

  TaskBloc() : super(TaskLoadingState());


  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is LoadEvent)
      yield* infoFunc(event);
    if(event is DeleteEvent)
      yield* deleteFunc(event);
    if(event is LoadOrderEvent)
      yield* infoOrderFunc(event);
  }

  Stream<TaskState> infoFunc(LoadEvent infoEvent) async* {
    yield TaskLoadingState();
    try {
      int id = infoEvent.id;
      list = await dataRepository.databaseItems(id);
      if (list.isEmpty) {
        yield TaskListErrorState(error: NoInformationClass("Нет информации"));
      }
      else
        yield TaskLoadedState(list: list);
    } on DatabaseException {
      yield TaskListErrorState(error: DatabasException('Исключение базы данных'));
    } on TimeoutException {
      yield TaskListErrorState(error: TimeOutException("Тайм-аут"));
    } catch (e) {
      yield TaskListErrorState(error: UnknownException(e.toString()));
    }
  }





  Stream<TaskState> infoOrderFunc(LoadOrderEvent infoEvent) async* {
    yield TaskLoadingState();
    try {
      list = await dataRepository.databaseOrderDate(infoEvent.id, infoEvent.order);
      if (list.isEmpty) {
        yield TaskListErrorState(error: NoInformationClass("Нет информации"));
      }
      else
        yield TaskLoadedState(list: list);
    } on DatabaseException {
      yield TaskListErrorState(error: DatabasException('Исключение базы данных'));
    } on TimeoutException {
      yield TaskListErrorState(error: TimeOutException("Тайм-аут"));
    } catch (e) {
      yield TaskListErrorState(error: UnknownException("Неизвестное исключение"));
    }
  }


  Stream<TaskState> deleteFunc(DeleteEvent deleteEvent) async* {
    yield TaskLoadingState();
    try {
      deleteIndex = await dataRepository.deleteId(deleteEvent.name, deleteEvent.date, deleteEvent.status);
      if (deleteIndex == null)
        yield TaskListErrorState(error: NoInformationClass("No information"));
      else
        yield TaskLoadedState(list: list);
    } on DatabaseException {
      yield TaskListErrorState(error: DatabasException('Database exception'));
    } on TimeoutException {
      yield TaskListErrorState(error: TimeOutException("Time out"));
    } catch (e) {
      yield TaskListErrorState(error: UnknownException("Неизвестное исключение"));
    }
  }

}
