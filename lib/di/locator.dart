
import 'package:bloc_sample/repository/repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void locatorSetUp(){
  locator.registerSingleton(DataRepository());
}