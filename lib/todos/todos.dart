import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/services/todo.dart';
import '../model/task.dart';
import 'bloc/todos_bloc.dart';

class TodoPage extends StatefulWidget {
  final String username;

  const TodoPage({Key? key, required this.username}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('TODOS List'),
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(widget.username)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                children: _buildTaskTiles(context, state.tasks),
                // state.tasks
                //     .map((e) => ListTile(
                //           title: Text(e.task),
                //           leading: Checkbox(
                //               onChanged: (value) {
                //                 // _isChecked = e.completed;
                //                   setState(() => _isChecked = value!);
                //               },
                //               value: _isChecked),
                //           trailing: IconButton(
                //             icon: Icon(Icons.delete, color: Colors.red),
                //             onPressed: () => {},
                //           ),
                //         ))
                //     .toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  List<Widget> _buildTaskTiles(BuildContext context,List<Task> tasks) {
    List<Widget> tiles = [];
      bool isChecked = false;

      for ( var task in tasks ){
      isChecked = task.completed;
      print('Task : ${task.task} . Value : $isChecked');
      final tile = Card(
        child: ListTile(
                          title: Text(task.task,
                          style : Theme.of(context)
                              .textTheme
                              .headline6!.copyWith(color: Colors.black),
        ),
                          leading: Checkbox(
                              onChanged: (value) {
                                // _isChecked = e.completed;
                                  setState(() {if(value != null) isChecked = value; print('CheckBox Toggled. Value : $isChecked');});
                                  
                              },
                              value: isChecked ? true : false ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => {},
                          ),
                          onTap: () {setState(() => {isChecked = !isChecked});print('Tile Toggled. Value : $isChecked');},
                        ),
      );

        tiles.add(tile);
      }

      return tiles;
  }
}
