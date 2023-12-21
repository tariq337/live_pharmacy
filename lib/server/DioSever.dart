// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/const.dart';

mixin DioServer {
  Dio dio = Dio();

  Future<void> addApiKey() async {
    dio.options.headers['apiKey'] = keyBox.get("apiKey");
  }

  Future<void> get(
      {bool? apiKey,
      required String url,
      Object? data,
      required String key,
      bool? outIn,
      Function? outPutdata,
      Function? errorData}) async {
    try {
      if (apiKey ?? false) {
        await addApiKey();
      }
      log(data.toString());
      final response = await dio.get(url,
          data: data, options: Options(contentType: 'application/json'));

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (outIn ?? false) {
          outPutdata!(response.data);
        } else {
          output(key, response.data);
        }
      } else {
        if (outIn ?? false) {
          errorData!(response.data["ERROR"]);
        } else {
          error(response.data["ERROR"]);
        }
      }
    } on DioError catch (e) {
      if (outIn ?? false) {
        errorData!(dioException(e));
      } else {
        error(dioException(e));
      }
    } catch (e) {
      if (outIn ?? false) {
        errorData!(catchException(e));
      } else {
        error(catchException(e));
      }
    }
  }

  Future<void> post(
      {bool? apiKey,
      required String url,
      Object? data,
      required String key,
      bool? outIn,
      Function? outPutdata,
      Function? errorData}) async {
    try {
      if (apiKey ?? false) {
        await addApiKey();
      }
      final response = await dio.post(url,
          data: data, options: Options(contentType: 'application/json'));
      if (response.statusCode == 200) {
        if (outIn ?? false) {
          outPutdata!(response.data);
        } else {
          output(key, response.data);
        }
      } else {
        if (outIn ?? false) {
          errorData!(response.data["ERROR"]);
        } else {
          error(response.data["ERROR"]);
        }
      }
    } on DioError catch (e) {
      log(e.toString());
      if (outIn ?? false) {
        errorData!(dioException(e));
      } else {
        error(dioException(e));
      }
    } catch (e) {
      if (outIn ?? false) {
        errorData!(catchException(e));
      } else {
        error(catchException(e));
      }
    }
  }

  Future<void> put(
      {bool? apiKey,
      required String url,
      Object? data,
      required String key,
      bool? outIn,
      Function? outPutdata,
      Function? errorData}) async {
    try {
      if (apiKey ?? false) {
        await addApiKey();
      }
      final response = await dio.put(url,
          data: data, options: Options(contentType: 'application/json'));
      if (response.statusCode == 200) {
        if (outIn ?? false) {
          outPutdata!(response.data);
        } else {
          output(key, response.data);
        }
      } else {
        if (outIn ?? false) {
          errorData!(response.data["ERROR"]);
        } else {
          error(response.data["ERROR"]);
        }
      }
    } on DioError catch (e) {
      if (outIn ?? false) {
        errorData!(dioException(e));
      } else {
        error(dioException(e));
      }
    } catch (e) {
      if (outIn ?? false) {
        errorData!(catchException(e));
      } else {
        error(catchException(e));
      }
    }
  }

  Future<void> delete(
      {bool? apiKey,
      required String url,
      Object? data,
      required String key,
      bool? outIn,
      Function? outPutdata,
      Function? errorData}) async {
    try {
      if (apiKey ?? false) {
        await addApiKey();
      }
      final response = await dio.delete(url,
          data: data, options: Options(contentType: 'application/json'));
      if (response.statusCode == 200) {
        if (outIn ?? false) {
          outPutdata!(response.data);
        } else {
          output(key, response.data);
        }
      } else {
        if (outIn ?? false) {
          errorData!(response.data["ERROR"]);
        } else {
          error(response.data["ERROR"]);
        }
      }
    } on DioError catch (e) {
      if (outIn ?? false) {
        errorData!(dioException(e));
      } else {
        error(dioException(e));
      }
    } catch (e) {
      if (outIn ?? false) {
        errorData!(catchException(e));
      } else {
        error(catchException(e));
      }
    }
  }

// output and error method

  void output(String key, dynamic data) {}
  void error(String error) {}
//Exception
  String dioException(DioException e) {
    log(e.toString());
    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        return language[modeControll.LanguageValue]["dio"][0];
      } else if (e.response!.statusCode == 400) {
        return language[modeControll.LanguageValue]["dio"][1];
      }
    }
    return language[modeControll.LanguageValue]["dio"][2];
  }

  String catchException(e) {
    log(e.toString());

    return language[modeControll.LanguageValue]["dio"][2];
  }
}
