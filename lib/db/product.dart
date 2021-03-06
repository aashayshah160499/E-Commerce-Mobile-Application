import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class ProductService{
  Firestore _firestore = Firestore.instance;
  String ref = 'Products';
  void uploadProduct(Map<String, dynamic> data){
    var id = Uuid();
    String productId = id.v1();
    data["id"] = productId;
    _firestore.collection(ref).document(productId).setData(data);
  }

  void uploadToCart(Map<String, dynamic> data){
    var id = Uuid();
    String productId = id.v1();
    data["id"] = productId;
    _firestore.collection('Cart').document(productId).setData(data);
  }

  void uploadToFavorites(Map<String, dynamic> data){
    var id = Uuid();
    String productId = id.v1();
    data["id"] = productId;
    _firestore.collection('Favorite').document(productId).setData(data);
  }
}