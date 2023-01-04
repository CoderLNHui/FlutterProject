import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/details.dart';

/* 作用：监听详情页数据
*/
class DetailsInfoProvide with ChangeNotifier 
{
  DetailsModel goodsInfo =null;
  bool isLeft = true;
  bool isRight = false;

//从后台获取商品信息
  getGoodInfo(String id)async {
    var formData = {'goodId':id};
    await request('getGoodDetailById',formData:formData).then((val){
      var responseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      // ignore: unnecessary_brace_in_string_interps
      print("查看详情数据：${responseData}");
      notifyListeners();
    });
  }
  
//改变tabBar的状态
  changeLeftAndRight(String changeState){

    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }

    notifyListeners();
  }
   
  
}