// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWalletFellowshipCollection on Isar {
  IsarCollection<WalletFellowship> get walletFellowships => this.collection();
}

const WalletFellowshipSchema = CollectionSchema(
  name: r'WalletFellowship',
  id: 4566330590929806909,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _walletFellowshipEstimateSize,
  serialize: _walletFellowshipSerialize,
  deserialize: _walletFellowshipDeserialize,
  deserializeProp: _walletFellowshipDeserializeProp,
  idName: r'xIdx',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _walletFellowshipGetId,
  getLinks: _walletFellowshipGetLinks,
  attach: _walletFellowshipAttach,
  version: '3.1.0+1',
);

int _walletFellowshipEstimateSize(
  WalletFellowship object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _walletFellowshipSerialize(
  WalletFellowship object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

WalletFellowship _walletFellowshipDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WalletFellowship(
    id,
    reader.readString(offsets[0]),
  );
  return object;
}

P _walletFellowshipDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _walletFellowshipGetId(WalletFellowship object) {
  return object.xIdx;
}

List<IsarLinkBase<dynamic>> _walletFellowshipGetLinks(WalletFellowship object) {
  return [];
}

void _walletFellowshipAttach(
    IsarCollection<dynamic> col, Id id, WalletFellowship object) {}

extension WalletFellowshipQueryWhereSort
    on QueryBuilder<WalletFellowship, WalletFellowship, QWhere> {
  QueryBuilder<WalletFellowship, WalletFellowship, QAfterWhere> anyXIdx() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WalletFellowshipQueryWhere
    on QueryBuilder<WalletFellowship, WalletFellowship, QWhereClause> {
  QueryBuilder<WalletFellowship, WalletFellowship, QAfterWhereClause>
      xIdxEqualTo(Id xIdx) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: xIdx,
        upper: xIdx,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterWhereClause>
      xIdxNotEqualTo(Id xIdx) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: xIdx, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: xIdx, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: xIdx, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: xIdx, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterWhereClause>
      xIdxGreaterThan(Id xIdx, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: xIdx, includeLower: include),
      );
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterWhereClause>
      xIdxLessThan(Id xIdx, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: xIdx, includeUpper: include),
      );
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterWhereClause>
      xIdxBetween(
    Id lowerXIdx,
    Id upperXIdx, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerXIdx,
        includeLower: includeLower,
        upper: upperXIdx,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WalletFellowshipQueryFilter
    on QueryBuilder<WalletFellowship, WalletFellowship, QFilterCondition> {
  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      xIdxEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xIdx',
        value: value,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      xIdxGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xIdx',
        value: value,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      xIdxLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xIdx',
        value: value,
      ));
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterFilterCondition>
      xIdxBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xIdx',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WalletFellowshipQueryObject
    on QueryBuilder<WalletFellowship, WalletFellowship, QFilterCondition> {}

extension WalletFellowshipQueryLinks
    on QueryBuilder<WalletFellowship, WalletFellowship, QFilterCondition> {}

extension WalletFellowshipQuerySortBy
    on QueryBuilder<WalletFellowship, WalletFellowship, QSortBy> {
  QueryBuilder<WalletFellowship, WalletFellowship, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension WalletFellowshipQuerySortThenBy
    on QueryBuilder<WalletFellowship, WalletFellowship, QSortThenBy> {
  QueryBuilder<WalletFellowship, WalletFellowship, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterSortBy> thenByXIdx() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xIdx', Sort.asc);
    });
  }

  QueryBuilder<WalletFellowship, WalletFellowship, QAfterSortBy>
      thenByXIdxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xIdx', Sort.desc);
    });
  }
}

extension WalletFellowshipQueryWhereDistinct
    on QueryBuilder<WalletFellowship, WalletFellowship, QDistinct> {
  QueryBuilder<WalletFellowship, WalletFellowship, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension WalletFellowshipQueryProperty
    on QueryBuilder<WalletFellowship, WalletFellowship, QQueryProperty> {
  QueryBuilder<WalletFellowship, int, QQueryOperations> xIdxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xIdx');
    });
  }

  QueryBuilder<WalletFellowship, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
