import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

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
  if (save.event_id == save.science_event) {
    save.science_event += 1;
  } else if (save.event_id == save.math_event) {
    save.math_event += 1;
  } else if (save.event_id == save.geography_event) {
    save.geography_event += 1;
  } else if (save.event_id == save.programming_event) {
    save.programming_event += 1;
  } else if (save.event_id == save.spelling_event) {
    save.spelling_event += 1;
  }
  save.event_id += 1;

  await db.update(
    'save',
    save.toMap(),
    where: 'save_id = ?',
    whereArgs: [save.save_id],
  );
  await closeDatabase(db);
}

Future<EventText> getText(subject) async {
  final db = await useDatabase();
  List<Save> currSave = await getSaves(db);
  var eventText = new EventText(
      question: "a", answer1: "a", answer2: "a", answer3: "a", story: "a");
  int eventID = currSave[0].event_id;
  if (subject == "science") {
    eventID = currSave[0].science_event;
    eventText = await getEventInfo(db, eventID);
  } else if (subject == "math") {
    eventID = currSave[0].math_event;
    eventText = await getEventInfo(db, eventID);
  } else if (subject == "geography") {
    eventID = currSave[0].geography_event;
    eventText = await getEventInfo(db, eventID);
  } else if (subject == "spelling") {
    eventID = currSave[0].spelling_event;
    eventText = await getEventInfo(db, eventID);
  } else if (subject == "programming") {
    eventID = currSave[0].programming_event;
    eventText = await getEventInfo(db, eventID);
  } else if (subject == "continue") {
    eventText = await getEventInfo(db, eventID);
  }
  Save save = currSave[0];
  save.event_id = eventID;
  await db.update(
    'save',
    save.toMap(),
    where: 'save_id = ?',
    whereArgs: [save.save_id],
  );

  await closeDatabase(db);
  return eventText;
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

  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'data.db');

  // Delete the database
  await deleteDatabase(path);

  // var db = await openDatabase('data.db');

  // open the database
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        'CREATE TABLE IF NOT EXISTS save(save_id INTEGER PRIMARY KEY NOT NULL, correct_answers INTEGER NOT NULL, wrong_answers INTEGER NOT NULL, event_id INTEGER NOT NULL, science_event INT DEFAULT 0 NOT NULL, math_event INT DEFAULT 0 NOT NULL, geography_event INT DEFAULT 0 NOT NULL, spelling_event INT DEFAULT 0 NOT NULL, programming_event INT DEFAULT 0 NOT NULL);');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS events(event_id INTEGER PRIMARY KEY NOT NULL);');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS question(question_id INTEGER PRIMARY KEY NOT NULL, question_number INTEGER NOT NULL, question_text VARCHAR(255) NOT NULL, question_subject VARCHAR(255) NOT NULL, event_id INTEGER NOT NULL);');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS story(story_id INTEGER PRIMARY KEY NOT NULL, event_id INTEGER NOT NULL, story_string VARCHAR(255) NOT NULL);');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS answer(answer_id INTEGER PRIMARY KEY NOT NULL, event_id INTEGER NOT NULL, answer_string VARCHAR(255) NOT NULL, is_correct TINYINT NOT NULL);');
  });
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
        'INSERT OR IGNORE INTO answer(answer_id, event_id, answer_string, is_correct) '
        'VALUES '
            '(1, 1, \'118\', 1),'
            '(4, 2, \'Liquid, Solid, Gas\', 1),'
            '(7, 3, \'Cumulus\', 1),'
            '(10, 4, \'Uranium\', 1),'
            '(13, 5, \'Mitochondria\', 1),'
            '(16, 6, \'Remains of life that have been naturally preserved\', 1),'
            '(19, 7, \'Liquid Iron and Nickel\', 1),'
            '(22, 8, \'Warm humid air collides with air that is cool and dry\', 1),'
            '(25, 9, \'Correct\', 1),'
            '(28, 10, \'When there is an earthquake in the ocean \', 1),'
            '(31, 11, \'Correct\', 1),'
            '(34, 12, \'Correct\', 1),'
            '(37, 13, \'Bromine and Mercury\', 1),'
            '(40, 14, \'Correct\', 1),'
            '(43, 15, \'Mass / Volume\', 1),'
            '(46, 16, \'Density is below 1\', 1),'
            '(49, 17, \'Negatively charged part of an atom that is not a part of the nucleus\', 1),'
            '(52, 18, \'Correct\', 1),'
            '(55, 19, \'Imbalance in between negative and positive changes sometimes due to friction\', 1),'
            '(58, 20, \'Hydropower\', 1),'
            '(61, 21, \'61\', 1),'
            '(64, 22, \'Correct\', 1),'
            '(67, 23, \'Correct\', 1),'
            '(70, 24, \'Correct\', 1),'
            '(73, 25, \'Correct\', 1),'
            '(76, 26, \'Correct\', 1),'
            '(79, 27, \'Correct\', 1),'
            '(82, 28, \'Correct\', 1),'
            '(85, 29, \'Correct\', 1),'
            '(88, 30, \'Correct\', 1),'
            '(91, 31, \'Correct\', 1),'
            '(94, 32, \'Correct\', 1),'
            '(97, 33, \'Correct\', 1),'
            '(100, 34, \'Correct\', 1),'
            '(103, 35, \'Correct\', 1),'
            '(106, 36, \'Correct\', 1),'
            '(109, 37, \'Correct\', 1),'
            '(112, 38, \'Correct\', 1),'
            '(115, 39, \'Correct\', 1),'
            '(118, 40, \'Correct\', 1),'
            '(121, 41, \'Correct\', 1),'
            '(124, 42, \'Correct\', 1),'
            '(127, 43, \'Correct\', 1),'
            '(130, 44, \'Correct\', 1),'
            '(133, 45, \'Correct\', 1),'
            '(136, 46, \'Correct\', 1),'
            '(139, 47, \'Correct\', 1),'
            '(142, 48, \'Correct\', 1),'
            '(145, 49, \'Correct\', 1),'
            '(148, 50, \'Correct\', 1),'
            '(151, 51, \'Correct\', 1),'
            '(154, 52, \'Correct\', 1),'
            '(157, 53, \'Correct\', 1),'
            '(160, 54, \'Correct\', 1),'
            '(163, 55, \'Correct\', 1),'
            '(166, 56, \'Correct\', 1),'
            '(169, 57, \'Correct\', 1),'
            '(172, 58, \'Correct\', 1),'
            '(175, 59, \'Correct\', 1),'
            '(178, 60, \'Correct\', 1),'
            '(181, 61, \'Correct\', 1),'
            '(184, 62, \'Correct\', 1),'
            '(187, 63, \'Correct\', 1),'
            '(190, 64, \'Correct\', 1),'
            '(193, 65, \'Correct\', 1),'
            '(196, 66, \'Correct\', 1),'
            '(199, 67, \'Correct\', 1),'
            '(202, 68, \'Correct\', 1),'
            '(205, 69, \'Correct\', 1),'
            '(208, 70, \'Correct\', 1),'
            '(211, 71, \'Correct\', 1),'
            '(214, 72, \'Correct\', 1),'
            '(217, 73, \'Correct\', 1),'
            '(220, 74, \'Correct\', 1),'
            '(223, 75, \'Correct\', 1),'
            '(226, 76, \'Correct\', 1),'
            '(229, 77, \'Correct\', 1),'
            '(232, 78, \'Correct\', 1),'
            '(235, 79, \'Correct\', 1),'
            '(238, 80, \'Correct\', 1),'
            '(241, 81, \'Correct\', 1),'
            '(244, 82, \'Correct\', 1),'
            '(247, 83, \'Correct\', 1),'
            '(250, 84, \'Correct\', 1),'
            '(253, 85, \'Correct\', 1),'
            '(256, 86, \'Correct\', 1),'
            '(259, 87, \'Correct\', 1),'
            '(262, 88, \'Correct\', 1),'
            '(265, 89, \'Correct\', 1),'
            '(268, 90, \'Correct\', 1),'
            '(271, 91, \'Correct\', 1),'
            '(274, 92, \'Correct\', 1),'
            '(277, 93, \'Correct\', 1),'
            '(280, 94, \'Correct\', 1),'
            '(283, 95, \'Correct\', 1),'
            '(286, 96, \'Correct\', 1),'
            '(289, 97, \'Correct\', 1),'
            '(292, 98, \'Correct\', 1),'
            '(295, 99, \'Correct\', 1),'
            '(298, 100, \'Correct\', 1),'
            '(2, 1, \'100\', 0),'
            '(5, 2, \'Water, Ice, Steam\', 0),'
            '(8, 3, \'Nimbo\', 0),'
            '(11, 4, \'Lead\', 0),'
            '(14, 5, \'Nucleus\', 0),'
            '(17, 6, \'Dinosaurs\', 0),'
            '(20, 7, \'Solid rock\', 0),'
            '(23, 8, \'Clouds continue to collide with each other causing friction\', 0),'
            '(26, 9, \'Incorrect\', 0),'
            '(29, 10, \'High wind speeds\', 0),'
            '(32, 11, \'Incorrect\', 0),'
            '(35, 12, \'Incorrect\', 0),'
            '(38, 13, \'Water\', 0),'
            '(41, 14, \'Incorrect\', 0),'
            '(44, 15, \'Volume / Mass\', 0),'
            '(47, 16, \'Density is above 1\', 0),'
            '(50, 17, \'Negatively charged part of an atom in the nucleus\', 0),'
            '(53, 18, \'Incorrect\', 0),'
            '(56, 19, \'The build up of both positive and negative charges sometimes due to friction\', 0),'
            '(59, 20, \'Magnetic\', 0),'
            '(62, 21, \'71\', 0),'
            '(65, 22, \'Incorrect\', 0),'
            '(68, 23, \'Incorrect\', 0),'
            '(71, 24, \'Incorrect\', 0),'
            '(74, 25, \'Incorrect\', 0),'
            '(77, 26, \'Incorrect\', 0),'
            '(80, 27, \'Incorrect\', 0),'
            '(83, 28, \'Incorrect\', 0),'
            '(86, 29, \'Incorrect\', 0),'
            '(89, 30, \'Incorrect\', 0),'
            '(92, 31, \'Incorrect\', 0),'
            '(95, 32, \'Incorrect\', 0),'
            '(98, 33, \'Incorrect\', 0),'
            '(101, 34, \'Incorrect\', 0),'
            '(104, 35, \'Incorrect\', 0),'
            '(107, 36, \'Incorrect\', 0),'
            '(110, 37, \'Incorrect\', 0),'
            '(113, 38, \'Incorrect\', 0),'
            '(116, 39, \'Incorrect\', 0),'
            '(119, 40, \'Incorrect\', 0),'
            '(122, 41, \'Incorrect\', 0),'
            '(125, 42, \'Incorrect\', 0),'
            '(128, 43, \'Incorrect\', 0),'
            '(131, 44, \'Incorrect\', 0),'
            '(134, 45, \'Incorrect\', 0),'
            '(137, 46, \'Incorrect\', 0),'
            '(140, 47, \'Incorrect\', 0),'
            '(143, 48, \'Incorrect\', 0),'
            '(146, 49, \'Incorrect\', 0),'
            '(149, 50, \'Incorrect\', 0),'
            '(152, 51, \'Incorrect\', 0),'
            '(155, 52, \'Incorrect\', 0),'
            '(158, 53, \'Incorrect\', 0),'
            '(161, 54, \'Incorrect\', 0),'
            '(164, 55, \'Incorrect\', 0),'
            '(167, 56, \'Incorrect\', 0),'
            '(170, 57, \'Incorrect\', 0),'
            '(173, 58, \'Incorrect\', 0),'
            '(176, 59, \'Incorrect\', 0),'
            '(179, 60, \'Incorrect\', 0),'
            '(182, 61, \'Incorrect\', 0),'
            '(185, 62, \'Incorrect\', 0),'
            '(188, 63, \'Incorrect\', 0),'
            '(191, 64, \'Incorrect\', 0),'
            '(194, 65, \'Incorrect\', 0),'
            '(197, 66, \'Incorrect\', 0),'
            '(200, 67, \'Incorrect\', 0),'
            '(203, 68, \'Incorrect\', 0),'
            '(206, 69, \'Incorrect\', 0),'
            '(209, 70, \'Incorrect\', 0),'
            '(212, 71, \'Incorrect\', 0),'
            '(215, 72, \'Incorrect\', 0),'
            '(218, 73, \'Incorrect\', 0),'
            '(221, 74, \'Incorrect\', 0),'
            '(224, 75, \'Incorrect\', 0),'
            '(227, 76, \'Incorrect\', 0),'
            '(230, 77, \'Incorrect\', 0),'
            '(233, 78, \'Incorrect\', 0),'
            '(236, 79, \'Incorrect\', 0),'
            '(239, 80, \'Incorrect\', 0),'
            '(242, 81, \'Incorrect\', 0),'
            '(245, 82, \'Incorrect\', 0),'
            '(248, 83, \'Incorrect\', 0),'
            '(251, 84, \'Incorrect\', 0),'
            '(254, 85, \'Incorrect\', 0),'
            '(257, 86, \'Incorrect\', 0),'
            '(260, 87, \'Incorrect\', 0),'
            '(263, 88, \'Incorrect\', 0),'
            '(266, 89, \'Incorrect\', 0),'
            '(269, 90, \'Incorrect\', 0),'
            '(272, 91, \'Incorrect\', 0),'
            '(275, 92, \'Incorrect\', 0),'
            '(278, 93, \'Incorrect\', 0),'
            '(281, 94, \'Incorrect\', 0),'
            '(284, 95, \'Incorrect\', 0),'
            '(287, 96, \'Incorrect\', 0),'
            '(290, 97, \'Incorrect\', 0),'
            '(293, 98, \'Incorrect\', 0),'
            '(296, 99, \'Incorrect\', 0),'
            '(299, 100, \'Incorrect\', 0),'
            '(3, 1, \'181\', 0),'
            '(6, 2, \'Fluid, Air, Solid\', 0),'
            '(9, 3, \'Strato\', 0),'
            '(12, 4, \'Iron\', 0),'
            '(15, 5, \'Chloroplast\', 0),'
            '(18, 6, \'A type of rock that been on the earth since ancient times\', 0),'
            '(21, 7, \'Water\', 0),'
            '(24, 8, \'Cold humid air collides with air that is warm and dry\', 0),'
            '(27, 9, \'Incorrect\', 0),'
            '(30, 10, \'Large objects falling into the ocean\', 0),'
            '(33, 11, \'Incorrect\', 0),'
            '(36, 12, \'Incorrect\', 0),'
            '(39, 13, \'Chlorine\', 0),'
            '(42, 14, \'Incorrect\', 0),'
            '(45, 15, \'Volume * Mass\', 0),'
            '(48, 16, \'The element is not metallic\', 0),'
            '(51, 17, \'Positively charged part of an atom that is not a part of the nucleus\', 0),'
            '(54, 18, \'Incorrect\', 0),'
            '(57, 19, \'The application of electricity to an object\', 0),'
            '(60, 20, \'Lightning\', 0),'
            '(63, 21, \'51\', 0),'
            '(66, 22, \'Incorrect\', 0),'
            '(69, 23, \'Incorrect\', 0),'
            '(72, 24, \'Incorrect\', 0),'
            '(75, 25, \'Incorrect\', 0),'
            '(78, 26, \'Incorrect\', 0),'
            '(81, 27, \'Incorrect\', 0),'
            '(84, 28, \'Incorrect\', 0),'
            '(87, 29, \'Incorrect\', 0),'
            '(90, 30, \'Incorrect\', 0),'
            '(93, 31, \'Incorrect\', 0),'
            '(96, 32, \'Incorrect\', 0),'
            '(99, 33, \'Incorrect\', 0),'
            '(102, 34, \'Incorrect\', 0),'
            '(105, 35, \'Incorrect\', 0),'
            '(108, 36, \'Incorrect\', 0),'
            '(111, 37, \'Incorrect\', 0),'
            '(114, 38, \'Incorrect\', 0),'
            '(117, 39, \'Incorrect\', 0),'
            '(120, 40, \'Incorrect\', 0),'
            '(123, 41, \'Incorrect\', 0),'
            '(126, 42, \'Incorrect\', 0),'
            '(129, 43, \'Incorrect\', 0),'
            '(132, 44, \'Incorrect\', 0),'
            '(135, 45, \'Incorrect\', 0),'
            '(138, 46, \'Incorrect\', 0),'
            '(141, 47, \'Incorrect\', 0),'
            '(144, 48, \'Incorrect\', 0),'
            '(147, 49, \'Incorrect\', 0),'
            '(150, 50, \'Incorrect\', 0),'
            '(153, 51, \'Incorrect\', 0),'
            '(156, 52, \'Incorrect\', 0),'
            '(159, 53, \'Incorrect\', 0),'
            '(162, 54, \'Incorrect\', 0),'
            '(165, 55, \'Incorrect\', 0),'
            '(168, 56, \'Incorrect\', 0),'
            '(171, 57, \'Incorrect\', 0),'
            '(174, 58, \'Incorrect\', 0),'
            '(177, 59, \'Incorrect\', 0),'
            '(180, 60, \'Incorrect\', 0),'
            '(183, 61, \'Incorrect\', 0),'
            '(186, 62, \'Incorrect\', 0),'
            '(189, 63, \'Incorrect\', 0),'
            '(192, 64, \'Incorrect\', 0),'
            '(195, 65, \'Incorrect\', 0),'
            '(198, 66, \'Incorrect\', 0),'
            '(201, 67, \'Incorrect\', 0),'
            '(204, 68, \'Incorrect\', 0),'
            '(207, 69, \'Incorrect\', 0),'
            '(210, 70, \'Incorrect\', 0),'
            '(213, 71, \'Incorrect\', 0),'
            '(216, 72, \'Incorrect\', 0),'
            '(219, 73, \'Incorrect\', 0),'
            '(222, 74, \'Incorrect\', 0),'
            '(225, 75, \'Incorrect\', 0),'
            '(228, 76, \'Incorrect\', 0),'
            '(231, 77, \'Incorrect\', 0),'
            '(234, 78, \'Incorrect\', 0),'
            '(237, 79, \'Incorrect\', 0),'
            '(240, 80, \'Incorrect\', 0),'
            '(243, 81, \'Incorrect\', 0),'
            '(246, 82, \'Incorrect\', 0),'
            '(249, 83, \'Incorrect\', 0),'
            '(252, 84, \'Incorrect\', 0),'
            '(255, 85, \'Incorrect\', 0),'
            '(258, 86, \'Incorrect\', 0),'
            '(261, 87, \'Incorrect\', 0),'
            '(264, 88, \'Incorrect\', 0),'
            '(267, 89, \'Incorrect\', 0),'
            '(270, 90, \'Incorrect\', 0),'
            '(273, 91, \'Incorrect\', 0),'
            '(276, 92, \'Incorrect\', 0),'
            '(279, 93, \'Incorrect\', 0),'
            '(282, 94, \'Incorrect\', 0),'
            '(285, 95, \'Incorrect\', 0),'
            '(288, 96, \'Incorrect\', 0),'
            '(291, 97, \'Incorrect\', 0),'
            '(294, 98, \'Incorrect\', 0),'
            '(297, 99, \'Incorrect\', 0),'
            '(300, 100, \'Incorrect\', 0);'
    );
  });
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
        'INSERT OR IGNORE INTO story(story_id, event_id, story_string) '
        'VALUES '
            '(1, 1, \'All the best chemistry jokes argon.\'), '
            '(2, 2, \'Something Clever\'), '
            '(3, 3, \'I think it looks like a marshmello\'), '
            '(4, 4, \'No its my-anium\'), '
            '(5, 5, \'Powerhouse of the cell kinda sounds like the tagline for a cage wrestler.\'), '
            '(6, 6, \'Example Text\'), '
            '(7, 7, \'Example Text\'), '
            '(8, 8, \'Example Text\'), '
            '(9, 9, \'Example Text\'), '
            '(10, 10, \'Example Text\'), '
            '(11, 11, \'Example Text\'), '
            '(12, 12, \'Example Text\'), '
            '(13, 13, \'Example Text\'), '
            '(14, 14, \'Example Text\'), '
            '(15, 15, \'Example Text\'), '
            '(16, 16, \'Example Text\'), '
            '(17, 17, \'Example Text\'), '
            '(18, 18, \'Example Text\'), '
            '(19, 19, \'Example Text\'), '
            '(20, 20, \'Example Text\'), '
            '(21, 21, \'Example Text\'), '
            '(22, 22, \'Example Text\'), '
            '(23, 23, \'Example Text\'), '
            '(24, 24, \'Example Text\'), '
            '(25, 25, \'Example Text\'), '
            '(26, 26, \'Example Text\'), '
            '(27, 27, \'Example Text\'), '
            '(28, 28, \'Example Text\'), '
            '(29, 29, \'Example Text\'), '
            '(30, 30, \'Example Text\'), '
            '(31, 31, \'Example Text\'), '
            '(32, 32, \'Example Text\'), '
            '(33, 33, \'Example Text\'), '
            '(34, 34, \'Example Text\'), '
            '(35, 35, \'Example Text\'), '
            '(36, 36, \'Example Text\'), '
            '(37, 37, \'Example Text\'), '
            '(38, 38, \'Example Text\'), '
            '(39, 39, \'Example Text\'), '
            '(40, 40, \'Example Text\'), '
            '(41, 41, \'Example Text\'), '
            '(42, 42, \'Example Text\'), '
            '(43, 43, \'Example Text\'), '
            '(44, 44, \'Example Text\'), '
            '(45, 45, \'Example Text\'), '
            '(46, 46, \'Example Text\'), '
            '(47, 47, \'Example Text\'), '
            '(48, 48, \'Example Text\'), '
            '(49, 49, \'Example Text\'), '
            '(50, 50, \'Example Text\'), '
            '(51, 51, \'Example Text\'), '
            '(52, 52, \'Example Text\'), '
            '(53, 53, \'Example Text\'), '
            '(54, 54, \'Example Text\'), '
            '(55, 55, \'Example Text\'), '
            '(56, 56, \'Example Text\'), '
            '(57, 57, \'Example Text\'), '
            '(58, 58, \'Example Text\'), '
            '(59, 59, \'Example Text\'), '
            '(60, 60, \'Example Text\'), '
            '(61, 61, \'Example Text\'), '
            '(62, 62, \'Example Text\'), '
            '(63, 63, \'Example Text\'), '
            '(64, 64, \'Example Text\'), '
            '(65, 65, \'Example Text\'), '
            '(66, 66, \'Example Text\'), '
            '(67, 67, \'Example Text\'), '
            '(68, 68, \'Example Text\'), '
            '(69, 69, \'Example Text\'), '
            '(70, 70, \'Example Text\'), '
            '(71, 71, \'Example Text\'), '
            '(72, 72, \'Example Text\'), '
            '(73, 73, \'Example Text\'), '
            '(74, 74, \'Example Text\'), '
            '(75, 75, \'Example Text\'), '
            '(76, 76, \'Example Text\'), '
            '(77, 77, \'Example Text\'), '
            '(78, 78, \'Example Text\'), '
            '(79, 79, \'Example Text\'), '
            '(80, 80, \'Example Text\'), '
            '(81, 81, \'Example Text\'), '
            '(82, 82, \'Example Text\'), '
            '(83, 83, \'Example Text\'), '
            '(84, 84, \'Example Text\'), '
            '(85, 85, \'Example Text\'), '
            '(86, 86, \'Example Text\'), '
            '(87, 87, \'Example Text\'), '
            '(88, 88, \'Example Text\'), '
            '(89, 89, \'Example Text\'), '
            '(90, 90, \'Example Text\'), '
            '(91, 91, \'Example Text\'), '
            '(92, 92, \'Example Text\'), '
            '(93, 93, \'Example Text\'), '
            '(94, 94, \'Example Text\'), '
            '(95, 95, \'Example Text\'), '
            '(96, 96, \'Example Text\'), '
            '(97, 97, \'Example Text\'), '
            '(98, 98, \'Example Text\'), '
            '(99, 99, \'Example Text\'), '
            '(100, 100, \'Example Text\');'
    );
  });
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert('INSERT OR IGNORE INTO events(event_id)'
        'VALUES'
        '(1),'
        '(2),'
        '(3),'
        '(4),'
        '(5),'
        '(6),'
        '(7),'
        '(8),'
        '(9),'
        '(10),'
        '(11),'
        '(12),'
        '(13),'
        '(14),'
        '(15),'
        '(16),'
        '(17),'
        '(18),'
        '(19),'
        '(20),'
        '(21),'
        '(22),'
        '(23),'
        '(24),'
        '(25),'
        '(26),'
        '(27),'
        '(28),'
        '(29),'
        '(30),'
        '(31),'
        '(32),'
        '(33),'
        '(34),'
        '(35),'
        '(36),'
        '(37),'
        '(38),'
        '(39),'
        '(40),'
        '(41),'
        '(42),'
        '(43),'
        '(44),'
        '(45),'
        '(46),'
        '(47),'
        '(48),'
        '(49),'
        '(50),'
        '(51),'
        '(52),'
        '(53),'
        '(54),'
        '(55),'
        '(56),'
        '(57),'
        '(58),'
        '(59),'
        '(60),'
        '(61),'
        '(62),'
        '(63),'
        '(64),'
        '(65),'
        '(66),'
        '(67),'
        '(68),'
        '(69),'
        '(70),'
        '(71),'
        '(72),'
        '(73),'
        '(74),'
        '(75),'
        '(76),'
        '(77),'
        '(78),'
        '(79),'
        '(80),'
        '(81),'
        '(82),'
        '(83),'
        '(84),'
        '(85),'
        '(86),'
        '(87),'
        '(88),'
        '(89),'
        '(90),'
        '(91),'
        '(92),'
        '(93),'
        '(94),'
        '(95),'
        '(96),'
        '(97),'
        '(98),'
        '(99),'
        '(100);'
    );
  });
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
        'INSERT OR IGNORE INTO question(question_id, question_number, question_text, question_subject, event_id)'
        'VALUES'
            '(1, 1, \'How many elements in the periodic table?\', \'Science\', 1),'
            '(2, 2, \'What are the three states of matter?\', \'Science\', 2),'
            '(3, 3, \'What type of cloud is this?\', \'Science\', 3),'
            '(4, 4, \'Which natural element has the highest atomic number?\', \'Science\', 4),'
            '(5, 5, \'This organelle is responsible for energy production and is often called the "powerhouse" of the cell.\', \'Science\', 5),'
            '(6, 6, \'What is a fossil?\', \'Science\', 6),'
            '(7, 7, \'What material is at the core of the Earth?\', \'Science\', 7),'
            '(8, 8, \'How are tornadoes formed?\', \'Science\', 8),'
            '(9, 9, \'How are earthquakes formed?\', \'Science\', 9),'
            '(10, 10, \'How are tsunamis formed?\', \'Science\', 10),'
            '(11, 11, \'What is lightning?\', \'Science\', 11),'
            '(12, 12, \'Why does it rain?\', \'Science\', 12),'
            '(13, 13, \'What are the liquid elements in the periodic table?\', \'Science\', 13),'
            '(14, 14, \'What are the different types of climates?\', \'Science\', 14),'
            '(15, 15, \'What is the formula for density?\', \'Science\', 15),'
            '(16, 16, \'What makes an object float in water?\', \'Science\', 16),'
            '(17, 17, \'What are electrons?\', \'Science\', 17),'
            '(18, 18, \'Which of the following is a complete circuit?\', \'Science\', 18),'
            '(19, 19, \'What is static electricity?\', \'Science\', 19),'
            '(20, 20, \'What is one way that we produce energy to use?\', \'Science\', 20),'
            '(21, 1, \'15 + 46\', \'Math\', 21),'
            '(22, 2, \'73 * 5\', \'Math\', 22),'
            '(23, 3, \'97 / 7\', \'Math\', 23),'
            '(24, 4, \'83 - 24\', \'Math\', 24),'
            '(25, 5, \'Solve for X -> 7x = 28\', \'Math\', 25),'
            '(26, 6, \'978 + 30\', \'Math\', 26),'
            '(27, 7, \'48 * 35\', \'Math\', 27),'
            '(28, 8, \'987 + 56\', \'Math\', 28),'
            '(29, 9, \'654 / 5\', \'Math\', 29),'
            '(30, 10, \'863 / 9\', \'Math\', 30),'
            '(31, 11, \'86 + 4\', \'Math\', 31),'
            '(32, 12, \'8 * 9\', \'Math\', 32),'
            '(33, 13, \'7 * 2\', \'Math\', 33),'
            '(34, 14, \'25 * 6\', \'Math\', 34),'
            '(35, 15, \'978 / 3\', \'Math\', 35),'
            '(36, 16, \'Solve for X ->  4x = 65\', \'Math\', 36),'
            '(37, 17, \'Solve for X -> 20 + x = 46\', \'Math\', 37),'
            '(38, 18, \'Solve for X -> x - 8 = 2\', \'Math\', 38),'
            '(39, 19, \'Solve for X -> 19 - x = 52\', \'Math\', 39),'
            '(40, 20, \'Solve for X ->  8x = 64\', \'Math\', 40),'
            '(41, 1, \'Question Text Here\', \'Geography\', 41),'
            '(42, 2, \'Question Text Here\', \'Geography\', 42),'
            '(43, 3, \'Question Text Here\', \'Geography\', 43),'
            '(44, 4, \'Question Text Here\', \'Geography\', 44),'
            '(45, 5, \'Question Text Here\', \'Geography\', 45),'
            '(46, 6, \'Question Text Here\', \'Geography\', 46),'
            '(47, 7, \'Question Text Here\', \'Geography\', 47),'
            '(48, 8, \'Question Text Here\', \'Geography\', 48),'
            '(49, 9, \'Question Text Here\', \'Geography\', 49),'
            '(50, 10, \'Question Text Here\', \'Geography\', 50),'
            '(51, 11, \'Question Text Here\', \'Geography\', 51),'
            '(52, 12, \'Question Text Here\', \'Geography\', 52),'
            '(53, 13, \'Question Text Here\', \'Geography\', 53),'
            '(54, 14, \'Question Text Here\', \'Geography\', 54),'
            '(55, 15, \'Question Text Here\', \'Geography\', 55),'
            '(56, 16, \'Question Text Here\', \'Geography\', 56),'
            '(57, 17, \'Question Text Here\', \'Geography\', 57),'
            '(58, 18, \'Question Text Here\', \'Geography\', 58),'
            '(59, 19, \'Question Text Here\', \'Geography\', 59),'
            '(60, 20, \'Question Text Here\', \'Geography\', 60),'
            '(61, 1, \'Question Text Here\', \'Spelling\', 61),'
            '(62, 2, \'Question Text Here\', \'Spelling\', 62),'
            '(63, 3, \'Question Text Here\', \'Spelling\', 63),'
            '(64, 4, \'Question Text Here\', \'Spelling\', 64),'
            '(65, 5, \'Question Text Here\', \'Spelling\', 65),'
            '(66, 6, \'Question Text Here\', \'Spelling\', 66),'
            '(67, 7, \'Question Text Here\', \'Spelling\', 67),'
            '(68, 8, \'Question Text Here\', \'Spelling\', 68),'
            '(69, 9, \'Question Text Here\', \'Spelling\', 69),'
            '(70, 10, \'Question Text Here\', \'Spelling\', 70),'
            '(71, 11, \'Question Text Here\', \'Spelling\', 71),'
            '(72, 12, \'Question Text Here\', \'Spelling\', 72),'
            '(73, 13, \'Question Text Here\', \'Spelling\', 73),'
            '(74, 14, \'Question Text Here\', \'Spelling\', 74),'
            '(75, 15, \'Question Text Here\', \'Spelling\', 75),'
            '(76, 16, \'Question Text Here\', \'Spelling\', 76),'
            '(77, 17, \'Question Text Here\', \'Spelling\', 77),'
            '(78, 18, \'Question Text Here\', \'Spelling\', 78),'
            '(79, 19, \'Question Text Here\', \'Spelling\', 79),'
            '(80, 20, \'Question Text Here\', \'Spelling\', 80),'
            '(81, 1, \'Question Text Here\', \'Programming\', 81),'
            '(82, 2, \'Question Text Here\', \'Programming\', 82),'
            '(83, 3, \'Question Text Here\', \'Programming\', 83),'
            '(84, 4, \'Question Text Here\', \'Programming\', 84),'
            '(85, 5, \'Question Text Here\', \'Programming\', 85),'
            '(86, 6, \'Question Text Here\', \'Programming\', 86),'
            '(87, 7, \'Question Text Here\', \'Programming\', 87),'
            '(88, 8, \'Question Text Here\', \'Programming\', 88),'
            '(89, 9, \'Question Text Here\', \'Programming\', 89),'
            '(90, 10, \'Question Text Here\', \'Programming\', 90),'
            '(91, 11, \'Question Text Here\', \'Programming\', 91),'
            '(92, 12, \'Question Text Here\', \'Programming\', 92),'
            '(93, 13, \'Question Text Here\', \'Programming\', 93),'
            '(94, 14, \'Question Text Here\', \'Programming\', 94),'
            '(95, 15, \'Question Text Here\', \'Programming\', 95),'
            '(96, 16, \'Question Text Here\', \'Programming\', 96),'
            '(97, 17, \'Question Text Here\', \'Programming\', 97),'
            '(98, 18, \'Question Text Here\', \'Programming\', 98),'
            '(99, 19, \'Question Text Here\', \'Programming\', 99),'
            '(100, 20, \'Question Text Here\', \'Programming\', 100);');
  });
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
        'INSERT OR IGNORE INTO save(save_id, correct_answers, wrong_answers, event_id, science_event, math_event, geography_event, spelling_event, programming_event)'
        'VALUES'
        '(1, 0, 0, 1, 1, 21, 41, 61, 81)');
  });
  //
  // final database = openDatabase('data.db',
  // onCreate: (db, version) {
  // Run the CREATE TABLE statement on the database.
  //   return db.execute(
  //     'CREATE TABLE IF NOT EXISTS save(save_id INTEGER PRIMARY KEY NOT NULL, correct_answers INTEGER NOT NULL, wrong_answers INTEGER NOT NULL, event_id INTEGER NOT NULL, science_event INT DEFAULT 0 NOT NULL, math_event INT DEFAULT 0 NOT NULL, geography_event INT DEFAULT 0 NOT NULL, spelling_event INT DEFAULT 0 NOT NULL, programming_event INT DEFAULT 0 NOT NULL);'
  //         'CREATE TABLE IF NOT EXISTS event(event_id INTEGER PRIMARY KEY NOT NULL);'
  //         'CREATE TABLE IF NOT EXISTS question(question_id INTEGER PRIMARY KEY NOT NULL, question_number INTEGER NOT NULL, question_text VARCHAR(255) NOT NULL, question_subject VARCHAR(255) NOT NULL, event_id INTEGER NOT NULL);'
  //         'CREATE TABLE IF NOT EXISTS story(story_id INTEGER PRIMARY KEY NOT NULL, event_id INTEGER NOT NULL, story_string VARCHAR(255) NOT NULL);'
  //         'CREATE TABLE IF NOT EXISTS answer(answer_id INTEGER PRIMARY KEY NOT NULL, event_id INTEGER NOT NULL, answer_string VARCHAR(255) NOT NULL, is_correct TINYINT NOT NULL);'
  //         'INSERT IGNORE INTO answer (answer_id, event_id, answer_string, is_correct)'
  //           'VALUES'
  //           '(1, 1, "a", 1),'
  //           '(2, 1, "b", 0),'
  //           '(3, 1, "c", 0),'
  //           '(4, 2, "d", 1),'
  //           '(5, 2, "e", 0),'
  //           '(6, 2, "g", 0);'
  //
  //         'INSERT IGNORE INTO story (story_id, event_id, story_string)'
  //           'VALUES'
  //             '(1, 2, "f");'
  //
  //         'INSERT IGNORE INTO event (event_id)'
  //           'VALUES'
  //             '(1),'
  //             '(2);'
  //
  //         'INSERT IGNORE INTO question (question_id, question_number, question_text, question_subject, event_id)'
  //           'VALUES'
  //             '(1, 1, "What is the first letter of the Alphabet?", "spelling", 1);'
  //
  //         'INSERT IGNORE INTO save (save_id, correct_answers, wrong_answers, event_id, science_event, math_event, geography_event, spelling_event, programming_event)'
  //           'VALUES'
  //             '(1, 0, 0, 1, 1, 21, 41, 61, 81)'
  //   );
  //
  // },
  //     version: 1,
  // );

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

Future<EventText> getEventInfo(db, eventID) async {
  // Query the table for question associated with an event.
  final List<Map> maps = await db.rawQuery(
      "SELECT q.question_text, a1.answer_string AS answer1, a2.answer_string AS answer2, a3.answer_string AS answer3, s.story_string " +
          "FROM events e " +
          "LEFT JOIN question q on q.event_id = e.event_id " +
          "LEFT JOIN answer a1 ON e.event_id = a1.event_id " +
          "LEFT JOIN answer a2 ON e.event_id = a2.event_id " +
          "LEFT JOIN answer a3 ON e.event_id = a3.event_id " +
          "LEFT JOIN story s ON e.event_id = s.event_id " +
          "WHERE e.event_id = ? AND a1.is_correct = 1 AND a2.answer_id < a3.answer_id AND NOT a2.answer_id = a1.answer_id AND NOT a2.answer_id = a1.answer_id" +
          ";",
      [eventID]);
  // Convert the List<Map<String, dynamic> into a List<EventText>.
  var eventList = List.generate(maps.length, (i) {
    return EventText(
      question: maps[0]['question_text'],
      answer1: maps[0]['answer1'],
      answer2: maps[0]['answer2'],
      answer3: maps[0]['answer3'],
      story: maps[0]['story_string'],
    );
  });
  return eventList[0];
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
      'science_event': science_event,
      'math_event': math_event,
      'geography_event': geography_event,
      'spelling_event': spelling_event,
      'programming_event': programming_event,
    };
  }

  @override
  String toString() {
    return 'Save{save_id: $save_id, correct_answers: $correct_answers, wrong_answers: $wrong_answers, event_id: $event_id, science_event: $science_event, math_event: $math_event, geography_event: $geography_event, spelling_event: $spelling_event, programming_event: $programming_event}';
  }
}

class Events {
  final int event_id;

  const Events({
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
