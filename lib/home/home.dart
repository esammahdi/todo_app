import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/services/authentication.dart';
import 'package:todo_app/services/todo.dart';
import 'package:todo_app/todos/todos.dart';

import 'bloc/homebloc_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final userField = TextEditingController();
  final passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        leading: Icon(Icons.login),
      ),
      body: BlocProvider(
        create: (context) => HomeblocBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisteringServicesEvent()),
        child: BlocConsumer<HomeblocBloc, HomeblocState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodoPage(username: state.username)));
            }
          },
          builder: (context, state) {
            if (state is HomeblocInitial) {
              return Column(
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: userField,
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: 'UserName',
                        counterText: '10',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordField,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.password),
                        labelText: 'Password',
                        counterText: '10',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeblocBloc>(context)
                        .add(LoginEvent(userField.text, passwordField.text)),
                    child: Text('Login'),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
