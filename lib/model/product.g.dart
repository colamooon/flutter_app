// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    name: json['name'] as String,
    modelName: json['modelName'] as String,
    modelNum: json['modelNum'] as String,
    originalPrice: (json['originalPrice'] as num)?.toDouble(),
    stok: json['stok'] as int,
    mediaCollections: (json['mediaCollections'] as List)
        ?.map((e) => e == null
            ? null
            : MediaCollection.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'modelName': instance.modelName,
      'modelNum': instance.modelNum,
      'originalPrice': instance.originalPrice,
      'stok': instance.stok,
      'mediaCollections':
          instance.mediaCollections?.map((e) => e?.toJson())?.toList(),
    };
