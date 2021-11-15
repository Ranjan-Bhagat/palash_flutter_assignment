
import 'dart:convert';

class SrcModel {
    SrcModel({
        required this.original,
        required this.large2X,
        required this.large,
        required this.medium,
        required this.small,
        required this.portrait,
        required this.landscape,
        required this.tiny,
    });

    final String original;
    final String large2X;
    final String large;
    final String medium;
    final String small;
    final String portrait;
    final String landscape;
    final String tiny;

    factory SrcModel.fromJson(String str) => SrcModel.fromMap(jsonDecode(str));

    String toJson() => jsonEncode(toMap());

    factory SrcModel.fromMap(Map<String, dynamic> map) => SrcModel(
        original: map["original"],
        large2X: map["large2x"],
        large: map["large"],
        medium: map["medium"],
        small: map["small"],
        portrait: map["portrait"],
        landscape: map["landscape"],
        tiny: map["tiny"],
    );

    Map<String, dynamic> toMap() => {
        "original": original,
        "large2x": large2X,
        "large": large,
        "medium": medium,
        "small": small,
        "portrait": portrait,
        "landscape": landscape,
        "tiny": tiny,
    };
}
