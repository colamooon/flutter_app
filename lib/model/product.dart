import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'mediaCollection.dart';

part 'product.g.dart';

@JsonSerializable(nullable: true, explicitToJson: true)
class Product extends Equatable {
  final int id;

  final String name;
  final String modelName;
  final String modelNum;
  final double originalPrice;
  final int stok;
  final List<MediaCollection> mediaCollections;

  const Product({
    this.id,
    this.name,
    this.modelName,
    this.modelNum,
    this.originalPrice,
    this.stok,
    this.mediaCollections,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Product { id: $id }';
}
