import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/services/todo.dart';

import '../../services/authentication.dart';

part 'homebloc_event.dart';
part 'homebloc_state.dart';

class HomeblocBloc extends Bloc<HomeblocEvent, HomeblocState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeblocBloc(this._auth, this._todo) : super(const RegisteringServicesState()) {
    on<LoginEvent>(  (event,emit) async{
      final reply = await _auth.authenticateUser(event.username, event.password);
      if(reply == event.username) {
        emit(SuccessfulLoginState(event.username));
        emit(HomeblocInitial());
        print('Successful Login');
      } else {
        print('Failed Login');
      }
      } 
    );

    on<RegisteringServicesEvent>((event, emit) async{
        await _auth.init();
        await _todo.init();
        emit(HomeblocInitial());
      });
  }
}
