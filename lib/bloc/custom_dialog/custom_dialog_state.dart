part of 'custom_dialog_bloc.dart';

@immutable
abstract class CustomDialogState {}

class CustomDialogInitial extends CustomDialogState {}

class CustomDialogLoadingState extends CustomDialogState {}

class CustomDialogListErrorState extends CustomDialogState{
  final error;
  CustomDialogListErrorState({this.error});
}
