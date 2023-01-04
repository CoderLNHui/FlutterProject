import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(FluroRouter router){
    router.notFoundHandler = new Handler (
      handlerFunc:(BuildContext context, Map<String,List<String>> params){
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
      }
    );

    router.define(detailsPage,handler:detailsHandler);
  }
}