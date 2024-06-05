import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parallex_listivew/parallax_page.dart';
import 'package:parallex_listivew/variation_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_product_page.dart';
import 'flutter_pageview.dart';
import 'parallex_pageview.dart';

var client = SupabaseClient("https://rwzzvwilthjiizfjlpiz.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ3enp2d2lsdGhqaWl6ZmpscGl6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU4OTY1NDAsImV4cCI6MjAyMTQ3MjU0MH0.TGomjQZzaUZy8E7dE0Pmdx86e7dzSZB3nXmDZbwu_BA");

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orangeAccent,
        ),
      ),
      home: VariationAddPage(
        variationId: 31,
        productId: 37,
      ),
    );
  }
}

var dio = Dio(
  BaseOptions(
    baseUrl: 'http://192.168.29.5:9099/',
    connectTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
