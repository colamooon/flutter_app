import 'package:equatable/equatable.dart';

abstract class HomeMainEvent extends Equatable {
  const HomeMainEvent();

  @override
  List<Object> get props => [];
}

class HomeMainsLoad extends HomeMainEvent {
  @override
  String toString() => 'HomeMainsLoad';
}
