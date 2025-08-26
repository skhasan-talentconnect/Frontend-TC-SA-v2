import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tc_sa/common/index.dart' show SAppBar, SBottomBar;
import 'package:tc_sa/features/auth/authentication/presentation/auth_view.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<String> strings = ['Home', 'Blogs', 'Services', 'Saved'];
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: SAppBar(
        title: 'Raw Recruit',
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(Icons.menu),
        ),
      ),

      drawer: Drawer(),

      body: AuthView(),

      bottomNavigationBar: SBottomBar(
        onTap: (index) {
          setState(() {
            newIndex = index;
          });
        },
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize(
      serverClientId:
          '574038035729-6nlkp4a98fj3jdqkqlkub49asnskcnmh.apps.googleusercontent.com',
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    print(googleAuth.idToken);
  }
}
