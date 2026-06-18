import 'package:canya_mobile/common/data/navigable_summary.dart';
import 'package:canya_mobile/common/data/relationship_group.dart';
import 'package:loggy/loggy.dart';

import 'graph_gateway.dart';

abstract class BaseGraphRepository<T> with UiLoggy {
  final GraphGateway gateway;
  final String apiKeyRoot;

  BaseGraphRepository({
    required this.gateway,
    required this.apiKeyRoot,
  });

  T entityFromJson(Map<String, dynamic> json);

  T copyWithNodes(T entity, List<RelationshipGroup> nodes);

  String get entityTypeName;

  String get coreFieldsFragment => ''' 
      id, title, subtitle
      ''';

  String buildFindAllQuery() => _findAllQuery;

  String buildFindByIdQuery(
    List<RelationshipType> relations,
  );

  String get _findAllQuery =>
      '''
    query GetAll${entityTypeName}Summary {
      $apiKeyRoot(options: { sort: [{ title: ASC }] }) {
        $coreFieldsFragment
      } 
    }
  ''';

  Future<List<T>> findAllEntities() async {
    loggy.debug(
      'finding all entities of type $entityTypeName',
    );
    final query = buildFindAllQuery();

    final Map<String, dynamic>? data = await gateway
        .execute(query: query);

    if (data == null) return [];

    final List<dynamic> jsonList = data[apiKeyRoot] ?? [];
    return jsonList
        .map(
          (json) =>
              entityFromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<T?> findEntityById(
    String id, {
    List<RelationshipType> fetchRelations = const [],
  }) async {
    loggy.debug(
      'finding entity $entityTypeName and '
      'related nodes $fetchRelations',
    );
    final query = _compileFindByIdQuery(fetchRelations);
    final Map<String, dynamic>? data = await gateway
        .execute(query: query, vars: {'id': id});

    if (data == null) return null;
    final List<dynamic> jsonList = data[apiKeyRoot] ?? [];
    if (jsonList.isEmpty) return null;

    final Map<String, dynamic> rootJson = jsonList.first;
    T entity = entityFromJson(rootJson);

    final List<RelationshipGroup> relations = [];
    for (final r in fetchRelations) {
      final List<dynamic>? found = rootJson[r.graphQlField];
      if (found == null) continue;
      final nodes = found
          .map((json) => NavigableSummary.fromJson(json))
          .toList();
      relations.add(
        RelationshipGroup(type: r, nodes: nodes),
      );
    }

    return copyWithNodes(entity, relations);
  }

  String _compileFindByIdQuery(
    List<RelationshipType> relations,
  ) {
    final String relationFields = relations
        .map(
          (r) =>
              '''
      ${r.graphQlField} {
        id
        title
        subtitle
      }
    ''',
        )
        .join('\n');

    return '''
      query Get${entityTypeName}ById(\$id: ID!) {
        $apiKeyRoot(where: { id: \$id }) {
          $coreFieldsFragment
          $relationFields
        }
      }
    ''';
  }
}
