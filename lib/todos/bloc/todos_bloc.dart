import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/home/bloc/homebloc_bloc.dart';
import 'package:todo_app/services/todo.dart';

import '../../model/task.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final tasks = _todoService.getTasks(event.username);
      emit(TodosLoadedState(tasks));
    });
  }
}
