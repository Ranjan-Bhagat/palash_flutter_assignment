import 'dart:convert';

import 'photo_model.dart';

class SearchPhotoModel {
    SearchPhotoModel({
        required this.totalResults,
        required this.page,
        required this.perPage,
        required this.photos,
        this.nextPage,
        this.prevPage,
    });

    final int totalResults;
    final int page;
    final int perPage;
    final List<PhotoModel> photos;
    final String? nextPage;
    final String? prevPage;

    factory SearchPhotoModel.fromJson(String str) => SearchPhotoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchPhotoModel.fromMap(Map<String, dynamic> map) => SearchPhotoModel(
        totalResults: map["total_results"],
        page: map["page"],
        perPage: map["per_page"],
        photos: List<PhotoModel>.from(map["photos"].map((x) => PhotoModel.fromMap(x))),
        nextPage: map["next_page"],
        prevPage: map["prev_page"],
    );

    Map<String, dynamic> toMap() => {
        "total_results": totalResults,
        "page": page,
        "per_page": perPage,
        "photos": List<dynamic>.from(photos.map((x) => x.toMap())),
        "next_page": nextPage,
        "prev_page": prevPage,
    };
}