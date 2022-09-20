import '../models/users_model.dart';

import '../core/api_client.dart';

abstract class DataRemoteDataSource {
  Future<UsersModel> getTrending();
}

class DataRemoteDataSourceImpl extends DataRemoteDataSource {
  final ApiClient _client;

  DataRemoteDataSourceImpl(this._client);

  @override
  Future<UsersModel> getTrending() async {
    final response = await _client.get('/api/users?page=2');
    final users = UsersModel.fromJson(response);
    return users;
  }
}
