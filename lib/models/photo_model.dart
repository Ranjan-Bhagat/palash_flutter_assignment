import 'dart:convert';

import 'src_model.dart';

class PhotoModel {
    PhotoModel({
        required this.id,
        required this.width,
        required this.height,
        required this.url,
        required this.photographer,
        required this.photographerUrl,
        required this.photographerId,
        required this.avgColor,
        required this.src,
    });

    final int id;
    final int width;
    final int height;
    final String url;
    final String photographer;
    final String photographerUrl;
    final int photographerId;
    final String avgColor;
    final SrcModel src;

    factory PhotoModel.fromJson(String str) => PhotoModel.fromMap(jsonDecode(str));

    String toJson() => jsonEncode(toMap());

    factory PhotoModel.fromMap(Map<String, dynamic> map) => PhotoModel(
        id: map["id"],
        width: map["width"],
        height: map["height"],
        url: map["url"],
        photographer: map["photographer"],
        photographerUrl: map["photographer_url"],
        photographerId: map["photographer_id"],
        avgColor: map["avg_color"],
        src: SrcModel.fromMap(map["src"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "photographer_id": photographerId,
        "avg_color": avgColor,
        "src": src.toMap(),
    };
}
