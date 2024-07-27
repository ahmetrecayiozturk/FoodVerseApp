import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/config/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/services/food_service.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';

class FoodSavePage extends StatefulWidget {
  final User user;
  const FoodSavePage({Key? key, required this.user}) : super(key: key);

  @override
  State<FoodSavePage> createState() => _FoodSavePageState();
}

class _FoodSavePageState extends State<FoodSavePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _preparingController = TextEditingController();
  List<String> ingredients = [];
  String? _selectedCategory;
  final List<String> categories = [
    'Kahvaltı',
    'Ana Yemek',
    'Soğuk İçecek',
    'Kahve',
    'Tatlı',
    'Sıcak İçecek'
  ];

  void _addIngredient() {
    setState(() {
      if (_ingredientsController.text.isNotEmpty) {
        ingredients.add(_ingredientsController.text);
        _ingredientsController.clear();
      }
    });
  }

  void saveFood() async {
    if (_selectedCategory == null) {
      // Show an alert dialog if the category is not selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a category.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      String? userId = await FoodService().getUserId(widget.user.email);
      var regbody = {
        "adder": widget.user.email,
        "name": _nameController.text,
        "ingredients": ingredients,
        "preparing": _preparingController.text,
        "category": _selectedCategory
      };
      final response = await http.post(Uri.parse(BaseUrl + foodSaveApi),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(regbody));

      if (response.statusCode == 201) {
        print("Food saved successfully");
        // Perform your desired action on success
      } else {
        print("Failed to save food: ${response.body}");
        throw Exception('Failed to save food');
      }
    } catch (e) {
      print("Error saving food: $e");
      // Consider showing an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Food Page",
          style: GoogleFonts.lato(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.orange.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle:
                    GoogleFonts.lato(fontSize: 18, color: Colors.orange[900]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientsController,
                    decoration: InputDecoration(
                      labelText: "Ingredient",
                      labelStyle: GoogleFonts.lato(
                          fontSize: 18, color: Colors.orange[900]),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.orange[900]),
                  onPressed: _addIngredient,
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _preparingController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Preparing",
                labelStyle:
                    GoogleFonts.lato(fontSize: 18, color: Colors.orange[900]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Category",
                labelStyle:
                    GoogleFonts.lato(fontSize: 18, color: Colors.orange[900]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
              value: _selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: saveFood,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text("Submit"),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Ingredients:",
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[900]),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.orange.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(
                        ingredients[index],
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.orange[900]),
                        onPressed: () {
                          setState(() {
                            ingredients.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*----------------------çalışan koddddddddd-----------------------------
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/config/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class FoodSavePage extends StatefulWidget {
  final User user;
  const FoodSavePage({Key? key, required this.user}) : super(key: key);

  @override
  State<FoodSavePage> createState() => _FoodSavePageState();
}

class _FoodSavePageState extends State<FoodSavePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _preparingController = TextEditingController();
  List<String> ingredients = [];
  String? _selectedCategory;
  final List<String> categories = [
    'Main Dish',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert',
    'Beverage'
  ];

  void _addIngredient() {
    setState(() {
      if (_ingredientsController.text.isNotEmpty) {
        ingredients.add(_ingredientsController.text);
        _ingredientsController.clear();
      }
    });
  }

  void saveFood() async {
    if (_selectedCategory == null) {
      // Show an alert dialog if the category is not selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a category.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      String? userId = await FoodService().getUserId(widget.user.email);
      var regbody = {
        "adder": widget.user.email,
        "name": _nameController.text,
        "ingredients": ingredients,
        "preparing": _preparingController.text,
        "category": _selectedCategory
      };
      final response = await http.post(Uri.parse(BaseUrl + foodSaveApi),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(regbody));

      if (response.statusCode == 201) {
        print("Food saved successfully");
        // Perform your desired action on success
      } else {
        print("Failed to save food: ${response.body}");
        throw Exception('Failed to save food');
      }
    } catch (e) {
      print("Error saving food: $e");
      // Consider showing an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Add Food Page",
            style: GoogleFonts.lato(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.grey //Color.fromARGB(223, 247, 229, 141),
          ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(
                  255, 25, 20, 20), //const Color.fromARGB(255, 240, 104, 54),
              Colors.brown //Color.fromARGB(255, 223, 220, 145)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: GoogleFonts.lato(),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientsController,
                    decoration: InputDecoration(
                      labelText: "Ingredient",
                      labelStyle: GoogleFonts.lato(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.black),
                  onPressed: _addIngredient,
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _preparingController,
              decoration: InputDecoration(
                labelText: "Preparing",
                labelStyle: GoogleFonts.lato(),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Category",
                labelStyle: GoogleFonts.lato(),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
              value: _selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: saveFood,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text("Submit"),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Ingredients:",
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ingredients[index], style: GoogleFonts.lato()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/














/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/config/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class FoodSavePage extends StatefulWidget {
  final User user;
  const FoodSavePage({Key? key, required this.user}) : super(key: key);

  @override
  State<FoodSavePage> createState() => _FoodSavePageState();
}

class _FoodSavePageState extends State<FoodSavePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _preparingController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  List<String> ingredients = [];

  void _addIngredient() {
    setState(() {
      if (_ingredientsController.text.isNotEmpty) {
        ingredients.add(_ingredientsController.text);
        _ingredientsController.clear();
      }
    });
  }

/*
  void saveFood() async {
    String? userId = await FoodService().getUserId(widget.user.email);
    var regbody = {
      "addeduser": widget.user.email,
      "name": _nameController.text,
      "ingredients": ingredients,
      "preparing": _preparingController.text
    };
    final response = await http.post(Uri.parse(BaseUrl + foodSaveApi),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(regbody));

    if (response.statusCode == 201) {
      print("Food saved successfully");
      // Perform your desired action on success
    } else {
      print("Failed to save food");
      throw Exception('Failed to save food');
    }
  }
*/
  void saveFood() async {
    try {
      String? userId = await FoodService().getUserId(widget.user.email);
      var regbody = {
        "addeduser": widget.user.email,
        "name": _nameController.text,
        "ingredients": ingredients,
        "preparing": _preparingController.text
      };
      final response = await http.post(Uri.parse(BaseUrl + foodSaveApi),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(regbody));

      if (response.statusCode == 201) {
        print("Food saved successfully");
        // Perform your desired action on success
      } else {
        // Log the response body for more details on the error
        print("Failed to save food: ${response.body}----------");
        throw Exception('Failed to save food 2');
      }
    } catch (e) {
      // Handle any errors that occur during the save process
      print("Error saving food: $e");
      // Consider showing an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Food Page",
          style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.teal.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: GoogleFonts.lato(),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientsController,
                    decoration: InputDecoration(
                      labelText: "Ingredient",
                      labelStyle: GoogleFonts.lato(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.teal),
                  onPressed: _addIngredient,
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _preparingController,
              decoration: InputDecoration(
                labelText: "Preparing",
                labelStyle: GoogleFonts.lato(),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: "Category",
                labelStyle: GoogleFonts.lato(),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_categoryController.text == null) {
                      _categoryController.text = "Food";
                    }
                  });
                  FoodService().addFood(
                      widget.user.email,
                      _nameController.text,
                      ingredients,
                      _preparingController.text,
                      _categoryController.text);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text("Submit"),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Ingredients:",
              style:
                  GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ingredients[index], style: GoogleFonts.lato()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/