import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductsLoad extends ProductEvent {
  @override
  String toString() => 'ProductsLoad';
}
