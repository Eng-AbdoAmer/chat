import 'dart:convert';
import 'dart:io';

import 'package:chat/core/classes/status_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../functions/chech_internet.dart';
import '../shared/helper_meuthods.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('abdo:123456'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Request {
  Future<Either<StatusRequest, Map>> getRequest(String url) async {
    if (await checkInternet()) {
      try {
        var response = await http.get(Uri.parse(url), headers: myheaders);
        if (response.statusCode == 200) {
          //print(response.body);
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          showToast(msg: "Error try again  later");
          return const Left(StatusRequest.serverFailure);
        }
      } catch (e) {
        showToast(
          msg: "Error try again  later",
        );
        return const Left(StatusRequest.serverException);
      }
    } else {
      return const Left(StatusRequest.offline);
    }
  }

  Future<Either<StatusRequest, Map>> postDataToServer(
      String url, Map<String, dynamic> data) async {
    if (await checkInternet()) {
      //internet worked
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseBody = jsonDecode(response.body);
        return Right(responseBody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      //no internet
      return const Left(StatusRequest.offline);
    }
  }

  Future<Either<StatusRequest, Map>> postRequest(
      String url, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        var response =
            await http.post(Uri.parse(url), body: data, headers: myheaders);
        if (response.statusCode == 200) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          showToast(msg: "Error try again  later");
          print(response.statusCode);
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        //no internet
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      showToast(msg: "Error try again  later");
      return const Left(StatusRequest.serverException);
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile("image", stream, lenght,
        filename: basename(file.path));
    request.files.add(multiPartFile);
    request.headers.addAll(myheaders);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      showToast(msg: "Error try again  later");
    }
  }
}
