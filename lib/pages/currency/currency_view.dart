import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_keep/models/currency.dart';

class CurrencyView extends StatefulWidget {
  const CurrencyView({Key? key}) : super(key: key);

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {
  String url = "https://canlidoviz.com/doviz-kurlari.jsonld";
  Future<List<ItemListElement>?> dovizBilgileriniGetir() async {
    var parsedUrl = Uri.parse(url);
    var result = await http.get(parsedUrl);

    try {
      if (result.statusCode == 200) {
        var jsonResponse = jsonDecode(result.body);
        var kurlar =
            Currency.fromJson(jsonResponse).mainEntity!.itemListElement;

        return kurlar;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<ItemListElement>?>(
        future: dovizBilgileriniGetir(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 150,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          child: Text(
                            snapshot.data[index].currency,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.data[index].currentExchangeRate.price
                            .toString(),
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          snapshot
                              .data[index].currentExchangeRate.priceCurrency,
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
