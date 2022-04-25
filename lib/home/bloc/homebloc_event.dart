part of 'homebloc_bloc.dart';

abstract class HomeblocEvent extends Equatable {
  const HomeblocEvent();

}

class LoginEvent extends HomeblocEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);

  @override
  List<Object?> get props => [username,password];

}

class RegisteringServicesEvent extends HomeblocEvent {

  const RegisteringServicesEvent();

  @override
  List<Object?> get props => [];
}