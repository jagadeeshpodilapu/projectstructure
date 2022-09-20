import 'package:dartz/dartz.dart';
import 'package:project_struct/data/models/users_model.dart';
import 'package:project_struct/domain/repository/getData_repository.dart';

import '../entities/app_error.dart';
import 'use_case.dart';

class NoParams {
  @override
  List<Object> get props => [];
}

class GetTrending extends UseCase<UsersModel, NoParams> {
  final DataRepository repository;

  GetTrending(this.repository);

  @override
  Future<Either<AppError, UsersModel>> call(NoParams noParams) async {
    return await repository.getData();
  }
}
