part of 'homebloc_bloc.dart';

abstract class HomeblocState extends Equatable {
  const HomeblocState();
}

class HomeblocInitial extends HomeblocState {  
  const HomeblocInitial();
    @override
  List<Object?> get props => [];
}

class SuccessfulLoginState extends HomeblocState {

  final String username;

  const SuccessfulLoginState(this.username);
    @override
  List<Object?> get props => [username];
}

class RegisteringServicesState extends HomeblocState {

  const RegisteringServicesState();

  @override
  List<Object?> get props => [];
}
