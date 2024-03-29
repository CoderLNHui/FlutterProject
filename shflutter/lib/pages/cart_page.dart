import 'package:flutter/material.dart';
import 'package:shflutter/pages/cart_page/cart_bottom.dart';
import 'package:shflutter/pages/cart_page/cart_item.dart';
import 'package:shflutter/provide/cart.dart';
import 'package:provide/provide.dart';



class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('cartPage')),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context,snapshot){
          List cartList = Provide.value<CartProvide>(context).cartList;
          if (snapshot.hasData && cartList != null) {
            return Stack(
              children: [
                Provide<CartProvide>(
                  builder: (context,child,childCategory){
                    cartList = Provide.value<CartProvide>(context).cartList;
                    print(cartList);
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context,index){
                        return CartItem(cartList[index]);
                      },
                    );
                  },
                ),
                Positioned(
                  bottom:0,
                  left:0,
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
      )
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }

}