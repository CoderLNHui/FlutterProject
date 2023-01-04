
import 'package:flutter/material.dart';
import 'package:shflutter/pages/details_page/details_bottom.dart';
import 'package:shflutter/pages/details_page/details_tabBar.dart';
import 'package:shflutter/pages/details_page/details_web.dart';
import './details_explain.dart';
import './details_top_area.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';



class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            print('back');
            Navigator.pop(context);
          },
        ),
        title: Text('Detail'),
      ),
      //异步UI更新FutureBuilder,依赖一个Future通常是一个异步耗时任务，它会根据所依赖的Future的状态来动态构建自身
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context,snapshot) {
          if(snapshot.hasData) {
            return Stack(
              children: [
                ListView(
                  children: [
                    DetailsTopArea(),
                    DetailsExplain(),
                    DetailsTabBar(),
                    DetailsWeb()
                  ],
                ),
                
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom()
                )
              ],
            );
          }else {
            return Text('loading...');
          }
        }
      )
      
    );
  }

  Future _getBackInfo(BuildContext context)async {
    await Provide.value<DetailsInfoProvide>(context).getGoodInfo(goodsId);
    return '完成加载';
  }


}