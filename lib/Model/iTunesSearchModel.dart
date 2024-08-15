// To parse this JSON data, do
//
//     final iTunes = iTunesFromJson(jsonString);

import 'dart:convert';

ITunes iTunesFromJson(String str) => ITunes.fromJson(json.decode(str));

String iTunesToJson(ITunes data) => json.encode(data.toJson());

class ITunes {
  int resultCount = 0;
  List<Result> results;

  ITunes({
    required this.resultCount,
    required this.results,
  });

  factory ITunes.fromJson(Map<String, dynamic> json) => ITunes(
        resultCount: json["resultCount"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCount": resultCount,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String? wrapperType;
  String? kind;
  int? artistId;
  int? collectionId;
  int? trackId;
  String? artistName;
  String? collectionName;
  String? trackName;
  String? collectionCensoredName;
  String? trackCensoredName;
  String? artistViewUrl;
  String? collectionViewUrl;
  String? trackViewUrl;
  String? previewUrl;
  String? artworkUrl30;
  String? artworkUrl60;
  String? artworkUrl100;
  double? collectionPrice;
  double? trackPrice;
  DateTime? releaseDate;
  String? collectionExplicitness;
  String? trackExplicitness;
  int? discCount;
  int? discNumber;
  int? trackCount;
  int? trackNumber;
  int? trackTimeMillis;
  String? country;
  String? currency;
  String? primaryGenreName;
  bool? isStreamable;
  String? longDescription;

  Result(
      {this.wrapperType,
      this.kind,
      this.artistId,
      this.collectionId,
      this.trackId,
      this.artistName,
      this.collectionName,
      this.trackName,
      this.collectionCensoredName,
      this.trackCensoredName,
      this.artistViewUrl,
      this.collectionViewUrl,
      this.trackViewUrl,
      this.previewUrl,
      this.artworkUrl30,
      this.artworkUrl60,
      this.artworkUrl100,
      this.collectionPrice,
      this.trackPrice,
      this.releaseDate,
      this.collectionExplicitness,
      this.trackExplicitness,
      this.discCount,
      this.discNumber,
      this.trackCount,
      this.trackNumber,
      this.trackTimeMillis,
      this.country,
      this.currency,
      this.primaryGenreName,
      this.isStreamable,
      this.longDescription});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      wrapperType: json["wrapperType"] ?? "",
      kind: json["kind"] ?? "",
      artistId: json["artistId"],
      collectionId: json["collectionId"],
      trackId: json["trackId"],
      artistName: json["artistName"] ?? "",
      collectionName: json["collectionName"] ?? "",
      trackName: json["trackName"] ?? "",
      collectionCensoredName: json["collectionCensoredName"] ?? "",
      trackCensoredName: json["trackCensoredName"] ?? "",
      artistViewUrl: json["artistViewUrl"] ?? "",
      collectionViewUrl: json["collectionViewUrl"] ?? "",
      trackViewUrl: json["trackViewUrl"] ?? "",
      previewUrl: json["previewUrl"] ?? "",
      artworkUrl30: json["artworkUrl30"] ?? "",
      artworkUrl60: json["artworkUrl60"] ?? "",
      artworkUrl100: json["artworkUrl100"] ?? "",
      collectionPrice: json["collectionPrice"]?.toDouble(),
      trackPrice: json["trackPrice"]?.toDouble(),
      releaseDate: DateTime.parse(json["releaseDate"]),
      collectionExplicitness: json["collectionExplicitness"] ?? "",
      trackExplicitness: json["trackExplicitness"] ?? "",
      discCount: json["discCount"],
      discNumber: json["discNumber"],
      trackCount: json["trackCount"],
      trackNumber: json["trackNumber"],
      trackTimeMillis: json["trackTimeMillis"],
      country: json["country"] ?? "",
      currency: json["currency"] ?? "",
      primaryGenreName: json["primaryGenreName"] ?? "",
      isStreamable: json["isStreamable"],
      longDescription: json["longDescription"] ?? "");

  Map<String, dynamic> toJson() => {
        "wrapperType": wrapperType,
        "kind": kind,
        "artistId": artistId,
        "collectionId": collectionId,
        "trackId": trackId,
        "artistName": artistName,
        "collectionName": collectionName,
        "trackName": trackName,
        "collectionCensoredName": collectionCensoredName,
        "trackCensoredName": trackCensoredName,
        "artistViewUrl": artistViewUrl,
        "collectionViewUrl": collectionViewUrl,
        "trackViewUrl": trackViewUrl,
        "previewUrl": previewUrl,
        "artworkUrl30": artworkUrl30,
        "artworkUrl60": artworkUrl60,
        "artworkUrl100": artworkUrl100,
        "collectionPrice": collectionPrice,
        "trackPrice": trackPrice,
        "releaseDate": releaseDate,
        "collectionExplicitness": collectionExplicitness,
        "trackExplicitness": trackExplicitness,
        "discCount": discCount,
        "discNumber": discNumber,
        "trackCount": trackCount,
        "trackNumber": trackNumber,
        "trackTimeMillis": trackTimeMillis,
        "country": country,
        "currency": currency,
        "primaryGenreName": primaryGenreName,
        "isStreamable": isStreamable,
        "longDescription": longDescription
      };
}
