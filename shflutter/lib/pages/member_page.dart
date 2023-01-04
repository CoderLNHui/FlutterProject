import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('memberPage')),
      body: ListView(
        children: [
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList()
        ],
      )
    );
  }

//头像区域
  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child:Image.network('http://blogimages.jspang.com/blogtouxiang1.jpg')
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'syh',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color:Colors.white,
              ),
            )
          ),
        ],
      ),
    );
  }
  //我的订单顶部
  Widget _orderTitle(){

    return Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title:Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );

  }

 Widget _orderType(){
   return Container(
      margin: EdgeInsets.only(top:5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top:20),
      color: Colors.white,
      child: Row(
        children: [
          _myOrderTypeSub('待付款',Icons.party_mode),
          _myOrderTypeSub('待发货',Icons.query_builder),
          _myOrderTypeSub('待收货',Icons.directions_car),
          _myOrderTypeSub('待评价',Icons.content_paste),

          // Container(
          //   width: ScreenUtil().setWidth(187),
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.party_mode,
          //         size: 30,
          //       ),
          //       Text('待付款'),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: ScreenUtil().setWidth(187),
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.query_builder,
          //         size: 30,
          //       ),
          //       Text('待发货'),
          //     ],
          //   ),
          // ),
          //  Container(
          //   width: ScreenUtil().setWidth(187),
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.directions_car,
          //         size: 30,
          //       ),
          //       Text('待收货'),
          //     ],
          //   ),
          // ),
          // Container(
          //   width: ScreenUtil().setWidth(187),
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.content_paste,
          //         size: 30,
          //       ),
          //       Text('待评价'),
          //     ],
          //   ),
          // ),
        ],
      ),
   );
 }

 Widget _myOrderTypeSub(String title,IconData subIcon){

    return Container(
      width: ScreenUtil().setWidth(187),
      child: Column(
        children: [
          Icon(
            subIcon,
            size: 30,
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _myListTile(String title){

    return Container(
       decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

    Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
            _myListTile('领取优惠券'),
            _myListTile('已领取优惠券'),
            _myListTile('地址管理'),
            _myListTile('客服电话'),
            _myListTile('关于我们'),
        ],
      ),
    );
  }


}