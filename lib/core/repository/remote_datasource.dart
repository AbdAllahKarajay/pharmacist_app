import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:pharmacist_application/core/config/global_data.dart';
import 'package:pharmacist_application/core/data/models/product.dart';

import 'error_handling/error_code.dart';
import 'error_handling/error_handler.dart';
import 'error_handling/remote_exceptions.dart';

class RemoteDatasource {
  static RemoteDatasource? _instance;
  CancelToken _cancelToken = CancelToken();

  RemoteDatasource();

  static RemoteDatasource get instance {
    _instance ??= RemoteDatasource();
    return _instance!;
  }

  final Dio dio = Dio();

  // static const String scheme = 'http';
  // static const int? port = 5000;
  // static const String host = '192.168.43.162';
  static const String scheme = 'http';
  static const int port = 8000;
  static const String host = '192.168.6.162';
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

  performDeleteRequest(String endpoint, {
    dynamic body,
    dynamic params,
    bool useToken = true,
    bool encrypt = false,
  }) async {
    if (kDebugMode) {
      print('endpoints  is $endpoint');
      print('data  is $body');
    }
    try {
      final response = await dio.delete(
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
        return response.data;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Api Error is: ${e.runtimeType} $e');
      }
      if (e is RemoteExceptions) rethrow;
      if (e is DioException) {
        if (kDebugMode) {
          print("status code: ${e.response?.statusCode}");
          print("message: ${e.message}");
          print("data: ${e.response?.data}");
        }
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
        print('Api Error is: ${e.runtimeType} $e');
      }
      if (e is RemoteExceptions) rethrow;
      if (e is DioException) {
        if (kDebugMode) {
          print("status code: ${e.response?.statusCode}");
          print("message: ${e.message}");
          print("data: ${e.response?.data}");
        }
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
        if (kDebugMode) {
          print("status code: ${e.response?.statusCode}");
          print("message: ${e.message}");
          print("data: ${e.response?.data}");
        }
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
        CancelToken? cancelToken,
  }) async {
    if (kDebugMode) {
      print('endpoints  is $endpoint');
      print('params are $params');
    }
    try {
      final response = await dio.get(
        uri.resolve(endpoint).toString(),
        queryParameters: params,
        cancelToken: cancelToken,
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
      print("using token");
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 682,
        'Authorization': 'Bearer ${getx.Get.globalData.token}',
      };
    } else {
    print("not using token");
    options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
    return options;
  }

}
