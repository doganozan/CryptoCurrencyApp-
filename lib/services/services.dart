import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kriptocoin/models/coin.dart';


class Services{

 static const int coinNum=100;


  static Future<List<Coin>> getCoins() async{

    String url='https://min-api.cryptocompare.com/data/top/totalvolfull?limit=$coinNum&tsym=USD&page=0';
    List<Coin> coins=[];
    try{
      final response=await http.get(url);
      if (response.statusCode==200){
        Map<String,dynamic> data=json.decode(response.body);
        List<dynamic> coinList=data['Data'];
        coinList.forEach((json)=>coins.add(Coin.fromJson(json)));
      }
      return coins;

    } catch(e){
      throw Exception(e.toString());
    }
  }

}


