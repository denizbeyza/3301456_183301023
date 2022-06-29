class Currency {
  String? context;
  String? type;
  String? name;
  MainEntity? mainEntity;

  Currency({this.context, this.type, this.name, this.mainEntity});

  Currency.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    type = json['@type'];
    name = json['name'];
    mainEntity = json['mainEntity'] != null
        ? MainEntity.fromJson(json['mainEntity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@context'] = context;
    data['@type'] = type;
    data['name'] = name;
    if (mainEntity != null) {
      data['mainEntity'] = mainEntity!.toJson();
    }
    return data;
  }
}

class MainEntity {
  String? type;
  String? name;
  List<ItemListElement>? itemListElement;

  MainEntity({this.type, this.name, this.itemListElement});

  MainEntity.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    name = json['name'];
    if (json['itemListElement'] != null) {
      itemListElement = <ItemListElement>[];
      json['itemListElement'].forEach((v) {
        itemListElement!.add(ItemListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['name'] = name;
    if (itemListElement != null) {
      data['itemListElement'] =
          itemListElement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemListElement {
  String? type;
  String? currency;
  CurrentExchangeRate? currentExchangeRate;

  ItemListElement({this.type, this.currency, this.currentExchangeRate});

  ItemListElement.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    currency = json['currency'];
    currentExchangeRate = json['currentExchangeRate'] != null
        ? CurrentExchangeRate.fromJson(json['currentExchangeRate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['currency'] = currency;
    if (currentExchangeRate != null) {
      data['currentExchangeRate'] = currentExchangeRate!.toJson();
    }
    return data;
  }
}

class CurrentExchangeRate {
  String? type;
  double? price;
  String? priceCurrency;

  CurrentExchangeRate({this.type, this.price, this.priceCurrency});

  CurrentExchangeRate.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    price = json['price'];
    priceCurrency = json['priceCurrency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@type'] = type;
    data['price'] = price;
    data['priceCurrency'] = priceCurrency;
    return data;
  }
}
