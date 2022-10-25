import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

Future usingDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  var db = await openDatabase('database.dart');

  final database = openDatabase('database.dart',
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      'CREATE TABLE IF NOT EXISTS save(save_id INTEGER PRIMARY KEY, correct_answers INTEGER, wrong_answers INTEGER, event_id INTEGER);'
          // 'CREATE TABLE IF NOT EXISTS event(event_id INTEGER);'
          'CREATE TABLE IF NOT EXISTS question(question_id INTEGER PRIMARY KEY, question_number INTEGER, question_text STRING, question_subject STRING, event_id INTEGER);'
          'CREATE TABLE IF NOT EXISTS story(story_id INTEGER PRIMARY KEY, event_id INTEGER, story_string STRING);'
          'CREATE TABLE IF NOT EXISTS answer(answer_id INTEGER PRIMARY KEY, question_id INTEGER, answer_string STRING);',
    );

  },
      version: 1,
  );

  Future<void> insertSave(Save save) async {
    // Get a reference to the database.
    final db = await database;

    await db.insert(
      'save',
      save.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  var save = const Save(
    save_id: 1,
    correct_answers: 0,
    wrong_answers: 0,
    event_id: 0,
  );

  Future<List<Save>> saves() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('save');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Save(
        save_id: maps[i]['save_id'],
        correct_answers: maps[i]['correct_answers'],
        wrong_answers: maps[i]['wrong_answers'],
        event_id: maps[i]['event_id'],
      );
    });
  }

  // print(await saves());

  await insertSave(save);

  await db.close();
}



class Save {
  final int save_id;
  final int correct_answers;
  final int wrong_answers;
  final int event_id;

  const Save({
    required this.save_id,
    required this.correct_answers,
    required this.wrong_answers,
    required this.event_id,
});

  Map<String, dynamic> toMap() {
    return {
      'save_id': save_id,
      'correct_answers': correct_answers,
      'wrong_answers': wrong_answers,
      'event_id': event_id,
    };
  }

  @override
  String toString() {
    return 'Save{save_id: $save_id, correct_answers: $correct_answers, wrong_answers: $wrong_answers, event_id: $event_id}';
  }
}

class Event {
  final int event_id;

  const Event({
    required this.event_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'event_id': event_id,
    };
  }

  @override
  String toString() {
    return 'Event{event_id: $event_id}';
  }
}

class Question {
  final int question_id;
  final int question_number;
  final String question_text;
  final String question_subject;
  final int event_id;

  const Question({
    required this.question_id,
    required this.question_number,
    required this.question_text,
    required this.question_subject,
    required this.event_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'questions_id': question_id,
      'questions_number': question_number,
      'question_text': question_text,
      'question_subject': question_subject,
      'event_id': event_id,
    };
  }

  @override
  String toString() {
    return 'Questions{question_id: $question_id, question_number: $question_number, question_text: $question_text, question_subject: $question_subject, event_id: $event_id}';
  }
}

class Answer {
  final int answer_id;
  final int question_id;
  final String answer_string;

  const Answer({
    required this.answer_id,
    required this.question_id,
    required this.answer_string,
  });

  Map<String, dynamic> toMap() {
    return {
      'answer_id': answer_id,
      'question_id': question_id,
      'answer_string': answer_string,
    };
  }

  @override
  String toString() {
    return 'Answer{answer_id: $answer_id, question_id: $question_id, answer_string: $answer_string}';
  }
}

class Story {
  final int story_id;
  final int event_id;
  final String story_string;

  const Story({
    required this.story_id,
    required this.event_id,
    required this.story_string,
  });

  Map<String, dynamic> toMap() {
    return {
      'story_id': story_id,
      'event_id': event_id,
      'story_string': story_string,
    };
  }

  @override
  String toString() {
    return 'Story{save_id: $story_id, event_id: $event_id, story_string: $story_string}';
  }
}
