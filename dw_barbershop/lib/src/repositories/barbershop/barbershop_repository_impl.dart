import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/models/barbershop_model.dart';
import 'package:dw_barbershop/src/models/user_model.dart';
import 'package:dw_barbershop/src/repositories/barbershop/barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barbershopId}',
        );
        return Success(BarbershopModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
      ({
        String email,
        String name,
        List<String> openingDays,
        List<int> openingHours
      }) data) async {
    try {
      await restClient.auth.post('/barbershop', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
        'email': data.email,
        'opening_days': data.openingDays,
        'opening_hours': data.openingHours,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar barbearia', error: e, stackTrace: s);
      return Failure(
        RepositoryException(
          message: 'Erro ao registrar barbearia',
        ),
      );
    }
  }
}
