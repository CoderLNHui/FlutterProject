import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page/details_page.dart';

///跳转到详情
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
     String goodsId = params['id'].first;
    print('index>details goodsID is ${goodsId}');
    return DetailsPage(goodsId);
  }
);