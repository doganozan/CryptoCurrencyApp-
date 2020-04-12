import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kriptocoin/models/coin.dart';

class DetailsPage extends StatelessWidget {

  final Coin coinDetail;

  DetailsPage(this.coinDetail);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinDetail.fullName),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
              child: ListTile(
               title:Center(
                 child: RichText(
                   text: TextSpan(
                     children: [
                       TextSpan(
                           text: "${coinDetail.fullName}'s 24 Hour Change=  ",
                           style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 16)),
                       TextSpan(
                           text: "\$${coinDetail.change.toStringAsFixed(4)}",
                           style: TextStyle(
                               fontSize: 16,
                               color: coinDetail.change>0 ? Colors.green : Colors.red,
                           ),
                        ),
                     ],
                   ),
                 ),
               ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

