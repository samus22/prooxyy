import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prooxyy_events/models/user.dart';
import 'package:prooxyy_events/services/dao.dart';

// -- Firebase Authentication
import 'package:firebase_auth/firebase_auth.dart';

// -- Social Auth
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserService implements AuthRepo, Dao<UserData> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference _collection =
      FirebaseFirestore.instance.collection('bookings');
  // .withConverter<User>(
  //   fromFirestore: (snapshots, _) => User.fromMap(snapshots.data()!),
  //   toFirestore: (user, _) => user.toMap()
  // );

  DocumentReference? _documentReference;

  @override
  void login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  // TODO: implement COLLECTION
  String get COLLECTION => throw UnimplementedError();

  @override
  Future<void> add(entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<DocumentReference> get(String id) async {
    return _collection.doc();
  }

  @override
  Future<Query> getAll() async {
    return _collection.startAt([]);
  }

  @override
  Future update(String id, entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  void register(UserData newUser) async {
    try {
      // -- Create account on firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: newUser.email, password: newUser.password);

      // -- Addition of the user in the database
      this.add(newUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void resetPassword() {
    // TODO: implement resetPassword
  }

  @override
  void forgotPassword() {
    // TODO: implement forgotPassword
  }

  @override
  Future<QuerySnapshot<Object?>> getAllAsSnapshot() {
    // TODO: implement getAllAsSnapshot
    throw UnimplementedError();
  }

  @override
  Future<DocumentSnapshot<Object?>> getAsSnapshot(String id) {
    // TODO: implement getAsSnapshot
    throw UnimplementedError();
  }

  Stream<User?> authenticationState() {
    return _auth.authStateChanges();
  }
}

class UserService2 {
  UserService2._();
  static UserService2 get instance => UserService2._();

  CollectionReference _db = FirebaseFirestore.instance.collection('users');

  FirebaseAuth _auth = FirebaseAuth.instance;

  // -- Authentication
  Future<UserCredential> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// Creates an account for a new user based on the supplied email address and password
  void signUp(
      String email, String password, String firstName, String lastName) {
    try {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((registeredUser) {
        UserData newUser = new UserData(
            id: registeredUser.user?.uid ?? '',
            lastName: lastName,
            firstName: firstName,
            blocked: false,
            email: registeredUser.user?.email ?? '',
            facebookLink: '',
            whatsappNumber: '',
            instagramLink: '',
            numTel: registeredUser.user?.phoneNumber ?? '',
            profileUrl: registeredUser.user?.photoURL ?? '',
            nomPrenom: registeredUser.user?.displayName ?? '',
            password: '',
            serverId: '');

        this.add(newUser);
      });
    } catch (e) {
      print("Error");
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  bool isLogged() {
    User? u = _auth.currentUser;
    if (u != null) {
      return true;
    }
    return false;
  }

  Stream<User?> authState() {
    return _auth.authStateChanges();
  }

  /// Get the currently connected user
  User? currentUser() {
    return _auth.currentUser;
  }

  /// Retrieve the data of the user
  Future<UserData?> getUserData(String userId) async {
    User? u = _auth.currentUser;
    if (u != null) {
      DocumentSnapshot doc = await _db.doc(u.uid).get();
      return UserData.fromMap2(doc);
    }
    return null;
  }

  // - Social Auth
  // --> Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // --> Facebook
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  // --> Phone Number
  Future verifyPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // -- Database CRUD
  Future<void> add(UserData user) async {
    Map<String, dynamic> userDataMap = user.toMap();
    String id = user.id;
    userDataMap.remove('id');
    return _db
        .doc(id)
        .set(userDataMap)
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<DocumentSnapshot> getAsSnapShot(String documentId) async {
    return _db.doc(documentId).get();
  }

  Future<QuerySnapshot> getAllAsSnapshot() async {
    return _db.get();
  }

  @override
  Future<void> delete(String id) {
    return _db.doc(id).delete();
  }

  @override
  Future<void> update(String id, UserData entity) {
    Map<String, dynamic> userDataMap = entity.toMap();
    String id = entity.id;
    userDataMap.remove('id');
    return _db.doc(id).update(userDataMap);
  }

  String get COLLECTION => throw UnimplementedError();

  DocumentReference get(String id) {
    return _db.doc(id);
  }

  Future<QuerySnapshot> getAll() {
    return _db.get();
  }

  Future<DocumentSnapshot> getAsSnapshot(String id) {
    return _db.doc(id).get();
  }

  Future<void> putAsFavorite(String userId, String bookingId) {
    return getUserData(userId).then((value) {
      UserData? userData = value;
      if (userData != null) {
        userData.listeFavoris.add(bookingId);
        update(userId, userData);
      }
    }).catchError((error) {
      print('Erreur lors de ajout en favoris');
    });
  }

  Future<void> removeAsFavorite(String userId, String bookingId) {
    return getUserData(userId).then((value) {
      UserData? userData = value;
      if (userData != null) {
        int index = userData.listeFavoris.indexOf(bookingId);
        userData.listeFavoris.remove(index);
        update(userId, userData);
      }
    }).catchError((error) {
      print('Erreur lors de ajout en favoris $error');
    });
  }

}
