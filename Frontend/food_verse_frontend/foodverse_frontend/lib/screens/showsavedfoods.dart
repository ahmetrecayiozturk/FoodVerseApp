import 'package:flutter/material.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/addedfooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class SavedFoodsPage extends StatelessWidget {
  final List<Food> foods;

  const SavedFoodsPage({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: const Text(
            'Saved Foods',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Container(
        color: Colors.orange[400],
        child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            final food = foods[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.orange[900],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  food.name,
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                subtitle: Text(
                  food.ingredients.join(', '),
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SavedFoodDetailPage(
                        name: food.name,
                        ingredients: food.ingredients,
                        preparing: food.preparing ?? '',
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

/*---------------çalışan2------------------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:foodverse_frontend/screens/showaddedfood_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class SavedFoodsPage extends StatelessWidget {
  final List<Food> foods;

  const SavedFoodsPage({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: const Text(
            'Saved Foods',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Container(
        color: Colors.orange[400],
        child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            final food = foods[index];
            return ListTile(
              title: Text(
                food.name,
                style: TextStyle(fontSize: 25),
              ),
              subtitle: Text(food.ingredients.join(', ')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavedFoodDetailPage(
                      name: food.name,
                      ingredients: food.ingredients,
                      preparing: food.preparing ?? '',
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
*/

/*------------çalışan1--------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:foodverse_frontend/screens/showaddedfood_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class SavedFoodsPage extends StatelessWidget {
  final List<Food> foods;

  const SavedFoodsPage({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Saved Foods'),
      ),
      body: Container(
        color: Colors.orange[100],
        child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            final food = foods[index];
            return ListTile(
              title: Text(food.name),
              subtitle: Text(food.ingredients.join(', ')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavedFoodDetailPage(
                      name: food.name,
                      ingredients: food.ingredients,
                      preparing: food.preparing ?? '',
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
*/