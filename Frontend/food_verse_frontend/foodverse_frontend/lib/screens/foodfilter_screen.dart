import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodverse_frontend/screens/fooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';

class FoodFilterPage extends StatefulWidget {
  final User user;
  final String category;
  const FoodFilterPage({Key? key, required this.user, required this.category})
      : super(key: key);

  @override
  _FoodFilterPageState createState() => _FoodFilterPageState();
}

class _FoodFilterPageState extends State<FoodFilterPage> {
  final TextEditingController _ingredientController = TextEditingController();
  List<String> selectedIngredients = [];
  List<Food> foods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food List'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orange.shade200,
              Colors.deepOrange.shade400,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ingredientController,
                      decoration: InputDecoration(
                        hintText: 'Enter Ingredient',
                        fillColor: Colors.white70,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.teal),
                    onPressed: () {
                      setState(() {
                        selectedIngredients.add(_ingredientController.text);
                        _ingredientController.clear();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: selectedIngredients.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              tileColor: Colors.teal[50],
                              title: Text(selectedIngredients[index]),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    selectedIngredients.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  try {
                    List<Food> fetchedFoods =
                        await FoodService.getFoodsByIngredients(
                            selectedIngredients, widget.category);
                    List<Map<String, dynamic>> foodsWithMatchCount =
                        fetchedFoods.map((food) {
                      int matchCount = food.ingredients
                          .where((ingredient) =>
                              selectedIngredients.contains(ingredient))
                          .length;
                      return {'food': food, 'matchCount': matchCount};
                    }).toList();

                    foodsWithMatchCount.sort(
                        (a, b) => b['matchCount'].compareTo(a['matchCount']));

                    _showFoodDialog(foodsWithMatchCount);
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: const Text('Get Foods',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFoodDialog(List<Map<String, dynamic>> foodsWithMatchCount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Foods'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: foodsWithMatchCount.map((foodWithMatch) {
                Food food = foodWithMatch['food'];
                int matchCount = foodWithMatch['matchCount'];
                return ListTile(
                  title: Text('${food.name} - $matchCount eşlendi, '),
                  subtitle: Text(food.ingredients.join(', ')),
                  onTap: () {
                    Navigator.of(context).pop(); // Dialog'u kapat
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailPage(
                          name: food.name,
                          ingredients: food.ingredients,
                          preparing: food.preparing ?? '',
                          user: widget.user,
                          selectedIngredients: selectedIngredients,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
