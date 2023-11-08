// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_key.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVerificationKeyCollection on Isar {
  IsarCollection<VerificationKey> get verificationKeys => this.collection();
}

const VerificationKeySchema = CollectionSchema(
  name: r'VerificationKey',
  id: -318903407737022799,
  properties: {
    r'vks': PropertySchema(
      id: 0,
      name: r'vks',
      type: IsarType.string,
    ),
    r'xFellowship': PropertySchema(
      id: 1,
      name: r'xFellowship',
      type: IsarType.long,
    ),
    r'yContract': PropertySchema(
      id: 2,
      name: r'yContract',
      type: IsarType.long,
    )
  },
  estimateSize: _verificationKeyEstimateSize,
  serialize: _verificationKeySerialize,
  deserialize: _verificationKeyDeserialize,
  deserializeProp: _verificationKeyDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _verificationKeyGetId,
  getLinks: _verificationKeyGetLinks,
  attach: _verificationKeyAttach,
  version: '3.1.0+1',
);

int _verificationKeyEstimateSize(
  VerificationKey object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.vks.length * 3;
  return bytesCount;
}

void _verificationKeySerialize(
  VerificationKey object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.vks);
  writer.writeLong(offsets[1], object.xFellowship);
  writer.writeLong(offsets[2], object.yContract);
}

VerificationKey _verificationKeyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VerificationKey(
    vks: reader.readString(offsets[0]),
    xFellowship: reader.readLong(offsets[1]),
    yContract: reader.readLong(offsets[2]),
  );
  object.id = id;
  return object;
}

P _verificationKeyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _verificationKeyGetId(VerificationKey object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _verificationKeyGetLinks(VerificationKey object) {
  return [];
}

void _verificationKeyAttach(
    IsarCollection<dynamic> col, Id id, VerificationKey object) {
  object.id = id;
}

extension VerificationKeyQueryWhereSort
    on QueryBuilder<VerificationKey, VerificationKey, QWhere> {
  QueryBuilder<VerificationKey, VerificationKey, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VerificationKeyQueryWhere
    on QueryBuilder<VerificationKey, VerificationKey, QWhereClause> {
  QueryBuilder<VerificationKey, VerificationKey, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<VerificationKey, VerificationKey, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterWhereClause> idBetween(
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
}

extension VerificationKeyQueryFilter
    on QueryBuilder<VerificationKey, VerificationKey, QFilterCondition> {
  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vks',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vks',
        value: '',
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      vksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vks',
        value: '',
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      xFellowshipEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xFellowship',
        value: value,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      xFellowshipGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xFellowship',
        value: value,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      xFellowshipLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xFellowship',
        value: value,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      xFellowshipBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xFellowship',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      yContractEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yContract',
        value: value,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      yContractGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yContract',
        value: value,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      yContractLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yContract',
        value: value,
      ));
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterFilterCondition>
      yContractBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yContract',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VerificationKeyQueryObject
    on QueryBuilder<VerificationKey, VerificationKey, QFilterCondition> {}

extension VerificationKeyQueryLinks
    on QueryBuilder<VerificationKey, VerificationKey, QFilterCondition> {}

extension VerificationKeyQuerySortBy
    on QueryBuilder<VerificationKey, VerificationKey, QSortBy> {
  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy> sortByVks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vks', Sort.asc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy> sortByVksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vks', Sort.desc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy>
      sortByXFellowship() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.asc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy>
      sortByXFellowshipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.desc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy>
      sortByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.asc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy>
      sortByYContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.desc);
    });
  }
}

extension VerificationKeyQuerySortThenBy
    on QueryBuilder<VerificationKey, VerificationKey, QSortThenBy> {
  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy> thenByVks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vks', Sort.asc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy> thenByVksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vks', Sort.desc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy>
      thenByXFellowship() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.asc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy>
      thenByXFellowshipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.desc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy>
      thenByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.asc);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QAfterSortBy>
      thenByYContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.desc);
    });
  }
}

extension VerificationKeyQueryWhereDistinct
    on QueryBuilder<VerificationKey, VerificationKey, QDistinct> {
  QueryBuilder<VerificationKey, VerificationKey, QDistinct> distinctByVks(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vks', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QDistinct>
      distinctByXFellowship() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xFellowship');
    });
  }

  QueryBuilder<VerificationKey, VerificationKey, QDistinct>
      distinctByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yContract');
    });
  }
}

extension VerificationKeyQueryProperty
    on QueryBuilder<VerificationKey, VerificationKey, QQueryProperty> {
  QueryBuilder<VerificationKey, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VerificationKey, String, QQueryOperations> vksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vks');
    });
  }

  QueryBuilder<VerificationKey, int, QQueryOperations> xFellowshipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xFellowship');
    });
  }

  QueryBuilder<VerificationKey, int, QQueryOperations> yContractProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yContract');
    });
  }
}
