import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'user_preferences_model.g.dart';

@Collection()
class IsarUserPreferencesModel {
  IsarUserPreferencesModel({
    required this.themeMode,
    required this.locale,
    required this.isSystemLocale,
  });

  final Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  final String tokenID = 'user_preferences_id';

  @enumerated
  final ThemeMode themeMode;

  final String locale;

  final bool isSystemLocale;

  IsarUserPreferencesModel copyWith({
    ThemeMode? themeMode,
    String? locale,
    bool? isSystemLocale,
  }) {
    return IsarUserPreferencesModel(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      isSystemLocale: isSystemLocale ?? this.isSystemLocale,
    );
  }
}
