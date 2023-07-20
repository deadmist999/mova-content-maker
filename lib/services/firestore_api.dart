import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {
  final CollectionReference<Map<String, dynamic>> _quizCollection =
      FirebaseFirestore.instance.collection('quiz');

  final CollectionReference<Map<String, dynamic>> _postCollection =
      FirebaseFirestore.instance.collection('post');

  Future<void> addQuizToFirestore(
      String question, Map<String, bool> options, String? explanation) async {
    _quizCollection.doc('init_quiz').update({
      'quiz_list:': FieldValue.arrayUnion([
        {
          'question': question,
          'options': options,
          'explanation': explanation,
        }
      ]),
    });
  }

  Future<void> addPostToFirestore(String? imageUrl, String text) async {
    _postCollection.doc('init_post').update({
      'post_list:': FieldValue.arrayUnion([
        {
          'image': imageUrl,
          'text': text,
        }
      ]),
    });
  }
}
