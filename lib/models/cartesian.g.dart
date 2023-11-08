// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartesian.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCartesianCollection on Isar {
  IsarCollection<Cartesian> get cartesians => this.collection();
}

const CartesianSchema = CollectionSchema(
  name: r'Cartesian',
  id: -4330540983636811340,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'lockPredicate': PropertySchema(
      id: 1,
      name: r'lockPredicate',
      type: IsarType.string,
    ),
    r'routine': PropertySchema(
      id: 2,
      name: r'routine',
      type: IsarType.string,
    ),
    r'vk': PropertySchema(
      id: 3,
      name: r'vk',
      type: IsarType.string,
    ),
    r'xFellowship': PropertySchema(
      id: 4,
      name: r'xFellowship',
      type: IsarType.long,
    ),
    r'yContract': PropertySchema(
      id: 5,
      name: r'yContract',
      type: IsarType.long,
    ),
    r'zState': PropertySchema(
      id: 6,
      name: r'zState',
      type: IsarType.long,
    )
  },
  estimateSize: _cartesianEstimateSize,
  serialize: _cartesianSerialize,
  deserialize: _cartesianDeserialize,
  deserializeProp: _cartesianDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _cartesianGetId,
  getLinks: _cartesianGetLinks,
  attach: _cartesianAttach,
  version: '3.1.0+1',
);

int _cartesianEstimateSize(
  Cartesian object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.address.length * 3;
  bytesCount += 3 + object.lockPredicate.length * 3;
  {
    final value = object.routine;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.vk;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cartesianSerialize(
  Cartesian object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.lockPredicate);
  writer.writeString(offsets[2], object.routine);
  writer.writeString(offsets[3], object.vk);
  writer.writeLong(offsets[4], object.xFellowship);
  writer.writeLong(offsets[5], object.yContract);
  writer.writeLong(offsets[6], object.zState);
}

Cartesian _cartesianDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Cartesian(
    address: reader.readString(offsets[0]),
    lockPredicate: reader.readString(offsets[1]),
    routine: reader.readStringOrNull(offsets[2]),
    vk: reader.readStringOrNull(offsets[3]),
    xFellowship: reader.readLong(offsets[4]),
    yContract: reader.readLong(offsets[5]),
    zState: reader.readLong(offsets[6]),
  );
  object.id = id;
  return object;
}

P _cartesianDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cartesianGetId(Cartesian object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cartesianGetLinks(Cartesian object) {
  return [];
}

void _cartesianAttach(IsarCollection<dynamic> col, Id id, Cartesian object) {
  object.id = id;
}

extension CartesianQueryWhereSort
    on QueryBuilder<Cartesian, Cartesian, QWhere> {
  QueryBuilder<Cartesian, Cartesian, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CartesianQueryWhere
    on QueryBuilder<Cartesian, Cartesian, QWhereClause> {
  QueryBuilder<Cartesian, Cartesian, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Cartesian, Cartesian, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterWhereClause> idBetween(
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

extension CartesianQueryFilter
    on QueryBuilder<Cartesian, Cartesian, QFilterCondition> {
  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockPredicate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lockPredicate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lockPredicate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lockPredicate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lockPredicate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lockPredicate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lockPredicate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lockPredicate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockPredicate',
        value: '',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      lockPredicateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lockPredicate',
        value: '',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'routine',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'routine',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routine',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routine',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> routineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routine',
        value: '',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
      routineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routine',
        value: '',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vk',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vk',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vk',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vk',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vk',
        value: '',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> vkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vk',
        value: '',
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> xFellowshipEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xFellowship',
        value: value,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> xFellowshipLessThan(
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> xFellowshipBetween(
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> yContractEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yContract',
        value: value,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition>
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> yContractLessThan(
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> yContractBetween(
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

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> zStateEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zState',
        value: value,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> zStateGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'zState',
        value: value,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> zStateLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'zState',
        value: value,
      ));
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterFilterCondition> zStateBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'zState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CartesianQueryObject
    on QueryBuilder<Cartesian, Cartesian, QFilterCondition> {}

extension CartesianQueryLinks
    on QueryBuilder<Cartesian, Cartesian, QFilterCondition> {}

extension CartesianQuerySortBy on QueryBuilder<Cartesian, Cartesian, QSortBy> {
  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByLockPredicate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockPredicate', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByLockPredicateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockPredicate', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByRoutine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routine', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByRoutineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routine', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByVk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vk', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByVkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vk', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByXFellowship() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByXFellowshipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByYContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByZState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zState', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> sortByZStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zState', Sort.desc);
    });
  }
}

extension CartesianQuerySortThenBy
    on QueryBuilder<Cartesian, Cartesian, QSortThenBy> {
  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByLockPredicate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockPredicate', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByLockPredicateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockPredicate', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByRoutine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routine', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByRoutineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routine', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByVk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vk', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByVkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vk', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByXFellowship() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByXFellowshipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByYContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.desc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByZState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zState', Sort.asc);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QAfterSortBy> thenByZStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zState', Sort.desc);
    });
  }
}

extension CartesianQueryWhereDistinct
    on QueryBuilder<Cartesian, Cartesian, QDistinct> {
  QueryBuilder<Cartesian, Cartesian, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QDistinct> distinctByLockPredicate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lockPredicate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QDistinct> distinctByRoutine(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routine', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QDistinct> distinctByVk(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vk', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cartesian, Cartesian, QDistinct> distinctByXFellowship() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xFellowship');
    });
  }

  QueryBuilder<Cartesian, Cartesian, QDistinct> distinctByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yContract');
    });
  }

  QueryBuilder<Cartesian, Cartesian, QDistinct> distinctByZState() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zState');
    });
  }
}

extension CartesianQueryProperty
    on QueryBuilder<Cartesian, Cartesian, QQueryProperty> {
  QueryBuilder<Cartesian, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Cartesian, String, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<Cartesian, String, QQueryOperations> lockPredicateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lockPredicate');
    });
  }

  QueryBuilder<Cartesian, String?, QQueryOperations> routineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routine');
    });
  }

  QueryBuilder<Cartesian, String?, QQueryOperations> vkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vk');
    });
  }

  QueryBuilder<Cartesian, int, QQueryOperations> xFellowshipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xFellowship');
    });
  }

  QueryBuilder<Cartesian, int, QQueryOperations> yContractProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yContract');
    });
  }

  QueryBuilder<Cartesian, int, QQueryOperations> zStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zState');
    });
  }
}
