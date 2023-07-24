// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarUserPreferencesModelCollection on Isar {
  IsarCollection<IsarUserPreferencesModel> get isarUserPreferencesModels => this.collection();
}

const IsarUserPreferencesModelSchema = CollectionSchema(
  name: r'IsarUserPreferencesModel',
  id: -3660505093798158225,
  properties: {
    r'isSystemLocale': PropertySchema(
      id: 0,
      name: r'isSystemLocale',
      type: IsarType.bool,
    ),
    r'locale': PropertySchema(
      id: 1,
      name: r'locale',
      type: IsarType.string,
    ),
    r'themeMode': PropertySchema(
      id: 2,
      name: r'themeMode',
      type: IsarType.byte,
      enumMap: _IsarUserPreferencesModelthemeModeEnumValueMap,
    ),
    r'tokenID': PropertySchema(
      id: 3,
      name: r'tokenID',
      type: IsarType.string,
    )
  },
  estimateSize: _isarUserPreferencesModelEstimateSize,
  serialize: _isarUserPreferencesModelSerialize,
  deserialize: _isarUserPreferencesModelDeserialize,
  deserializeProp: _isarUserPreferencesModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'tokenID': IndexSchema(
      id: -2224915758113008339,
      name: r'tokenID',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'tokenID',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarUserPreferencesModelGetId,
  getLinks: _isarUserPreferencesModelGetLinks,
  attach: _isarUserPreferencesModelAttach,
  version: '3.1.0+1',
);

int _isarUserPreferencesModelEstimateSize(
  IsarUserPreferencesModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.locale.length * 3;
  bytesCount += 3 + object.tokenID.length * 3;
  return bytesCount;
}

void _isarUserPreferencesModelSerialize(
  IsarUserPreferencesModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer
    ..writeBool(offsets[0], object.isSystemLocale)
    ..writeString(offsets[1], object.locale)
    ..writeByte(offsets[2], object.themeMode.index)
    ..writeString(offsets[3], object.tokenID);
}

IsarUserPreferencesModel _isarUserPreferencesModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarUserPreferencesModel(
    isSystemLocale: reader.readBool(offsets[0]),
    locale: reader.readString(offsets[1]),
    themeMode: _IsarUserPreferencesModelthemeModeValueEnumMap[reader.readByteOrNull(offsets[2])] ?? ThemeMode.system,
  );
  return object;
}

P _isarUserPreferencesModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (_IsarUserPreferencesModelthemeModeValueEnumMap[reader.readByteOrNull(offset)] ?? ThemeMode.system) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarUserPreferencesModelthemeModeEnumValueMap = {
  'system': 0,
  'light': 1,
  'dark': 2,
};
const _IsarUserPreferencesModelthemeModeValueEnumMap = {
  0: ThemeMode.system,
  1: ThemeMode.light,
  2: ThemeMode.dark,
};

Id _isarUserPreferencesModelGetId(IsarUserPreferencesModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarUserPreferencesModelGetLinks(IsarUserPreferencesModel object) {
  return [];
}

void _isarUserPreferencesModelAttach(IsarCollection<dynamic> col, Id id, IsarUserPreferencesModel object) {}

extension IsarUserPreferencesModelByIndex on IsarCollection<IsarUserPreferencesModel> {
  Future<IsarUserPreferencesModel?> getByTokenID(String tokenID) {
    return getByIndex(r'tokenID', [tokenID]);
  }

  IsarUserPreferencesModel? getByTokenIDSync(String tokenID) {
    return getByIndexSync(r'tokenID', [tokenID]);
  }

  Future<bool> deleteByTokenID(String tokenID) {
    return deleteByIndex(r'tokenID', [tokenID]);
  }

  bool deleteByTokenIDSync(String tokenID) {
    return deleteByIndexSync(r'tokenID', [tokenID]);
  }

  Future<List<IsarUserPreferencesModel?>> getAllByTokenID(List<String> tokenIDValues) {
    final values = tokenIDValues.map((e) => [e]).toList();
    return getAllByIndex(r'tokenID', values);
  }

  List<IsarUserPreferencesModel?> getAllByTokenIDSync(List<String> tokenIDValues) {
    final values = tokenIDValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'tokenID', values);
  }

  Future<int> deleteAllByTokenID(List<String> tokenIDValues) {
    final values = tokenIDValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'tokenID', values);
  }

  int deleteAllByTokenIDSync(List<String> tokenIDValues) {
    final values = tokenIDValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'tokenID', values);
  }

  Future<Id> putByTokenID(IsarUserPreferencesModel object) {
    return putByIndex(r'tokenID', object);
  }

  Id putByTokenIDSync(IsarUserPreferencesModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'tokenID', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTokenID(List<IsarUserPreferencesModel> objects) {
    return putAllByIndex(r'tokenID', objects);
  }

  List<Id> putAllByTokenIDSync(List<IsarUserPreferencesModel> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'tokenID', objects, saveLinks: saveLinks);
  }
}

extension IsarUserPreferencesModelQueryWhereSort
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QWhere> {
  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarUserPreferencesModelQueryWhere
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QWhereClause> {
  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterWhereClause> tokenIDEqualTo(String tokenID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tokenID',
        value: [tokenID],
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterWhereClause> tokenIDNotEqualTo(
      String tokenID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tokenID',
              lower: [],
              upper: [tokenID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tokenID',
              lower: [tokenID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tokenID',
              lower: [tokenID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tokenID',
              lower: [],
              upper: [tokenID],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarUserPreferencesModelQueryFilter
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QFilterCondition> {
  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> isSystemLocaleEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystemLocale',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locale',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locale',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> localeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> themeModeEqualTo(
      ThemeMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> themeModeGreaterThan(
    ThemeMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> themeModeLessThan(
    ThemeMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> themeModeBetween(
    ThemeMode lower,
    ThemeMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokenID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tokenID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tokenID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tokenID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tokenID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tokenID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tokenID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tokenID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokenID',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterFilterCondition> tokenIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tokenID',
        value: '',
      ));
    });
  }
}

extension IsarUserPreferencesModelQueryObject
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QFilterCondition> {}

extension IsarUserPreferencesModelQueryLinks
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QFilterCondition> {}

extension IsarUserPreferencesModelQuerySortBy
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QSortBy> {
  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> sortByIsSystemLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemLocale', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> sortByIsSystemLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemLocale', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> sortByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> sortByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> sortByTokenID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenID', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> sortByTokenIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenID', Sort.desc);
    });
  }
}

extension IsarUserPreferencesModelQuerySortThenBy
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QSortThenBy> {
  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByIsSystemLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemLocale', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByIsSystemLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemLocale', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByTokenID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenID', Sort.asc);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QAfterSortBy> thenByTokenIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenID', Sort.desc);
    });
  }
}

extension IsarUserPreferencesModelQueryWhereDistinct
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QDistinct> {
  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QDistinct> distinctByIsSystemLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystemLocale');
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QDistinct> distinctByLocale(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locale', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QDistinct> distinctByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode');
    });
  }

  QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QDistinct> distinctByTokenID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tokenID', caseSensitive: caseSensitive);
    });
  }
}

extension IsarUserPreferencesModelQueryProperty
    on QueryBuilder<IsarUserPreferencesModel, IsarUserPreferencesModel, QQueryProperty> {
  QueryBuilder<IsarUserPreferencesModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarUserPreferencesModel, bool, QQueryOperations> isSystemLocaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystemLocale');
    });
  }

  QueryBuilder<IsarUserPreferencesModel, String, QQueryOperations> localeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locale');
    });
  }

  QueryBuilder<IsarUserPreferencesModel, ThemeMode, QQueryOperations> themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }

  QueryBuilder<IsarUserPreferencesModel, String, QQueryOperations> tokenIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tokenID');
    });
  }
}
