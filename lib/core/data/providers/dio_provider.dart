
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_app/core/data/interceptors/error_interceptors.dart';


final dioProvider = Provider<Dio>((ref) {
  final container = ProviderContainer();
  return _provideDio(container);
});

Dio _provideDio(ProviderContainer container, {String? token}) {
  var dio = Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/',
    contentType: 'application/json; charset=UTF-8',
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Request-Token': 'f2r789gf-87fm-61lq-k83j-629t53715y9s',
    },
    receiveDataWhenStatusError: true,
    validateStatus: (_) => true,
  ));


  dio.interceptors.addAll({
    ErrorInterceptors(dio),
  });

  return dio;
}