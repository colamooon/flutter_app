import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mediaCollection.g.dart';

@JsonSerializable(nullable: true)
class MediaCollection extends Equatable {
  final int id;
  final String collectionUuid; //미디어 RandomStringUtils
  final String originName; //원본파일명
  final String modifyName; //수정파일명
  final String mediaType; //0.이미지 1.유투브 2. 비메오
  final String path; //경로aws 웹경로 (폴더명)
  final String fullPathS3; //전체패스
  final String fullPath; //전체패스
  final String fullPathSmall; //전체패스
  final String fullPathMedium; //전체패스
  final String fullPathReduce; //전체패스
  final String imageExt; //확장자
  final int sortPosition; //순서
  final int isFirst; //대표이미지인지 여부

  const MediaCollection({
    this.id,
    this.collectionUuid,
    this.originName,
    this.modifyName,
    this.mediaType,
    this.path,
    this.fullPathS3,
    this.fullPath,
    this.fullPathSmall,
    this.fullPathMedium,
    this.fullPathReduce,
    this.imageExt,
    this.sortPosition,
    this.isFirst,
  });

  factory MediaCollection.fromJson(Map<String, dynamic> json) => _$MediaCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$MediaCollectionToJson(this);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'MediaCollection { id: $id }';
}
