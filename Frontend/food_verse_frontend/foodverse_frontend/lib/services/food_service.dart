import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/config/config.dart'; // Ensure this is correctly imported
import 'package:logging/logging.dart';

final Logger logger = Logger('FoodService');

class Food {
  String id;
  String adder;
  String name;
  List<String> ingredients;
  String preparing;
  String category;

  Food({
    required this.id,
    required this.adder,
    required this.name,
    required this.ingredients,
    required this.preparing,
    required this.category,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['Id'] ?? '',
      adder: json['adder'] ?? 'sistem',
      name: json['name'] ?? '',
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
      preparing: json['preparing'] ?? '',
      category: json['category'] ?? '',
    );
  }
}

class FoodService {
  static Future<List<Food>> getFoodsByIngredients(
      List<String> ingredients, String category) async {
    final response = await http.post(
      Uri.parse(BaseUrl + foodSearchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'ingredients': ingredients,
        'category': category,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Food> foods = data.map((json) => Food.fromJson(json)).toList();
      return foods;
    } else {
      logger.warning(
          "Failed to load foods with status code: ${response.statusCode}");
      throw Exception('Failed to load foods');
    }
  }

  Future<void> favoriteFood(String userId, String name,
      List<String> ingredients, String preparing) async {
    if (userId.isNotEmpty) {
      var regBody = {
        "Id": userId,
        "name": name,
        "ingredients": ingredients,
        "preparing": preparing
      };
      final response = await http.post(
        Uri.parse(BaseUrl + savedFood),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 201) {
        logger.info("Food Saved Successfully");
      } else {
        logger.warning("Food Not Saved Successfully. User ID: $userId");
      }
    } else {
      logger.warning("userId is not found");
    }
  }

  Future<List<Food>> fetchFavoriteFoods(String userId) async {
    var regbody = {"Id": userId};
    final response = await http.post(
      Uri.parse(BaseUrl + getsavedfood),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regbody),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((food) => Food.fromJson(food)).toList();
    } else {
      throw Exception('Failed to load saved foods');
    }
  }

  Future<String?> getUserId(String email) async {
    var regBody = {"email": email};
    final response = await http.post(
      Uri.parse(BaseUrl + isuserexist),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regBody),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      var userId = jsonResponse['Id'];
      return userId;
    }
    return null;
  }

  Future<Food?> addFood(String adder, String name, List<String> ingredients,
      String preparing, String category) async {
    final response = await http.post(
      Uri.parse(BaseUrl + foodSaveApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'adder': adder,
        'name': name,
        'ingredients': ingredients,
        'preparing': preparing,
        'category': category
      }),
    );

    if (response.statusCode == 201) {
      return Food.fromJson(jsonDecode(response.body));
    } else {
      logger.warning(
          'Failed to add food. Status code: ${response.statusCode}. Response body: ${response.body}');
      throw Exception(
          'Failed to add food. Status code: ${response.statusCode}');
    }
  }

  Future<List<Food>> fetchAddedFoods(String name) async {
    var regbody = {"adder": name};
    final response = await http.post(
      Uri.parse(BaseUrl + getaddedfoods),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regbody),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((food) => Food.fromJson(food)).toList();
    } else {
      throw Exception('Failed to load saved foods');
    }
  }

  Future<String> getAdderByFood(
      String name, List<String> ingredients, String preparing) async {
    var regbody = {
      "name": name,
      "ingredients": ingredients,
      "preparing": preparing
    };
    final response = await http.post(
      Uri.parse(BaseUrl + getadderbyfood),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(regbody),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      var adder = jsonResponse['adder'];
      return adder ?? "sistem";
    } else {
      return "sistem";
    }
  }

  static Future<List<Food>> getFoodsByOnlyIngredients(
      List<String> ingredients) async {
    print('çalışıyor hocamm');
    final response = await http.post(
      Uri.parse(BaseUrl + finfoodbyonlyingredient),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'ingredients': ingredients,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Food> foods = data.map((json) => Food.fromJson(json)).toList();
      return foods;
    } else {
      logger.warning(
          "Failed to load foods with status code: ${response.statusCode}");
      throw Exception('Failed to load foods');
    }
  }
}


/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/config/config.dart';
import 'package:logging/logging.dart';

final Logger logger = Logger('FoodService');

class Food {
  String id;
  String adder;
  String name;
  List<String> ingredients;
  String preparing;
  String category;

  Food({
    required this.id,
    required this.adder,
    required this.name,
    required this.ingredients,
    required this.preparing,
    required this.category,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['Id'] ?? '',
      adder: json['adder'] ?? 'sistem',
      name: json['name'] ?? '',
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
      preparing: json['preparing'] ?? '',
      category: json['category'] ?? '',
    );
  }
}

class FoodService {
  static Future<List<Food>> getFoodsByIngredients(
      List<String> ingredients, String category) async {
    final response = await http.post(
      Uri.parse(BaseUrl + foodSearchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'ingredients': ingredients,
        'category': category,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Food> foods = data.map((json) => Food.fromJson(json)).toList();
      return foods;
    } else {
      print("burası çalışmadı status 200 deil");
      throw Exception('Failed to load foods');
    }
  }

  Future<void> favoriteFood(String userId, String name,
      List<String> ingredients, String preparing) async {
    if (userId != null) {
      var regBody = {
        "Id": userId,
        "name": name,
        "ingredients": ingredients,
        "preparing": preparing
      };
      final response = await http.post(
        Uri.parse(BaseUrl + savedFood),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 201) {
        print("Food Saved Successfully---");
      } else {
        print("Food Not Saved Successfully---");
        print(userId);
      }
    } else {
      print("userId is not found");
    }
  }

  Future<List<Food>> fetchFavoriteFoods(String userId) async {
    var regbody = {"Id": userId};
    final response = await http.post(
      Uri.parse(BaseUrl + getsavedfood),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regbody),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((food) => Food.fromJson(food)).toList();
    } else {
      throw Exception('Failed to load saved foods');
    }
  }

  Future<String?> getUserId(String email) async {
    var regBody = {"email": email};
    final response = await http.post(
      Uri.parse(BaseUrl + 'isuser-exist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regBody),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      var userId = jsonResponse['Id'];
      return userId;
    }
    return null;
  }

  Future<Food?> addFood(String adder, String name, List<String> ingredients,
      String preparing, String category) async {
    final adder2 = getAdderByFood(name, ingredients, preparing);
    final response = await http.post(
      Uri.parse(BaseUrl + 'foods'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'adder': adder,
        'name': name,
        'ingredients': ingredients,
        'preparing': preparing,
        'category': category
      }),
    );

    if (response.statusCode == 201) {
      return Food.fromJson(jsonDecode(response.body));
    } else {
      logger.warning(
          'Failed to add food. Status code: ${response.statusCode}. Response body: ${response.body}');
      throw Exception(
          'Failed to add food. Status code: ${response.statusCode}');
    }
  }

  Future<List<Food>> fetchAddedFoods(String name) async {
    var regbody = {"adder": name};
    final response = await http.post(
      Uri.parse(BaseUrl + getaddedfoods),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regbody),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((food) => Food.fromJson(food)).toList();
    } else {
      throw Exception('Failed to load saved foods');
    }
  }

  Future<String> getAdderByFood(
      String name, List<String> ingredients, String preparing) async {
    var regbody = {
      "name": name,
      "ingredients": ingredients,
      "preparing": preparing
    };
    final response = await http.post(
      Uri.parse(BaseUrl + getadderbyfood),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(regbody),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      var adder = jsonResponse['adder'];
      if (adder == null) {
        return "sistem";
      } else {
        return adder;
      }
    } else {
      return "sistem";
    }
  }

  static Future<List<Food>> getFoodsByOnlyIngredients(
      List<String> ingredients) async {
    final response = await http.post(
      Uri.parse(BaseUrl + finfoodbyonlyingredient),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'ingredients': ingredients,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Food> foods = data.map((json) => Food.fromJson(json)).toList();
      return foods;
    } else {
      print("burası çalışmadı status 200 deil");
      throw Exception('Failed to load foods');
    }
  }
}
*/












































































































































































/*
  //Eklenen yemekleri getirme(addedfood ekranı için)
  Future<List<Food>> fetchAddedFoods(String name) async {
    print("abi eklediklerini arıyourz");
    var regbody = {"addeduser": name};
    final response = await http.post(
      Uri.parse(BaseUrl + getaddedfoods),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(regbody),
    );

    if (response.statusCode == 201) {
      print("Food Show Successfully---${response.statusCode}");
    } else {
      print("Food Not Show Successfully---${response.statusCode}");
    }

    throw Exception('Failed to fetch added foods');
  }
  */




/*-------------ÇALIŞAN KODDDDDDDDDDDD------------------------------------
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/config/config.dart';
import 'package:logging/logging.dart';

final Logger logger = Logger('FoodService');

class Food {
  final String id;
  final String name;
  final List<String> ingredients;
  final String? preparing;

  Food({
    required this.id,
    required this.name,
    required this.ingredients,
    this.preparing,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['_id'] ?? 'No ID', // `_id` MongoDB'den gelen alan
      name: json['name'] ?? 'No Name',
      ingredients: List<String>.from(json['ingredients']),
      preparing: json['preparing'],
    );
  }
}

class FoodService {
  //İçindekilere göre yemekleri getirme
  static Future<List<Food>> getFoodsByIngredients(
      List<String> ingredients) async {
    final response = await http.post(
      Uri.parse(BaseUrl + foodSearchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'ingredients': ingredients,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Food> foods = data.map((json) => Food.fromJson(json)).toList();
      return foods;
    } else {
      print("burası çalışmadı status 200 deil");
      throw Exception('Failed to load foods');
    }
  }

  //Yemekleri favorileme(favoritefood ekranı için)
  Future<void> favoriteFood(String userId, String name,
      List<String> ingredients, String preparing) async {
    //String? userId = await getUserId();
    // ignore: unnecessary_null_comparison
    if (userId != null) {
      var regBody = {
        "Id": userId,
        "name": name,
        "ingredients": ingredients,
        "preparing": preparing
      };
      final response = await http.post(
        Uri.parse(BaseUrl + savedFood),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 201) {
        print("Food Saved Successfully---");
      } else {
        print("Food Not Saved Successfully---");
        print(userId);
      }
    } else {
      print("userId is not found");
    }
  }

  //Favorilenen yemekleri getirme(showfavoritefood ekranı için)
  Future<List<Food>> fetchFavoriteFoods(String userId) async {
    print("abim bu fonksiyon çalışıyor");
    //String? userId = await getUserId(email);
    var regbody = {"Id": userId};
    final response = await http.post(
      Uri.parse(BaseUrl + getsavedfood),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regbody),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((food) => Food.fromJson(food)).toList();
    } else {
      print("abi yemekleri yükleyemedik kusura bakma");
      throw Exception('Failed to load saved foods');
    }
  }

  //Kullanıcı id'sini getirme(favoritefood ekranı için(gereksiz idi ama olsun))
  Future<String?> getUserId(String email) async {
    var regBody = {"email": email};
    final response = await http.post(
      Uri.parse(BaseUrl + 'isuser-exist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regBody),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      var userId = jsonResponse['Id'];
      return userId;
    }
    return null;
  }

  //Yemekleri ekleme(foodsave ekranı için)
  static Future<Food> addFood(String adder, String name,
      List<String> ingredients, String preparing) async {
    final response = await http.post(
      Uri.parse(BaseUrl + foodSaveApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'adder': adder,
        'name': name,
        'ingredients': ingredients,
        'preparing': preparing,
      }),
    );

    if (response.statusCode == 201) {
      return Food.fromJson(json.decode(response.body));
    } else {
      print("burası çalışmadı status 201 deil");
      logger.info('${response.body} ${response.statusCode}');
      throw Exception('Failed to save food');
    }
  }

  //Eklenen yemekleri getirme(addedfood ekranı için)
  Future<List<Food>> fetchAddedFoods(String name) async {
    var regbody = {"addeduser": name};
    final response = await http.post(
      Uri.parse(BaseUrl + getaddedfoods),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(regbody),
    );

    if (response.statusCode == 201) {
      print("Food Saved Successfully---");
    } else {
      print("Food Not Saved Successfully---");
    }

    throw Exception('Failed to fetch added foods');
  }

  //Yemeklerden ekleyeni getirme(foodfilterscreen için)
  Future<String> getAdderByFood(
      String name, List<String> ingredients, String preparing) async {
    print("yemeği ekleyeni arıyoruz");
    var regbody = {
      "name": name,
      "ingredients": ingredients,
      "preparing": preparing
    };
    final response = await http.post(
      Uri.parse(BaseUrl + getadderbyfood),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(regbody),
    );

    if (response.statusCode == 200) {
      print("başarılı bir şekilde kim eklemiş bulduk");
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      var adder = jsonResponse['adder'];
      if (adder == null) {
        return "sistem";
      } else {
        return adder;
      }
    } else {
      print("kimin eklediğini bulamadık");
      print(response.statusCode);
      return "sistem";
    }
  }
}
*/






/*
class Food {
  final String name;
  final List<String> ingredients;
  final String? preparing;

  Food({required this.name, required this.ingredients, this.preparing});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'] ?? 'No Name',
      ingredients: List<String>.from(json['ingredients']),
      preparing: json['preparing'],
    );
  }
}
  //Eklenen yemekleri getirme
  Future<String> getAdderByFood(String id) async {
    var regbody = {"_id": id};
    final response = await http.post(
      Uri.parse(BaseUrl + getadderbyfood),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(regbody),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      var adder = jsonResponse['addeduser'];
      return adder;
    } else {
      return "sistem";
    }
  }
*/
