import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';

class TodoServices {
  Future<void> addTask(
      String title, String description, String dateTime) async {
    final user = FirebaseAuth.instance.currentUser;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email!)
        .collection('tasks')
        .doc();
    final task = Task(
      id: docRef.id,
      title: title,
      description: description,
      date: dateTime,
      completed: false,
    );
    final json = task.toJson();

    await docRef.set(json);
  }

  Future<void> updateTask({
    required String id,
    required String title,
    required String description,
    required String date,
    required bool completed,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email!)
        .collection('tasks')
        .doc(id);
    final task = Task(
        id: docRef.id,
        title: title,
        description: description,
        date: date,
        completed: completed);
    final json = task.toJson();
    await docRef.update(json);
  }

  Future<void> deleteTaskById(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email!)
        .collection('tasks')
        .doc(id);
    await docRef.delete();
  }

  Stream<List<Task>>? fetchTasks() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('tasks')
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Task.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );
    }
    return null;
  }
}
