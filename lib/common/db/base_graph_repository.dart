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

  String buildFindAllQuery();

  Future<List<T>> findAllEntities() async {
    final query = buildFindAllQuery();
    final Map<String, dynamic>? data = await gateway
        .execute(query: query);

    if (data == null) return [];

    final List<dynamic> jsonList = data[apiKeyRoot] ?? [];
    return jsonList.map(
          (json) =>
          entityFromJson(json as Map<String, dynamic>),
    )
        .toList();
  }
}
