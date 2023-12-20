import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:pharmacist_application/core/config/global_data.dart';

import 'error_handling/error_code.dart';
import 'error_handling/error_handler.dart';
import 'error_handling/remote_exceptions.dart';

class RemoteDatasource {
  static RemoteDatasource? _instance;

  RemoteDatasource();

  static RemoteDatasource get instance {
    _instance ??= RemoteDatasource();
    return _instance!;
  }

  final Dio dio = Dio();

  static const String scheme = 'https';
  static const int? port = null;
  static const String host = '2892-31-9-117-69.ngrok-free.app';
  static Uri uri = Uri(scheme: scheme, host: host, port: port);

  Future performPutRequest<T>(
    String endpoint, {
    dynamic body,
    dynamic params,
    T Function(Map<String, dynamic>)? fromMap,
    bool useToken = true,
    bool encrypt = false,
  }) async {
    if (kDebugMode) {
      print('endpoints  is $endpoint');
      print('data  is $body');
    }
    try {
      final response = await dio.put(
        uri.resolve(endpoint).toString(),
        queryParameters: params,
        data: body,
        options: await setOptions(useToken),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      if (ErrorHandler.handleRemoteStatusCode(
          response.statusCode!, response.data, response.headers.map)) {
        return fromMap == null ? response.data : fromMap(response.data);
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Api Error is: $e');
      }
      if (e is RemoteExceptions) rethrow;
      if (e is DioException) {
        throw ErrorHandler.handleRemoteStatusCode(e.response?.statusCode ?? 400,
            e.response?.data, e.response?.headers.map ?? {});
      } else {
        throw RemoteExceptions(ErrorCode.APP_ERROR, e.toString());
      }
    }
  }

  Future performPostRequest<T>(
    String endpoint, {
    dynamic body,
    dynamic params,
    T Function(Map<String, dynamic>)? fromMap,
    bool useToken = true,
    bool encrypt = false,
  }) async {
    if (kDebugMode) {
      print('endpoints  is $endpoint');
      print('data  is $body');
    }
    try {
      final response = await dio.post(
        uri.resolve(endpoint).toString(),
        queryParameters: params,
        data: body,
        options: await setOptions(useToken),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      if (ErrorHandler.handleRemoteStatusCode(
          response.statusCode!, response.data, response.headers.map)) {
        return fromMap == null ? response.data : fromMap(response.data);
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Api Error is: $e');
      }
      if (e is RemoteExceptions) rethrow;
      if (e is DioException) {
        throw ErrorHandler.handleRemoteStatusCode(e.response?.statusCode ?? 400,
            e.response?.data, e.response?.headers.map ?? {});
      } else {
        throw RemoteExceptions(ErrorCode.APP_ERROR, e.toString());
      }
    }
  }

  Future performPostListRequest<T>(
    String endpoint, {
    dynamic body,
    dynamic params,
    required T Function(Map<String, dynamic>) fromMap,
    bool useToken = true,
    bool encrypt = false,
  }) async {
    if (kDebugMode) {
      print('endpoints  is $endpoint');
      print('data  is $body');
    }
    try {
      final response = await dio.post(
        uri.resolve(endpoint).toString(),
        queryParameters: params,
        data: body,
        options: await setOptions(useToken),
      );
      if (kDebugMode) {
      print("sd");
        print('response is $response');
      }
      if (ErrorHandler.handleRemoteStatusCode(
          response.statusCode!, response.data, response.headers.map)) {
        return response.data.map((e) => fromMap(e)).toList();
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Api Error is: $e');
      }
      if (e is RemoteExceptions) rethrow;
      if (e is DioException) {
        throw ErrorHandler.handleRemoteStatusCode(e.response?.statusCode ?? 400,
            e.response?.data, e.response?.headers.map ?? {});
      } else {
        throw RemoteExceptions(ErrorCode.APP_ERROR, e.toString());
      }
    }
  }

  Future<T> performGetRequest<T>(
    String endpoint, {
    T Function(Map<String, dynamic>)? fromMap,
    Map<String, dynamic>? params,
    bool useToken = true,
  }) async {
    if (kDebugMode) {
      print('endpoints  is $endpoint');
    }
    try {
      final response = await dio.get(
        uri.resolve(endpoint).toString(),
        queryParameters: params,
        options: await setOptions(useToken),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      if (ErrorHandler.handleRemoteStatusCode(
          response.statusCode!, response.data, response.headers.map)) {
        return fromMap == null ? response.data : fromMap(response.data);
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Api Error is: $e\n');
      }
      if (e is RemoteExceptions) rethrow;
      if (e is DioException) {
        throw ErrorHandler.handleRemoteStatusCode(e.response?.statusCode ?? 400,
            e.response?.data, e.response?.headers.map ?? {});
      } else {
        throw RemoteExceptions(ErrorCode.APP_ERROR, e);
      }
    }
  }

  Future<List<T>> performGetListRequest<T>(
    String endpoint, {
    required T Function(Map<String, dynamic>) fromMap,
    Map<String, dynamic>? params,
    bool useToken = true,
  }) async {
    if (kDebugMode) {
      print('endpoints  is $endpoint');
    }
    try {
      final response = await dio.get(
        uri.resolve(endpoint).toString(),
        queryParameters: params,
        options: await setOptions(useToken),
      );
      if (kDebugMode) {
        print('response is $response');
      }
      if (ErrorHandler.handleRemoteStatusCode(
          response.statusCode!, response.data, response.headers.map)) {
        List<T> result = [];
        for (var element in response.data) {
          result.add((fromMap(element)));
        }
        return result;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Api Error is: $e\n');
      }
      if (e is RemoteExceptions) rethrow;
      if (e is DioException) {
        throw ErrorHandler.handleRemoteStatusCode(e.response?.statusCode ?? 400,
            e.response?.data, e.response?.headers.map ?? {});
      } else {
        throw RemoteExceptions(ErrorCode.APP_ERROR, e.toString());
      }
    }
  }

  Future<Options> setOptions(bool useToken) async {
    Options options = Options();
    if (useToken || getx.Get.globalData.isLoggedIn) {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getx.Get.globalData.token}',
      };
    } else {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
    return options;
  }
}
