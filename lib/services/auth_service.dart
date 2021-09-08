import 'package:brew_crew/models/client.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based in firebaseUser

  Client _userFromFirebaseUser(User user) {
    return Client(uuid: user.uid);
  }

  //auth change user stream
  Stream<Client> get client => _auth.authStateChanges().map((User? user) {
        if (user == null) {
          return Client(uuid: '');
        } else {
          return _userFromFirebaseUser(user);
        }
      });

  //sign in anon
  Future sinInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in email & password

  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return "null";
    }
  }

//register wih email & password
  Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      // create a new document for the user with the uuid

      await DataBaseService(user!.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);

    } catch (e) {
      print(e.toString());
      return "null";
    }
  }
//sign out
  Future signOut() async {
    return await _auth.signOut();
  }
}
