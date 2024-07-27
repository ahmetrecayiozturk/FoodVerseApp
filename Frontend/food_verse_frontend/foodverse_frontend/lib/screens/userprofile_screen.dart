import 'package:flutter/material.dart';
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:foodverse_frontend/components/my_text_box.dart';
import 'package:foodverse_frontend/gpt/screens/gpt_queryscreen.dart';
import 'package:foodverse_frontend/screens/category_screen.dart';
import 'package:foodverse_frontend/screens/foodsave_screen.dart';
import 'package:foodverse_frontend/screens/addedfooddetail_screen.dart';
import 'package:foodverse_frontend/screens/showaddedfoods.dart';
import 'package:foodverse_frontend/screens/showsavedfoods.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';
import 'package:foodverse_frontend/services/auth_service.dart';

class UserProfileScreen extends StatefulWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Future<void> editField(String field) async {
    //editField
  }

  Future<void> updateEmail(String currentEmail) async {
    String? newEmail =
        await _showInputDialog(context, "Update Email", "Enter new email");
    if (newEmail != null && newEmail.isNotEmpty) {
      AuthService().updateEmail(currentEmail, newEmail);
    }
  }

  Future<String?> _showInputDialog(
      BuildContext context, String title, String hint) async {
    String? value;
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            onChanged: (val) {
              value = val;
            },
            decoration: InputDecoration(hintText: hint),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(value);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '        Profile Page',
          style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[900],
      ),
      drawer: MyDrawer(
        GoToGptPage: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GptQueryPage(),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToHomePage: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(user: widget.user),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToAddedFoods: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodSavePage(user: widget.user),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToSavedFoods: () async {
          try {
            String? userId = await FoodService().getUserId(widget.user.email);
            if (userId != null) {
              List<Food> savedFoods =
                  await FoodService().fetchFavoriteFoods(userId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedFoodsPage(foods: savedFoods),
                ),
              );
            }
          } catch (e) {
            print(e);
          }
        },
        GoToFilterFoods: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPage(
                  user: widget.user,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        LogOut: () {
          try {
            Navigator.pop(context); // Drawer'ı kapatmak için
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AuthScreen()));
          } catch (e) {
            print(e);
          }
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orange.shade400,
              Colors.deepOrange.shade400,
            ],
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Icon(
              Icons.person,
              size: 100,
              color: Colors.white,
            ),
            /*Text(user.email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),*/
            //user details
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'My Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            MyTextBox(
              text: 'mitchikko',
              sectionName: widget.user.email,
              onpressed: () => updateEmail(widget.user.email),
            ),
            MyTextBox(
              text: 'empty bio',
              sectionName: 'bio',
              onpressed: () => editField('bio'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        user: widget.user,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Food Filter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  String? userId =
                      await FoodService().getUserId(widget.user.email);
                  if (userId != null) {
                    List<Food> savedFoods =
                        await FoodService().fetchFavoriteFoods(userId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedFoodsPage(foods: savedFoods),
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: Text('Show Saved Foods'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<Food> addedFoods =
                      await FoodService().fetchAddedFoods(widget.user.email);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddedFoodsPage(foods: addedFoods),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: Text('Show Added Foods'),
            ),
          ],
        ),
      ),
    );
  }
}

/*----------------------çalışan4-----------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:foodverse_frontend/components/my_text_box.dart';
import 'package:foodverse_frontend/gpt/screens/gpt_queryscreen.dart';
import 'package:foodverse_frontend/screens/category_screen.dart';
import 'package:foodverse_frontend/screens/foodsave_screen.dart';
import 'package:foodverse_frontend/screens/addedfooddetail_screen.dart';
import 'package:foodverse_frontend/screens/showaddedfoods.dart';
import 'package:foodverse_frontend/screens/showsavedfoods.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';
import 'package:foodverse_frontend/services/auth_service.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);
  Future<void> editField(String field) async {
    //editField
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '        Profile Page',
          style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[900],
      ),
      drawer: MyDrawer(
        GoToGptPage: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GptQueryPage(),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToHomePage: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(user: user),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToAddedFoods: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodSavePage(user: user),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToSavedFoods: () async {
          try {
            String? userId = await FoodService().getUserId(user.email);
            if (userId != null) {
              List<Food> savedFoods =
                  await FoodService().fetchFavoriteFoods(userId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedFoodsPage(foods: savedFoods),
                ),
              );
            }
          } catch (e) {
            print(e);
          }
        },
        GoToFilterFoods: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPage(
                  user: user,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        LogOut: () {
          try {
            Navigator.pop(context); // Drawer'ı kapatmak için
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AuthScreen()));
          } catch (e) {
            print(e);
          }
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orange.shade400,
              Colors.deepOrange.shade400,
            ],
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Icon(
              Icons.person,
              size: 100,
              color: Colors.white,
            ),
            /*Text(user.email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),*/
            //user details
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'My Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            MyTextBox(
                text: 'mitchikko',
                sectionName: user.email,
                onpressed: () => AuthService().updateEmail(user.email,'name')),
            MyTextBox(
                text: 'empty bio',
                sectionName: 'bio',
                onpressed: () => editField('bio')),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                              (states) => Colors.red)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage(
                                  user: user,
                                )));
                  },
                  child: Text('Food Filter',
                      style: TextStyle(color: Colors.white))),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  String? userId = await FoodService().getUserId(user.email);
                  if (userId != null) {
                    List<Food> savedFoods =
                        await FoodService().fetchFavoriteFoods(userId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedFoodsPage(foods: savedFoods),
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: Text('Show Saved Foods'),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    List<Food> addedFoods =
                        await FoodService().fetchAddedFoods(user.email);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddedFoodsPage(foods: addedFoods),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: Text('Show Added Foods')),
          ],
        ),
      ),
    );
  }
}
*/




/*-----------------------çalışan3-------------------------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:foodverse_frontend/components/my_text_box.dart';
import 'package:foodverse_frontend/screens/showaddedfood_screen.dart';
import 'package:foodverse_frontend/screens/showaddedfoods.dart';
import 'package:foodverse_frontend/screens/showsavedfoods.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '        Profile Page',
          style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[900],
      ),
      drawer: MyDrawer(
        GoToAddedFoods: () async {
          try {
            List<Food> addedFoods =
                await FoodService().fetchAddedFoods(user.email);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddedFoodsPage(foods: addedFoods),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToSavedFoods: () async {
          try {
            String? userId = await FoodService().getUserId(user.email);
            if (userId != null) {
              List<Food> savedFoods =
                  await FoodService().fetchFavoriteFoods(userId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedFoodsPage(foods: savedFoods),
                ),
              );
            }
          } catch (e) {
            print(e);
          }
        },
        LogOut: () {
          try {
            Navigator.pop(context); // Drawer'ı kapatmak için
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AuthScreen()));
          } catch (e) {
            print(e);
          }
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orange.shade400,
              Colors.deepOrange.shade400,
            ],
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Icon(
              Icons.person,
              size: 100,
              color: Colors.black,
            ),
            Text(user.email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            //user details
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'My Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
            
              padding: const EdgeInsets.only(right: 250.0),
              child: MyTextBox(text: 'mitchikko', sectionName: 'username'),
            )
          ],
        ),
      ),
      /*body: Container(
        width: double.infinity,
        height: double.infinity,
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Icon(
                Icons.person,
                size: 100,
              ),
            ),
            Text(
              'KULLANICI ADI:    ${user.email}',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),*/
    );
  }
}
*/


 /*-------------------------çalışan2-------------------------------------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:foodverse_frontend/screens/showaddedfood_screen.dart';
import 'package:foodverse_frontend/screens/showaddedfoods.dart';
import 'package:foodverse_frontend/screens/showsavedfoods.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '        Profile Page',
          style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange[900],
      ),
      drawer: MyDrawer(
        GoToAddedFoods: () async {
          try {
            List<Food> addedFoods =
                await FoodService().fetchAddedFoods(user.email);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddedFoodsPage(foods: addedFoods),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToSavedFoods: () async {
          try {
            String? userId = await FoodService().getUserId(user.email);
            if (userId != null) {
              List<Food> savedFoods =
                  await FoodService().fetchFavoriteFoods(userId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedFoodsPage(foods: savedFoods),
                ),
              );
            }
          } catch (e) {
            print(e);
          }
        },
        LogOut: () {
          try {
            Navigator.pop(context); // Drawer'ı kapatmak için
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AuthScreen()));
          } catch (e) {
            print(e);
          }
        },
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 150.0),
              child: Icon(
                Icons.person,
                size: 100,
              ),
            ),
            Text(
              'KULLANICI ADI:    ${user.email}',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddorFilterPage(user: user),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text('Click for add food, filter food or ask gpt'),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () async {
                try {
                  String? userId = await FoodService().getUserId(user.email);
                  if (userId != null) {
                    List<Food> savedFoods =
                        await FoodService().fetchFavoriteFoods(userId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedFoodsPage(foods: savedFoods),
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text(
                  '                        Show Saved Foods                        '),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<Food> addedFoods =
                      await FoodService().fetchAddedFoods(user.email);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddedFoodsPage(foods: addedFoods),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text(
                  '                        Show Added Foods                        '),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*------------------drawer kullandığım çalışan1-------------------------
import 'package:flutter/material.dart';
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:foodverse_frontend/screens/showaddedfood_screen.dart';
import 'package:foodverse_frontend/screens/showaddedfoods.dart';
import 'package:foodverse_frontend/screens/showsavedfoods.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';

import 'package:foodverse_frontend/services/food_service.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  /*
  void goToProfilePage() {
    //pop the menu drawer
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthScreen()));
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '                User Profile',
          style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      drawer: MyDrawer(
        GoToAddedFoods: () async {
          try {
            List<Food> addedFoods =
                await FoodService().fetchAddedFoods(user.email);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddedFoodsPage(foods: addedFoods),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        GoToSavedFoods: () async {
          try {
            String? userId = await FoodService().getUserId(user.email);
            if (userId != null) {
              List<Food> savedFoods =
                  await FoodService().fetchFavoriteFoods(userId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedFoodsPage(foods: savedFoods),
                ),
              );
            }
          } catch (e) {
            print(e);
          }
        },
        LogOut: () {
          try {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AuthScreen()));
          } catch (e) {
            print(e);
          }
        },
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'KULLANICI ADI:    ${user.email}',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddorFilterPage(user: user),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text('Click for add food, filter food or ask gpt'),
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: () async {
                try {
                  String? userId = await FoodService().getUserId(user.email);
                  if (userId != null) {
                    List<Food> savedFoods =
                        await FoodService().fetchFavoriteFoods(userId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedFoodsPage(foods: savedFoods),
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text(
                  '                        Show Saved Foods                        '),
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<Food> addedFoods =
                      await FoodService().fetchAddedFoods(user.email);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddedFoodsPage(foods: addedFoods),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text(
                  '                        Show Added Foods                        '),
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
import 'package:foodverse_frontend/components/drawer.dart';
import 'package:foodverse_frontend/screens/showaddedfood_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodverse_frontend/screens/addfilteroraskgpt_screen.dart';
import 'package:foodverse_frontend/screens/auth_screen.dart';
import 'package:foodverse_frontend/screens/savedfooddetail_screen.dart';
import 'package:foodverse_frontend/services/food_service.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  void _showSavedFoodsDialog(BuildContext context, List<Food> foods) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Saved Foods'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: foods.map((food) {
                return ListTile(
                  title: Text(food.name),
                  subtitle: Text(food.ingredients.join(', ')),
                  onTap: () {
                    Navigator.of(context).pop();
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

  void _showAddedFoodsDialog(BuildContext context, List<Food> foods) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Added Foods'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: foods.map((food) {
                return ListTile(
                  title: Text(food.name),
                  subtitle: Text(food.ingredients.join(', ')),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowAddedFoodDetailPage(
                          name: food.name,
                          ingredients: food.ingredients,
                          preparing: food.preparing ?? '',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '                User Profile',
          style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      drawer: MyDrawer(
        
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'KULLANICI ADI:    ${user.email}',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddorFilterPage(user: user),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text('Click for add food, filter food or ask gpt'),
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: () async {
                try {
                  String? userId = await FoodService().getUserId(user.email);
                  if (userId != null) {
                    List<Food> savedFoods =
                        await FoodService().fetchFavoriteFoods(userId);
                    _showSavedFoodsDialog(context, savedFoods);
                  }
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text(
                  '                        Show Saved Foods                        '),
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: () async {
                try {
                  //String? userId = await FoodService().getUserId(user.email);
                  List<Food> addedFoods =
                      await FoodService().fetchAddedFoods(user.email);
                  _showAddedFoodsDialog(context, addedFoods);
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: Text(
                  '                        Show Added Foods                        '),
            ),
          ],
        ),
      ),
    );
  }
}

*/