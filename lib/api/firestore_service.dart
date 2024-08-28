import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipe_app/model/food_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      {required String email,
      required String name,
      required String uid}) async {
    firestore
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name, 'uid': uid});
  }

  Future<void> updateUser(String email, String name) async {
    firestore
        .collection('users')
        .doc('')
        .update({'email': email, 'name': name});
  }

  Future<void> addToCookbook(
      {required String uid, required FoodModel foodModel}) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection('cook_book')
        .add(foodModel.toJson());
  }

  Future<void> deleteFromCookbook(
  {required String uid, required FoodModel foodModel}
      ) async{

  }
}
