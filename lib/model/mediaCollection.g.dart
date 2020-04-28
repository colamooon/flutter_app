// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mediaCollection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaCollection _$MediaCollectionFromJson(Map<String, dynamic> json) {
  return MediaCollection(
    id: json['id'] as int,
    collectionUuid: json['collectionUuid'] as String,
    originName: json['originName'] as String,
    modifyName: json['modifyName'] as String,
    mediaType: json['mediaType'] as String,
    path: json['path'] as String,
    fullPathS3: json['fullPathS3'] as String,
    fullPath: json['fullPath'] as String,
    fullPathSmall: json['fullPathSmall'] as String,
    fullPathMedium: json['fullPathMedium'] as String,
    fullPathReduce: json['fullPathReduce'] as String,
    imageExt: json['imageExt'] as String,
    sortPosition: json['sortPosition'] as int,
    isFirst: json['isFirst'] as int,
  );
}

Map<String, dynamic> _$MediaCollectionToJson(MediaCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionUuid': instance.collectionUuid,
      'originName': instance.originName,
      'modifyName': instance.modifyName,
      'mediaType': instance.mediaType,
      'path': instance.path,
      'fullPathS3': instance.fullPathS3,
      'fullPath': instance.fullPath,
      'fullPathSmall': instance.fullPathSmall,
      'fullPathMedium': instance.fullPathMedium,
      'fullPathReduce': instance.fullPathReduce,
      'imageExt': instance.imageExt,
      'sortPosition': instance.sortPosition,
      'isFirst': instance.isFirst,
    };
