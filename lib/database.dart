import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

/* 
Use this file to intereact with the database.
Import the file to the file needing to access
the classes or function contained within like
import 'database.dart'

The updateSave() and getText() functions are 
the main functions to call to update the save
file and get the text needing to be displayed
respectively.

To use the updateSave function, it just needs
to be called. It will iterate the current
event_id in the save file and the number that
matches with the associated subject.

To use the getText function, it needs to be
called with a string matching the subject of
questions that has been chosen or 'continue'
if the player is picking up where they left
off.

The getText function will return an EventText
item, the class of which is located below the
functions in this file. It will return the
text for the question, the answers associated,
and any story text associated. The first answer
returned will always be the correct answer for
the question.
*/
// Functions for external use
Future updateSave() async {
  final db = await useDatabase();
  List<Save> saves = await getSaves(db);
  Save save = saves[0];
  if (save.event_id == save.science_event)
  {
    save.science_event += 1;
  }
  else if (save.event_id == save.math_event)
  {
    save.math_event += 1;
  }
  else if (save.event_id == save.geography_event)
  {
    save.geography_event += 1;
  }
  else if (save.event_id == save.programming_event)
  {
    save.programming_event += 1;
  }
  else if (save.event_id == save.spelling_event)
  {
    save.spelling_event += 1;
  }
  save.event_id += 1;

  await db.update(
    'save',
    save.toMap(),
    where: 'id = ?',
    whereArgs: [save.save_id],
  );
  await closeDatabase(db);
}

Future<EventText> getText(subject) async{
  final db = await useDatabase();
  List<Save> currSave = await getSaves(db);
  List<EventText> eventText = <EventText>[];
  int eventID =  currSave[0].event_id;
  if (subject == "science")
  {
    eventID = currSave[0].science_event;
    eventText = await getEventInfo(db, eventID);
  }
  else if (subject == "math")
  {
    eventID = currSave[0].math_event;
    eventText = await getEventInfo(db, eventID);
  }
  else if (subject == "geography")
  {
    eventID = currSave[0].geography_event;
    eventText = await getEventInfo(db, eventID);
  }
  else if (subject == "spelling")
  {
    eventID = currSave[0].spelling_event;
    eventText = await getEventInfo(db, eventID);
  }
  else if (subject == "programming")
  {
    eventID = currSave[0].programming_event;
    eventText = await getEventInfo(db, eventID);
  }
  else if (subject == "continue")
  {
    eventText = await getEventInfo(db, eventID);
  }
  Save save = currSave[0];
  save.event_id = eventID;
  await db.update(
    'save',
    save.toMap(),
    where: 'id = ?',
    whereArgs: [save.save_id],
  );

  await closeDatabase(db);
  return eventText[0];
}

// EventText Class, not associated with a
// table in the database, returns 5 strings.
// Items can be accessed from the object
// like EventText.question
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


// Functions for internal use
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
              '(1, 1, "What is the first letter of the Alphabet?", "spelling", 1);'

              'INSERT IGNORE INTO save (save_id, correct_answers, wrong_answers, event_id, science_event, math_event, geography_event, spelling_event, programming_event)'
              'VALUES'
              '(1, 0, 0, 1, 1, 21, 41, 61, 81)'
      );

    },
    version: 1,
  );

  return database;
}

Future closeDatabase(database) async {
  await database.close;
}

Future insertSave(Save save) async {
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
      science_event: maps[i]['science_event'],
      math_event: maps[i]['math_event'],
      geography_event: maps[i]['geography_event'],
      spelling_event: maps[i]['spelling_event'],
      programming_event: maps[i]['programming_event'],
    );
  });

}

Future<List<EventText>> getEventInfo(db, eventID) async {
  // Query the table for question associated with an event.
  final List<Map> maps = await db.rawQuery("SELECT ifnull(q.question_text, \"0\"), ifnull(a1.answer_string,0) AS answer1, ifnull(a2.answer_string,0) AS answer2, ifnull(a3.answer_string, 0) AS answer3, ifnull(s.story_string, \"0\")"
      "FROM event e"
      "LEFT JOIN question q on q.event_id = e.event_id"
      "LEFT JOIN answer a1 ON e.event_id = a1.event_id"
      "LEFT JOIN answer a2 ON e.event_id = a2.event_id"
      "LEFT JOIN answer a3 ON e.event_id = a3.event_id"
      "LEFT JOIN story s ON e.event_id = s.event_id"
      "WHERE e.event_id = ? AND a1.is_correct = 1 AND a2.answer_id < a3.answer_id AND NOT a2.answer_id = a1.answer_id AND NOT a2.answer_id = a1.answer_id"
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


// Table Classes
class Save {
  final int save_id;
  final int correct_answers;
  final int wrong_answers;
  int event_id;
  int science_event;
  int math_event;
  int geography_event;
  int spelling_event;
  int programming_event;

  Save({
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
