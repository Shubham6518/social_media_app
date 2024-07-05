import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/models/post.dart';
import 'package:flutter_instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPosts(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postUrl: photoUrl,
          postId: postId,
          datePublished: DateTime.now(),
          profImage: profImage,
          likes: []);

      _firestore
          .collection('posts')
          .doc(postId)
          .set(post.toJson() as Map<String, dynamic>);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
