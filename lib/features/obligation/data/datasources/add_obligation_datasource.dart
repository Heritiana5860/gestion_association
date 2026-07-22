import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/network/api_endpoints.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/obligation/data/models/obligation_model.dart';

abstract class AddObligationDatasource {
  Future<List<ObligationModel>> obligations();
  Future<void> addObligation(ObligationModel model);
}

class AddObligationDatasourceImpl implements AddObligationDatasource {
  final Dio dio;

  const AddObligationDatasourceImpl({required this.dio});

  @override
  Future<void> addObligation(ObligationModel model) async {
    await dio.post(ApiEndpoints.addAnnuel, data: model.toJson());
  }

  @override
  Future<List<ObligationModel>> obligations() async {
    final response = await dio.get(ApiEndpoints.annuel);

    final List<dynamic> data = response.data;

    debugPrint("Data:: $data");

    return data.map((d) => ObligationModel.fromJson(d)).toList();
  }
}
