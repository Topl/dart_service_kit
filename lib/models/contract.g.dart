// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContractCollection on Isar {
  IsarCollection<Contract> get contracts => this.collection();
}

const ContractSchema = CollectionSchema(
  name: r'Contract',
  id: 6075293080182411034,
  properties: {
    r'contract': PropertySchema(
      id: 0,
      name: r'contract',
      type: IsarType.string,
    ),
    r'lock': PropertySchema(
      id: 1,
      name: r'lock',
      type: IsarType.string,
    ),
    r'yContract': PropertySchema(
      id: 2,
      name: r'yContract',
      type: IsarType.long,
    )
  },
  estimateSize: _contractEstimateSize,
  serialize: _contractSerialize,
  deserialize: _contractDeserialize,
  deserializeProp: _contractDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _contractGetId,
  getLinks: _contractGetLinks,
  attach: _contractAttach,
  version: '3.1.0+1',
);

int _contractEstimateSize(
  Contract object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contract.length * 3;
  bytesCount += 3 + object.lock.length * 3;
  return bytesCount;
}

void _contractSerialize(
  Contract object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contract);
  writer.writeString(offsets[1], object.lock);
  writer.writeLong(offsets[2], object.yContract);
}

Contract _contractDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Contract(
    contract: reader.readString(offsets[0]),
    lock: reader.readString(offsets[1]),
    yContract: reader.readLong(offsets[2]),
  );
  return object;
}

P _contractDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _contractGetId(Contract object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _contractGetLinks(Contract object) {
  return [];
}

void _contractAttach(IsarCollection<dynamic> col, Id id, Contract object) {}

extension ContractQueryWhereSort on QueryBuilder<Contract, Contract, QWhere> {
  QueryBuilder<Contract, Contract, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ContractQueryWhere on QueryBuilder<Contract, Contract, QWhereClause> {
  QueryBuilder<Contract, Contract, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Contract, Contract, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Contract, Contract, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Contract, Contract, QAfterWhereClause> idBetween(
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

extension ContractQueryFilter
    on QueryBuilder<Contract, Contract, QFilterCondition> {
  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contract',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contract',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contract',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> contractIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contract',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Contract, Contract, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Contract, Contract, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lock',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lock',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lock',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lock',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lock',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lock',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lock',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lock',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lock',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> lockIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lock',
        value: '',
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> yContractEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yContract',
        value: value,
      ));
    });
  }

  QueryBuilder<Contract, Contract, QAfterFilterCondition> yContractGreaterThan(
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

  QueryBuilder<Contract, Contract, QAfterFilterCondition> yContractLessThan(
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

  QueryBuilder<Contract, Contract, QAfterFilterCondition> yContractBetween(
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

extension ContractQueryObject
    on QueryBuilder<Contract, Contract, QFilterCondition> {}

extension ContractQueryLinks
    on QueryBuilder<Contract, Contract, QFilterCondition> {}

extension ContractQuerySortBy on QueryBuilder<Contract, Contract, QSortBy> {
  QueryBuilder<Contract, Contract, QAfterSortBy> sortByContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByLock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lock', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByLockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lock', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> sortByYContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.desc);
    });
  }
}

extension ContractQuerySortThenBy
    on QueryBuilder<Contract, Contract, QSortThenBy> {
  QueryBuilder<Contract, Contract, QAfterSortBy> thenByContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByLock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lock', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByLockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lock', Sort.desc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.asc);
    });
  }

  QueryBuilder<Contract, Contract, QAfterSortBy> thenByYContractDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yContract', Sort.desc);
    });
  }
}

extension ContractQueryWhereDistinct
    on QueryBuilder<Contract, Contract, QDistinct> {
  QueryBuilder<Contract, Contract, QDistinct> distinctByContract(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contract', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contract, Contract, QDistinct> distinctByLock(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lock', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contract, Contract, QDistinct> distinctByYContract() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yContract');
    });
  }
}

extension ContractQueryProperty
    on QueryBuilder<Contract, Contract, QQueryProperty> {
  QueryBuilder<Contract, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Contract, String, QQueryOperations> contractProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contract');
    });
  }

  QueryBuilder<Contract, String, QQueryOperations> lockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lock');
    });
  }

  QueryBuilder<Contract, int, QQueryOperations> yContractProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yContract');
    });
  }
}
