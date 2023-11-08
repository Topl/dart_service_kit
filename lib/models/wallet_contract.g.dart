// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_contract.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWalletContractCollection on Isar {
  IsarCollection<WalletContract> get walletContracts => this.collection();
}

const WalletContractSchema = CollectionSchema(
  name: r'WalletContract',
  id: -8766292311798292250,
  properties: {
    r'lockTemplate': PropertySchema(
      id: 0,
      name: r'lockTemplate',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _walletContractEstimateSize,
  serialize: _walletContractSerialize,
  deserialize: _walletContractDeserialize,
  deserializeProp: _walletContractDeserializeProp,
  idName: r'yIdx',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _walletContractGetId,
  getLinks: _walletContractGetLinks,
  attach: _walletContractAttach,
  version: '3.1.0+1',
);

int _walletContractEstimateSize(
  WalletContract object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.lockTemplate.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _walletContractSerialize(
  WalletContract object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.lockTemplate);
  writer.writeString(offsets[1], object.name);
}

WalletContract _walletContractDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WalletContract(
    id,
    reader.readString(offsets[1]),
    reader.readString(offsets[0]),
  );
  return object;
}

P _walletContractDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _walletContractGetId(WalletContract object) {
  return object.yIdx;
}

List<IsarLinkBase<dynamic>> _walletContractGetLinks(WalletContract object) {
  return [];
}

void _walletContractAttach(
    IsarCollection<dynamic> col, Id id, WalletContract object) {}

extension WalletContractQueryWhereSort
    on QueryBuilder<WalletContract, WalletContract, QWhere> {
  QueryBuilder<WalletContract, WalletContract, QAfterWhere> anyYIdx() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WalletContractQueryWhere
    on QueryBuilder<WalletContract, WalletContract, QWhereClause> {
  QueryBuilder<WalletContract, WalletContract, QAfterWhereClause> yIdxEqualTo(
      Id yIdx) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: yIdx,
        upper: yIdx,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterWhereClause>
      yIdxNotEqualTo(Id yIdx) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: yIdx, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: yIdx, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: yIdx, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: yIdx, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterWhereClause>
      yIdxGreaterThan(Id yIdx, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: yIdx, includeLower: include),
      );
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterWhereClause> yIdxLessThan(
      Id yIdx,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: yIdx, includeUpper: include),
      );
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterWhereClause> yIdxBetween(
    Id lowerYIdx,
    Id upperYIdx, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerYIdx,
        includeLower: includeLower,
        upper: upperYIdx,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WalletContractQueryFilter
    on QueryBuilder<WalletContract, WalletContract, QFilterCondition> {
  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockTemplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lockTemplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lockTemplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lockTemplate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lockTemplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lockTemplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lockTemplate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lockTemplate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lockTemplate',
        value: '',
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      lockTemplateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lockTemplate',
        value: '',
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
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

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
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

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
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

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
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

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
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

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
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

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      yIdxEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yIdx',
        value: value,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      yIdxGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yIdx',
        value: value,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      yIdxLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yIdx',
        value: value,
      ));
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterFilterCondition>
      yIdxBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yIdx',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WalletContractQueryObject
    on QueryBuilder<WalletContract, WalletContract, QFilterCondition> {}

extension WalletContractQueryLinks
    on QueryBuilder<WalletContract, WalletContract, QFilterCondition> {}

extension WalletContractQuerySortBy
    on QueryBuilder<WalletContract, WalletContract, QSortBy> {
  QueryBuilder<WalletContract, WalletContract, QAfterSortBy>
      sortByLockTemplate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockTemplate', Sort.asc);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterSortBy>
      sortByLockTemplateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockTemplate', Sort.desc);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension WalletContractQuerySortThenBy
    on QueryBuilder<WalletContract, WalletContract, QSortThenBy> {
  QueryBuilder<WalletContract, WalletContract, QAfterSortBy>
      thenByLockTemplate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockTemplate', Sort.asc);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterSortBy>
      thenByLockTemplateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lockTemplate', Sort.desc);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterSortBy> thenByYIdx() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yIdx', Sort.asc);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QAfterSortBy> thenByYIdxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yIdx', Sort.desc);
    });
  }
}

extension WalletContractQueryWhereDistinct
    on QueryBuilder<WalletContract, WalletContract, QDistinct> {
  QueryBuilder<WalletContract, WalletContract, QDistinct>
      distinctByLockTemplate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lockTemplate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WalletContract, WalletContract, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension WalletContractQueryProperty
    on QueryBuilder<WalletContract, WalletContract, QQueryProperty> {
  QueryBuilder<WalletContract, int, QQueryOperations> yIdxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yIdx');
    });
  }

  QueryBuilder<WalletContract, String, QQueryOperations>
      lockTemplateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lockTemplate');
    });
  }

  QueryBuilder<WalletContract, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
