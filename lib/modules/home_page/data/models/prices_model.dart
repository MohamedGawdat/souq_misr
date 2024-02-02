class PricesModel {
  List<Banks>? banks;
  List<GoldPrices>? goldPrices;
  List<SilverPrices>? silverPrices;
  List<Currencies>? blackMarket;

  PricesModel({this.banks, this.goldPrices, this.silverPrices, this.blackMarket});

  PricesModel.fromJson(Map<String, dynamic> json) {
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(Banks.fromJson(v));
      });
    }
    if (json['gold_prices'] != null) {
      goldPrices = <GoldPrices>[];
      json['gold_prices'].forEach((v) {
        goldPrices!.add(GoldPrices.fromJson(v));
      });
    }
    if (json['silver_prices'] != null) {
      silverPrices = <SilverPrices>[];
      json['silver_prices'].forEach((v) {
        silverPrices!.add(SilverPrices.fromJson(v));
      });
    }
    if (json['black_market'] != null) {
      blackMarket = <Currencies>[];
      json['black_market'].forEach((v) {
        blackMarket!.add(Currencies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (banks != null) {
      data['banks'] = banks!.map((v) => v.toJson()).toList();
    }
    if (goldPrices != null) {
      data['gold_prices'] = goldPrices!.map((v) => v.toJson()).toList();
    }
    if (silverPrices != null) {
      data['silver_prices'] = silverPrices!.map((v) => v.toJson()).toList();
    }
    if (blackMarket != null) {
      data['black_market'] = blackMarket!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  int? id;
  String? name;
  String? pricingUrl;
  String? image;
  String? code;
  List<Currencies>? currencies;

  Banks({this.id, this.name, this.pricingUrl, this.image, this.code, this.currencies});

  Banks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pricingUrl = json['pricing_url'];
    image = json['image'];
    code = json['code'];
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(Currencies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['pricing_url'] = pricingUrl;
    data['image'] = image;
    data['code'] = code;
    if (currencies != null) {
      data['currencies'] = currencies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Currencies {
  int? id;
  String? code;
  double? sellPrice;
  double? buyPrice;
  int? lastUpdated;

  Currencies({this.id, this.code, this.sellPrice, this.buyPrice, this.lastUpdated});

  Currencies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    sellPrice = json['sell_price'];
    buyPrice = json['buy_price'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['sell_price'] = sellPrice;
    data['buy_price'] = buyPrice;
    data['last_updated'] = lastUpdated;
    return data;
  }
}

class GoldPrices {
  String? code;
  String? name;
  String? buyPrice;
  String? sellPrice;
  int? lastUpdate;
  String? image;

  GoldPrices({this.code, this.name, this.buyPrice, this.sellPrice, this.lastUpdate, this.image});

  GoldPrices.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    buyPrice = json['buy_price'];
    sellPrice = json['sell_price'];
    lastUpdate = json['last_update'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['buy_price'] = buyPrice;
    data['sell_price'] = sellPrice;
    data['last_update'] = lastUpdate;
    data['image'] = image;
    return data;
  }
}

class SilverPrices {
  String? code;
  String? name;
  String? price;
  int? lastUpdate;
  String? image;

  SilverPrices({this.code, this.name, this.price, this.lastUpdate, this.image});

  SilverPrices.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    price = json['price'];
    lastUpdate = json['last_update'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['price'] = price;
    data['last_update'] = lastUpdate;
    data['image'] = image;
    return data;
  }
}
