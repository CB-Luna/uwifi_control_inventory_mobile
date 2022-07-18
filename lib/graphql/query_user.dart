import 'package:bizpro_app/const.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gql/language.dart';

const String userQuery = """
query(\$id: ID) {
  usersPermissionsUser(id: \$id) {
    data {
      id
      attributes {
        username
        email
        role {
          data {
            attributes {
              name
            }
          }
        }
        apellidoP
        apellidoM
        nacimiento
        celular
        telefono
        imagen {
          data {
            attributes {
              url
            }
          }
        }
      }
    }
  }
}
""";

Future<Map<String, dynamic>?> getUser(String jwt, int userId) async {
  //Client setup
  final HttpLink httpLink = HttpLink('$strapiServer/graphql');

  final AuthLink authLink = AuthLink(getToken: () => 'Bearer $jwt');

  final Link link = authLink.concat(httpLink);
  final client = GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );

  final QueryOptions queryUserOptions = QueryOptions(
    document: parseString(userQuery),
    variables: {"id": userId},
  );

  //TODO: manejar errores

  final QueryResult result = await client.query(queryUserOptions);

  if (result.data == null) return null;

  final Map<String, dynamic> user =
      result.data!['usersPermissionsUser']['data'];

  return user;
}
