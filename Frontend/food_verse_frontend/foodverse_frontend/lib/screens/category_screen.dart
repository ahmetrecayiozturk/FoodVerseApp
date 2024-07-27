import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/filterfoodbyingredients.dart';
import 'package:foodverse_frontend/screens/foodfilter_screen.dart';

class CategoryPage extends StatefulWidget {
  final User user;
  const CategoryPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category Page',
          style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade50,
              Colors.teal.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildCategoryButton(
              context,
              label: "Kahvaltı",
              category: "Kahvaltı",
            ),
            _buildCategoryButton(
              context,
              label: "Ana Yemek",
              category: "ana yemek",
            ),
            _buildCategoryButton(
              context,
              label: "Soğuk İçecek",
              category: "soğuk içecek",
            ),
            _buildCategoryButton(
              context,
              label: "Kahve",
              category: "kahve",
            ),
            _buildCategoryButton(
              context,
              label: "Tatlı",
              category: "tatlı",
            ),
            _buildCategoryButton(
              context,
              label: "Sıcak İçecek",
              category: "sıcak içecek",
            ),
            _buildGeneralButton(
              context,
              label: "Genel",
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context,
      {required String label, required String category}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodFilterPage(
                user: widget.user,
                category: category,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          textStyle: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildGeneralButton(BuildContext context, {required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterFoodByOnlyIngredientPage(
                user: widget.user,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          textStyle: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildSimpleButton(
      {required String label, required void Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          textStyle: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}


/*------------------çalışan kodd--------------------------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/filterfoodbyingredients.dart';
import 'package:foodverse_frontend/screens/foodfilter_screen.dart';

class CategoryPage extends StatefulWidget {
  final User user;
  const CategoryPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Page'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodFilterPage(
                            user: widget.user,
                            category: "Breakfast",
                          )),
                );
              },
              child: Text("Breakfast")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodFilterPage(
                            user: widget.user,
                            category: "ana yemek",
                          )),
                );
              },
              child: Text("Ana Yemek")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodFilterPage(
                            user: widget.user,
                            category: "soğuk içecek",
                          )),
                );
              },
              child: Text("Soğuk İçecek")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodFilterPage(
                            user: widget.user,
                            category: "kahve",
                          )),
                );
              },
              child: Text("Kahve")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodFilterPage(
                            user: widget.user,
                            category: "tatlı",
                          )),
                );
              },
              child: Text("Tatlı")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FilterFoodByOnlyIngredientPage(
                            user: widget.user,
                          )),
                );
              },
              child: Text("Genel")),
          ElevatedButton(onPressed: () {}, child: Text("Girilecek")),
        ],
      ),
    );
  }
}
*/


/*
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Page'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Kahvaltı")),
          ElevatedButton(onPressed: () {}, child: Text("Ana Yemek")),
          ElevatedButton(onPressed: () {}, child: Text("Soğuk İçecek")),
          ElevatedButton(onPressed: () {}, child: Text("Kahve")),
          ElevatedButton(onPressed: () {}, child: Text("Tatlı")),
          ElevatedButton(onPressed: () {}, child: Text("Giriliecek")),
          ElevatedButton(onPressed: () {}, child: Text("Girilecek")),
        ],
      ),
    );
  }
*/