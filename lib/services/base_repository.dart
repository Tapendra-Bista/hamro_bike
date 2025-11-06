import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Base Repository for Firebase Services
class BaseRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get auth => _firebaseAuth;
  String? get userId => _firebaseAuth.currentUser?.uid;
}
