import 'package:firebase_database/firebase_database.dart';
import 'package:quiz_app/database_service/user_score.dart';

class Database {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  Future<void> create({required String path, required String data}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.set(data);
  }

  Future<DataSnapshot?> read({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }

  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.update(data);
  }

  Future<void> delete(String path) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.remove();
  }

  Future<String> createScore({required UserScore score}) async {
    final DatabaseReference ref = _firebaseDatabase
        .ref()
        .child('scores')
        .push();
    await ref.set(score.toJson());
    return ref.key!;
  }

  Future<List<UserScore>> getAllScores() async {
    final DatabaseReference ref = _firebaseDatabase.ref().child('scores');
    final query = ref.orderByChild('score');
    final DataSnapshot snapshot = await query.get();

    if (!snapshot.exists) return [];

    final List<UserScore> scoresList = [];
    final Map<dynamic, dynamic> scores =
        snapshot.value as Map<dynamic, dynamic>;

    scores.forEach((key, value) {
      scoresList.add(UserScore.fromJson(key, value as Map<dynamic, dynamic>));
    });

    scoresList.sort((a, b) => b.score.compareTo(a.score));

    return scoresList;
  }
}
