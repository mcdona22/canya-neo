import 'dart:convert';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';

const jsonContentType = 'application/json';

class GraphGateway with UiLoggy {
  final String uri;

  GraphGateway({required this.uri});

  String echo(String s) {
    loggy.debug('echoing "$s"');
    return s;
  }

  Future<Map<String, dynamic>>? execute({
    required String query,
    Map<String, dynamic>? vars,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': jsonContentType,
          'Accept': jsonContentType,
        },
        body: jsonEncode({
          'query': query,
          if (vars != null) 'variables': vars,
        }),
      );

      if (response.statusCode != HttpStatus.ok) {
        final msg =
            'Network transport failure. HTTP Status: ${response.statusCode}';
        loggy.warning(msg);
        throw GraphQLException(msg);
      }

      final Map<String, dynamic> body = jsonDecode(
        response.body,
      );
      if (body.containsKey('errors') &&
          body['errors'] != null) {
        throw GraphQLException(
          'GraphQL Engine returned '
          'an unexpected empty payload.',
        );
      }
      return body['data'] as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}

class GraphQLException implements Exception {
  final String message;
  final List<dynamic>? errors;

  GraphQLException(this.message, {this.errors});

  @override
  String toString() =>
      'GraphQLException: $message (Details: $errors)';
}

final graphGatewayProvider = Provider<GraphGateway>((ref) {
  // Target route loopback setup for your local host mock
  // Android Emulator: 'http://10.0.2.2:4000/graphql'
  // iOS Simulator: 'http://localhost:4000/graphql'
  const String localDevUri =
      'http://localhost:4000/graphql';

  return GraphGateway(uri: localDevUri);
});
