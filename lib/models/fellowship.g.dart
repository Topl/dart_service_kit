// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fellowship.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFellowshipCollection on Isar {
  IsarCollection<Fellowship> get fellowships => this.collection();
}

const FellowshipSchema = CollectionSchema(
  name: r'Fellowship',
  id: -6652192465727830085,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _fellowshipEstimateSize,
  serialize: _fellowshipSerialize,
  deserialize: _fellowshipDeserialize,
  deserializeProp: _fellowshipDeserializeProp,
  idName: r'xFellowship',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _fellowshipGetId,
  getLinks: _fellowshipGetLinks,
  attach: _fellowshipAttach,
  version: '3.1.0+1',
);

int _fellowshipEstimateSize(
  Fellowship object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _fellowshipSerialize(
  Fellowship object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
}

Fellowship _fellowshipDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Fellowship(
    name: reader.readString(offsets[0]),
    xFellowship: id,
  );
  return object;
}

P _fellowshipDeserializeProp<P>(
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

Id _fellowshipGetId(Fellowship object) {
  return object.xFellowship;
}

List<IsarLinkBase<dynamic>> _fellowshipGetLinks(Fellowship object) {
  return [];
}

void _fellowshipAttach(IsarCollection<dynamic> col, Id id, Fellowship object) {}

extension FellowshipQueryWhereSort
    on QueryBuilder<Fellowship, Fellowship, QWhere> {
  QueryBuilder<Fellowship, Fellowship, QAfterWhere> anyXFellowship() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FellowshipQueryWhere
    on QueryBuilder<Fellowship, Fellowship, QWhereClause> {
  QueryBuilder<Fellowship, Fellowship, QAfterWhereClause> xFellowshipEqualTo(
      Id xFellowship) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: xFellowship,
        upper: xFellowship,
      ));
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterWhereClause> xFellowshipNotEqualTo(
      Id xFellowship) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: xFellowship, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: xFellowship, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: xFellowship, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: xFellowship, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterWhereClause>
      xFellowshipGreaterThan(Id xFellowship, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: xFellowship, includeLower: include),
      );
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterWhereClause> xFellowshipLessThan(
      Id xFellowship,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: xFellowship, includeUpper: include),
      );
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterWhereClause> xFellowshipBetween(
    Id lowerXFellowship,
    Id upperXFellowship, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerXFellowship,
        includeLower: includeLower,
        upper: upperXFellowship,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FellowshipQueryFilter
    on QueryBuilder<Fellowship, Fellowship, QFilterCondition> {
  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition>
      xFellowshipEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xFellowship',
        value: value,
      ));
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition>
      xFellowshipGreaterThan(
    Id value, {
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

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition>
      xFellowshipLessThan(
    Id value, {
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

  QueryBuilder<Fellowship, Fellowship, QAfterFilterCondition>
      xFellowshipBetween(
    Id lower,
    Id upper, {
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
}

extension FellowshipQueryObject
    on QueryBuilder<Fellowship, Fellowship, QFilterCondition> {}

extension FellowshipQueryLinks
    on QueryBuilder<Fellowship, Fellowship, QFilterCondition> {}

extension FellowshipQuerySortBy
    on QueryBuilder<Fellowship, Fellowship, QSortBy> {
  QueryBuilder<Fellowship, Fellowship, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FellowshipQuerySortThenBy
    on QueryBuilder<Fellowship, Fellowship, QSortThenBy> {
  QueryBuilder<Fellowship, Fellowship, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterSortBy> thenByXFellowship() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.asc);
    });
  }

  QueryBuilder<Fellowship, Fellowship, QAfterSortBy> thenByXFellowshipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xFellowship', Sort.desc);
    });
  }
}

extension FellowshipQueryWhereDistinct
    on QueryBuilder<Fellowship, Fellowship, QDistinct> {
  QueryBuilder<Fellowship, Fellowship, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension FellowshipQueryProperty
    on QueryBuilder<Fellowship, Fellowship, QQueryProperty> {
  QueryBuilder<Fellowship, int, QQueryOperations> xFellowshipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xFellowship');
    });
  }

  QueryBuilder<Fellowship, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
