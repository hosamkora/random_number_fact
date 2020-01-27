// To parse this JSON data, do
//
//     final numberData = numberDataFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class NumberData {
  final String text;
  final int year;
  final int number;
  final bool found;
  final String type;

  NumberData({
    @required this.text,
    @required this.year,
    @required this.number,
    @required this.found,
    @required this.type,
  });

  NumberData copyWith({
    String text,
    int year,
    int number,
    bool found,
    String type,
  }) =>
      NumberData(
        text: text ?? this.text,
        year: year ?? this.year,
        number: number ?? this.number,
        found: found ?? this.found,
        type: type ?? this.type,
      );

  factory NumberData.fromRawJson(String str) =>
      NumberData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NumberData.fromJson(Map<String, dynamic> json) => NumberData(
        text: json["text"] == null ? null : json["text"],
        year: json["year"] == null ? null : json["year"],
        number: json["number"] == null ? null : json["number"],
        found: json["found"] == null ? null : json["found"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "year": year == null ? null : year,
        "number": number == null ? null : number,
        "found": found == null ? null : found,
        "type": type == null ? null : type,
      };
}
