import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class FoodDetailPage extends StatelessWidget {
  final String name;
  final List<String> ingredients;
  final String preparing;
  final User user;
  //final String foodid;
  final List<String> selectedIngredients;
  const FoodDetailPage({
    Key? key,
    required this.name,
    required this.ingredients,
    required this.preparing,
    required this.user,
    required this.selectedIngredients,
    //required this.foodid,
  }) : super(key: key);

  Future<void> _saveFood() async {
    String? userId = await FoodService().getUserId(user.email);
    await FoodService().favoriteFood(userId!, name, ingredients, preparing);
  }

  Future<String> _getFoodOwner() async {
    final addedusername =
        await FoodService().getAdderByFood(name, ingredients, preparing);
    if (addedusername == null) {
      print(addedusername);
      return "sistem";
    } else {
      return addedusername;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: GoogleFonts.lato(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
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
          children: [
            SizedBox(height: 20),
            Text(
              'Ingredients:',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  bool isSelected =
                      selectedIngredients.contains(ingredients[index]);
                  return ListTile(
                    title: Text(
                      ingredients[index],
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: Icon(
                      isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                    onTap: () {
                      // Handle ingredient tap
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Preparation:',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Card(
                  color: Colors.teal.shade100,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      preparing,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<String>(
              future: _getFoodOwner(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Errorr: ${snapshot.error}');
                } else {
                  return Text(
                    'Ekleyen: ${snapshot.data}',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _saveFood,
                icon: Icon(Icons.favorite),
                label: Text('Favori Ekle'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
