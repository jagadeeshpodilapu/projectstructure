
import 'package:project_struct/data/models/users_model.dart';
import 'package:project_struct/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:project_struct/domain/repository/getData_repository.dart';

import '../../common/app_enums.dart';
import '../data_sources/data_remote_source.dart';

class DataRepositoryImpl extends DataRepository {
  final DataRemoteDataSource remoteDataSource;
  DataRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, UsersModel>> getData() async {
    try {
      final response = await remoteDataSource.getTrending();
      return Right(response);
    }  on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
