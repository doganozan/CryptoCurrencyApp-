
import 'package:flutter/cupertino.dart';

class Coin {
  final String name;
  final String fullName;
  final double price;
  final double change;

  const Coin({
     this.name,
     this.fullName,
     this.price,
     this.change,

  });


  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['CoinInfo']['Name'] as String,
      fullName: json['CoinInfo']['FullName'] as String,
      price: (json['RAW']['USD']['PRICE'] as num).toDouble(),
      change: (json['RAW']['USD']['CHANGE24HOUR'] as num).toDouble(),


    );
  }
}