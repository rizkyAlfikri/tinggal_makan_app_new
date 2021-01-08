
import 'package:equatable/equatable.dart';

abstract class RestaurantState<Type> extends Equatable{
  @override
  List<Object> get props => [];
}

class Empty extends RestaurantState{}

class Loading extends RestaurantState{}

class HasData<Type> extends RestaurantState{
  final Type data;

  HasData({this.data});
}

class Error extends RestaurantState{
  final String message;

  Error({this.message});
}