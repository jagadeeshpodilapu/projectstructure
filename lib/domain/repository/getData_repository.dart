import 'package:dartz/dartz.dart';
import 'package:project_struct/data/models/users_model.dart';

import '../entities/app_error.dart';

abstract class DataRepository {
  Future<Either<AppError, UsersModel>> getData();
}
