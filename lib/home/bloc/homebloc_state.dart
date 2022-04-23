part of 'homebloc_bloc.dart';

abstract class HomeblocState extends Equatable {
  const HomeblocState();
  
}

class HomeblocInitial extends HomeblocState {

  final bool? success;

  HomeblocInitial({this.success});
    @override
  List<Object?> get props => [success];
}
