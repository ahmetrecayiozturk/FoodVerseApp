import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedFoodDetailPage extends StatelessWidget {
  final String name;
  final List<String> ingredients;
  final String preparing;

  const SavedFoodDetailPage({
    Key? key,
    required this.name,
    required this.ingredients,
    required this.preparing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: GoogleFonts.lato(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        color: Colors.orange,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Ingredients',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[900],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade200,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        ingredients[index],
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      leading: Icon(Icons.check_circle_outline,
                          color: Colors.orange[900]),
                      onTap: () {
                        // Handle ingredient tap
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Preparation',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[900],
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.orange.shade50,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    preparing,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange[900],
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    textStyle: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Start Cooking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedFoodDetailPage extends StatelessWidget {
  final String name;
  final List<String> ingredients;
  final String preparing;

  const SavedFoodDetailPage({
    Key? key,
    required this.name,
    required this.ingredients,
    required this.preparing,
  }) : super(key: key);

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
        child: SingleChildScrollView(
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
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      ingredients[index],
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: Icon(Icons.check_box_outline_blank,
                        color: Colors.black),
                    onTap: () {
                      // Handle ingredient tap
                    },
                  );
                },
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
              Card(
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
              SizedBox(height: 20),
              // Optionally add a button here if needed
            ],
          ),
        ),
      ),
    );
  }
}
*/