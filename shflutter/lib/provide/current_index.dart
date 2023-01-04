import 'package:flutter/material.dart';

/* 作用：监听点击tabbar时，下标的改变
*/
 //ChangeNotifier，意思是可以不用管理听众
class CurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int newIndex) {
    currentIndex = newIndex;
    print('点击的值');
    print(newIndex);
    //通过notifyListeners可以通知听众刷新。
    notifyListeners();
  }

}