 
import 'package:flutter/material.dart';  //导入了Material UI组件库,Material是一种标准的移动端和web端的视觉设计语言
import 'package:shflutter/provide/cart.dart';
import 'package:shflutter/provide/counter.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart'; 
import './provide/current_index.dart';
import './routers/application.dart'; 
import 'package:fluro/fluro.dart';
import './provide/details_info.dart';
import './routers/routes.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';

void main() {
  //启动Flutter应用,runApp接受一个Widget参数，在本示例中它是一个MyApp对象，MyApp()是Flutter应用的根组件
  // runApp(MyApp());
  var childCategory = ChildCategory();
  var categoryGoodsListProvide= CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvider();
  var counter =Counter();

  //flutter_provide 状态管理
  var providers = Providers();
  providers
   ..provide(Provider<ChildCategory>.value(childCategory))
   ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
   ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
   ..provide(Provider<CartProvide>.value(cartProvide))
   ..provide(Provider<CurrentIndexProvider>.value(currentIndexProvide))
   ..provide(Provider<Counter>.value(counter));


 //ProviderNode封装了InheritWidget，并且提供了 一个providers容器用于放置状态。
  runApp(ProviderNode(child: MyApp(),providers: providers));
}

//MyApp类代表Flutter应用，它继承了 StatelessWidget类，这也就意味着应用本身也是一个widge
class MyApp extends StatelessWidget {
  @override
  //Flutter在构建页面时，会调用组件的build方法，
  //widget的主要工作是提供一个build()方法来描述如何构建UI界面（通常是通过组合、拼装其它基础widget）。
  Widget build(BuildContext context) {
    
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    

    return Container(
      //MaterialApp 是Material库中提供的Flutter APP框架，
      //通过它可以设置应用的名称、主题、语言、首页及路由列表等。MaterialApp也是一个widget。
      child: MaterialApp(
        title: 'sh',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch:Colors.blue,
        ),
        //home 为Flutter应用的首页，它也是一个widget
        home: IndexPage(),
      ),
    );
  }

}