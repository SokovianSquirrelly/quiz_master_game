import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

Future<Database> useDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  var db = await openDatabase('data.db');

  final database = openDatabase('data.db',
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      'CREATE TABLE IF NOT EXISTS save(save_id INTEGER PRIMARY KEY NOT NULL, correct_answers INTEGER NOT NULL, wrong_answers INTEGER NOT NULL, event_id INTEGER NOT NULL, science_event INT DEFAULT 0 NOT NULL, math_event INT DEFAULT 0 NOT NULL, geography_event INT DEFAULT 0 NOT NULL, spelling_event INT DEFAULT 0 NOT NULL, programming_event INT DEFAULT 0 NOT NULL);'
          'CREATE TABLE IF NOT EXISTS event(event_id INTEGER PRIMARY KEY NOT NULL);'
          'CREATE TABLE IF NOT EXISTS question(question_id INTEGER PRIMARY KEY NOT NULL, question_number INTEGER NOT NULL, question_text VARCHAR(255) NOT NULL, question_subject VARCHAR(255) NOT NULL, event_id INTEGER NOT NULL);'
          'CREATE TABLE IF NOT EXISTS story(story_id INTEGER PRIMARY KEY NOT NULL, event_id INTEGER NOT NULL, story_string VARCHAR(255) NOT NULL);'
          'CREATE TABLE IF NOT EXISTS answer(answer_id INTEGER PRIMARY KEY NOT NULL, event_id INTEGER NOT NULL, answer_string VARCHAR(255) NOT NULL, is_correct TINYINT NOT NULL);'
          'INSERT IGNORE INTO answer (answer_id, event_id, answer_string, is_correct)'
            'VALUES'
	          '(1, 1, "a", 1),'
            '(2, 1, "b", 0),'
            '(3, 1, "c", 0),'
            '(4, 2, "d", 1),'
            '(5, 2, "e", 0),'
            '(6, 2, "g", 0);'
    
          'INSERT IGNORE INTO story (story_id, event_id, story_string)'
            'VALUES'
	            '(1, 2, "f");'
    
          'INSERT IGNORE INTO event (event_id)'
            'VALUES'
	            '(1),'
              '(2);'
    
          'INSERT IGNORE INTO question (question_id, question_number, question_text, question_subject, event_id)'
            'VALUES'
	            '(1, 1, "What is the first letter of the Alphabet?", "spelling", 1);',
    );

  },
      version: 1,
  );

  return database;
}

Future closeDatabase(database) async {
  await database.close;
}

Future<void> insertSave(Save save) async {
    // Get a reference to the database.
    final db = await useDatabase();

    await db.insert(
      'save',
      save.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    closeDatabase(db);
}


Future<List<Save>> getSaves(db) async {
    // Query the table for saves.
    final List<Map<String, dynamic>> maps = await db.query('save');

    // Convert the List<Map<String, dynamic> into a List<Save>.
    return List.generate(maps.length, (i) {
      return Save(
        save_id: maps[i]['save_id'],
        correct_answers: maps[i]['correct_answers'],
        wrong_answers: maps[i]['wrong_answers'],
        event_id: maps[i]['event_id'],
        science_event: 0,
        math_event: 0,
        geography_event: 0,
        spelling_event: 0,
        programming_event: 0,
      );
    });
    
  }

Future<List<EventText>> getEventInfo(db, eventID) async {
  // Query the table for question associated with an event.
  final List<Map> maps = await db.rawQuery("SELECT ifnull(q.question_text, "0"), ifnull(a1.answer_string,0) AS answer1, ifnull(a2.answer_string,0) AS answer2, ifnull(a3.answer_string, 0) AS answer3, ifnull(s.story_string, "0")"
  "FROM event e"
	  "LEFT JOIN question q on q.event_id = e.event_id"
	  "LEFT JOIN answer a1 ON e.event_id = a1.event_id"
	  "LEFT JOIN answer a2 ON e.event_id = a2.event_id"
	  "LEFT JOIN answer a3 ON e.event_id = a3.event_id"
	  "LEFT JOIN story s ON e.event_id = s.event_id"
  "WHERE e.event_id = 2 AND a1.is_correct = 1 AND a2.answer_id < a3.answer_id AND NOT a2.answer_id = a1.answer_id AND NOT a2.answer_id = a1.answer_id"
  "LIMIT 1;", [eventID]);
  // Convert the List<Map<String, dynamic> into a List<EventText>.
  return List.generate(maps.length, (i) {
    return EventText(
      question: maps[i]['question_text'],
      answer1: maps[i]['answer1'],
      answer2: maps[i]['answer2'],
      answer3: maps[i]['answer3'],
      story: maps[i]['story_text'],
    );
  });
  
}



  // print(await getSaves());

Future<List<EventText>> getText(subject) async{
  final db = await useDatabase();
  List<Save> currSave = await getSaves(db);
  List<EventText> eventText = <EventText>[];
  if (subject == "science")
    {
      int eventID = currSave[0].science_event;
      eventText = await getEventInfo(db, eventID);
    }
  else if (subject == "math")
  {
    int eventID = currSave[0].math_event;
    eventText = await getEventInfo(db, eventID);
  }
  else if (subject == "geography")
  {
    int eventID = currSave[0].geography_event;
    eventText = await getEventInfo(db, eventID);
  }
  else if (subject == "spelling")
  {
    int eventID = currSave[0].spelling_event;
    eventText = await getEventInfo(db, eventID);
  }
  else if (subject == "programming")
  {
    int eventID = currSave[0].spelling_event;
    eventText = await getEventInfo(db, eventID);
  }
    
  await closeDatabase(db);
  return eventText;
}

  var save = const Save(
    save_id: 1,
    correct_answers: 0,
    wrong_answers: 0,
    event_id: 0,
    science_event: 0,
    math_event: 0,
    geography_event: 0,
    spelling_event: 0,
    programming_event: 0,
  );
  // await insertSave(save);
  //
  // await db.close();




class Save {
  final int save_id;
  final int correct_answers;
  final int wrong_answers;
  final int event_id;
  final int science_event;
  final int math_event;
  final int geography_event;
  final int spelling_event;
  final int programming_event;

  const Save({
    required this.save_id,
    required this.correct_answers,
    required this.wrong_answers,
    required this.event_id,
    required this.science_event,
    required this.math_event,
    required this.geography_event,
    required this.spelling_event,
    required this.programming_event,
  });

  Map<String, dynamic> toMap() {
    return {
      'save_id': save_id,
      'correct_answers': correct_answers,
      'wrong_answers': wrong_answers,
      'event_id': event_id,
      'science_complete': science_event,
      'math_complete': math_event,
      'geography_complete': geography_event,
      'spelling_complete': spelling_event,
      'programming_complete': programming_event,
    };
  }

  @override
  String toString() {
    return 'Save{save_id: $save_id, correct_answers: $correct_answers, wrong_answers: $wrong_answers, event_id: $event_id, science_event: $science_event, math_event: $math_event, geography_event: $geography_event, spelling_event: $spelling_event, programming_event: $programming_event}';
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
  final int event_id;
  final String answer_string;
  final int is_correct;

  const Answer({
    required this.answer_id,
    required this.event_id,
    required this.answer_string,
    required this.is_correct,
  });

  Map<String, dynamic> toMap() {
    return {
      'answer_id': answer_id,
      'event_id': event_id,
      'answer_string': answer_string,
      'is_correct': is_correct,
    };
  }

  @override
  String toString() {
    return 'Answer{answer_id: $answer_id, event_id: $event_id, answer_string: $answer_string}, is_correct $is_correct';
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

class EventText {
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;  
  final String story;

  const EventText({
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.story,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer1': answer1,
      'answer2': answer2,
      'answer3': answer3,
      'story': story,
    };
  }

  @override
  String toString() {
    return 'EventText{question: $question, answer1: $answer1, answer2: $answer2, answer3: $answer3, story: $story}';
  }
}
