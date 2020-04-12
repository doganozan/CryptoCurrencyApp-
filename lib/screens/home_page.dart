import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:kriptocoin/models/coin.dart';
import 'package:kriptocoin/services/services.dart';
import 'coin_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int coinCounter;
  List<Coin> coins = List();
  List<Coin> filteredCoins = List();

  @override
  void initState() {
    super.initState();
    Services.getCoins().then((coinsList) {
      coins = coinsList;
      filteredCoins = coins;
    });
  }

  Future<Null> _refresh() async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      filteredCoins = coins;
    });
    return null;
  }


  Widget buildBody() {
    return FutureBuilder(
            future: Services.getCoins(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                );
              }
              coins = snapshot.data;
              return RefreshIndicator(
                onRefresh: _refresh,
                color: Colors.white70,
                backgroundColor: Colors.pink,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                           icon:Padding(
                             padding: const EdgeInsets.only(left:8.0),
                             child: Icon(Icons.search,color: Colors.grey,),
                           ),
                              contentPadding: EdgeInsets.only(left:50),
                              hintText: 'Enter Coin Name'),
                          onChanged: (string) {
                            setState(() {
                              filteredCoins = coins
                                  .where((u) => (u.fullName
                                  .toLowerCase()
                                  .contains(string.toLowerCase()))
                              ||(u.name
                                      .toLowerCase()
                                      .contains(string.toLowerCase())))
                                  .toList();
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                          child:ListView.builder(
                                padding: EdgeInsets.all(10),
                                itemCount: filteredCoins.length,
                                itemBuilder: (BuildContext context, int index){
                                  coinCounter=index;
                                  return Card(
                                    child: ListTile(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(filteredCoins[index])));
                                      },
                                      leading:Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${coinCounter+1}',
                                          ),

                                        ],
                                      ),
                                      title:Text(
                                        filteredCoins[index].fullName,
                                        style: TextStyle(fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      subtitle:Text(
                                        filteredCoins[index].name,
                                        style: TextStyle(fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                      trailing:Text(
                                        '\$${filteredCoins[index].price.toStringAsFixed(4)}',
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              );
            },
          );
  


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Crypto Currency'))),
      body: buildBody(),
    );
  }
}
