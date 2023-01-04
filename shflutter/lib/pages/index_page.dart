import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/current_index.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.home),
      label: 'Home'
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.search),
      label: 'Classes'
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      label: 'Car'
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      label: 'Member'
    )
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Provide<CurrentIndexProvider> (

      builder: (context,child,val) {
        //获取状态currentIndex
        // int currentIndex = val.currentIndex; 或者使用以下方式获取 currentIndex
        int currentIndex = Provide.value<CurrentIndexProvider>(context).currentIndex;
        //Scaffold 是 Material 库中提供的页面脚手架，
        //它提供了默认的导航栏、标题和包含主屏幕widget树（后同“组件树”或“部件树”）的body属性，组件树可以很复杂
        return Scaffold(
          // appBar: AppBar(title: Text('life+'),),
          backgroundColor: Color.fromRGBO(244, 245, 245 ,1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              //更改状态currentIndex
              Provide.value<CurrentIndexProvider>(context).changeIndex(index);
            },
          ),
        //body的组件树中包含了一个Center 组件，Center 可以将其子组件树对齐到屏幕中心
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      }
     
    );

  }



}