import 'package:flutter/cupertino.dart';
import 'package:project_struct/di/get_it.dart';
import 'package:project_struct/domain/usecases/get_user_data.dart';

class DataProvider extends ChangeNotifier {

 

  getUsers() async {
    final results = await GetTrending(getItInstance()).repository.getData();
    print("results $results");
  }
}
