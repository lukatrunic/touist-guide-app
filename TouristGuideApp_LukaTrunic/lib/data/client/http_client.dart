import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

@RestApi(baseUrl: "http://144.91.87.48:8080/sight")
abstract class HttpClient {
  factory HttpClient(Dio dio, {String? baseUrl}) = _HttpClient;
  
  @GET("/all")
  Future<List<Sight>> getAllSights();

  @GET("/{id}")
  Future<>
}
