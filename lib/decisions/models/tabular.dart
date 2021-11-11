import 'dart:convert';

import 'package:flutter/foundation.dart';

class Tabular {
  final int tabularId;
  final String title;
  final List<String> cols;
  final List<String> rows;
  final Map<String, String> colsData;
  final Map<String, String> rowsData;
  Tabular({
    required this.tabularId,
    required this.title,
    required this.cols,
    required this.rows,
    required this.colsData,
    required this.rowsData,
  });

  Tabular copyWith({
    int? tabularId,
    String? title,
    List<String>? cols,
    List<String>? rows,
    Map<String, String>? colsData,
    Map<String, String>? rowsData,
  }) {
    return Tabular(
      tabularId: tabularId ?? this.tabularId,
      title: title ?? this.title,
      cols: cols ?? this.cols,
      rows: rows ?? this.rows,
      colsData: colsData ?? this.colsData,
      rowsData: rowsData ?? this.rowsData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tabularId': tabularId,
      'title': title,
      'cols': cols.join(","),
      'rows': rows.join(","),
      'colsData':
          colsData.entries.map((e) => e.key + ":" + e.value + ",").toString(),
      'rowsData':
          rowsData.entries.map((e) => e.key + ":" + e.value + ",").toString(),
    };
  }

  factory Tabular.fromMap(Map<String, dynamic> map) {
    return Tabular(
      tabularId: map['tabularId'],
      title: map['title'],
      cols: map['cols'].split(","),
      rows: map['rows'].split(","),
      colsData: Map<String, String>.from(map['colsData'].split(",")),
      rowsData: Map<String, String>.from(map['rowsData'].split(",")),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tabular.fromJson(String source) =>
      Tabular.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tabular(tabularId: $tabularId, title: $title, cols: $cols, rows: $rows, colsData: $colsData, rowsData: $rowsData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tabular &&
        other.tabularId == tabularId &&
        other.title == title &&
        listEquals(other.cols, cols) &&
        listEquals(other.rows, rows) &&
        mapEquals(other.colsData, colsData) &&
        mapEquals(other.rowsData, rowsData);
  }

  @override
  int get hashCode {
    return tabularId.hashCode ^
        title.hashCode ^
        cols.hashCode ^
        rows.hashCode ^
        colsData.hashCode ^
        rowsData.hashCode;
  }
}
