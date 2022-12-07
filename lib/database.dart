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
Future<int> updateSave(correct) async {
  final db = await useDatabase();
  List<Save> saves = await getSaves(db);
  Save save = saves[0];
  if (correct) {
    save.correct_answers += 1;
  } else {
    save.wrong_answers += 1;
  }
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
  return save.correct_answers;
}

Future<EventText> getText(subject) async {
  final db = await useDatabase();
  List<Save> currSave = await getSaves(db);
  var eventText = new EventText(
      question: "a", answer1: "a", answer2: "a", answer3: "a", story: "a", subject: "a");
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
  final String subject;

  const EventText({
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.story,
    required this.subject,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer1': answer1,
      'answer2': answer2,
      'answer3': answer3,
      'story': story,
      'subject': subject,
    };
  }

  @override
  String toString() {
    return 'EventText{question: $question, answer1: $answer1, answer2: $answer2, answer3: $answer3, story: $story, subject: $subject}';
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
            '(25, 9, \'When tectonic plates collide and move\', 1),'
            '(28, 10, \'When there is an earthquake in the ocean \', 1),'
            '(31, 11, \'When clouds collide together and create electricity\', 1),'
            '(34, 12, \'There is excess water in the clouds so the clouds have to release it\', 1),'
            '(37, 13, \'Bromine and Mercury\', 1),'
            '(40, 14, \'Taiga\', 1),'
            '(43, 15, \'Mass / Volume\', 1),'
            '(46, 16, \'Density is below 1\', 1),'
            '(49, 17, \'Negatively charged part of an atom that is not a part of the nucleus\', 1),'
            '(52, 18, \'Conducting materials\', 1),'
            '(55, 19, \'Imbalance in between negative and positive changes sometimes due to friction\', 1),'
            '(58, 20, \'Hydropower\', 1),'
            '(61, 21, \'61\', 1),'
            '(64, 22, \'365\', 1),'
            '(67, 23, \'13.857\', 1),'
            '(70, 24, \'59\', 1),'
            '(73, 25, \'4\', 1),'
            '(76, 26, \'1008\', 1),'
            '(79, 27, \'1680\', 1),'
            '(82, 28, \'1043\', 1),'
            '(85, 29, \'130.8\', 1),'
            '(88, 30, \'95.888\', 1),'
            '(91, 31, \'90\', 1),'
            '(94, 32, \'72\', 1),'
            '(97, 33, \'14\', 1),'
            '(100, 34, \'150\', 1),'
            '(103, 35, \'326\', 1),'
            '(106, 36, \'16.25\', 1),'
            '(109, 37, \'26\', 1),'
            '(112, 38, \'10\', 1),'
            '(115, 39, \'-33\', 1),'
            '(118, 40, \'8\', 1),'
            '(121, 41, \'Mount Kilimanjaro\', 1),'
            '(124, 42, \'50\', 1),'
            '(127, 43, \'Europe\', 1),'
            '(130, 44, \'54\', 1),'
            '(133, 45, \'Antarctic Desert\', 1),'
            '(136, 46, \'Mongolia\', 1),'
            '(139, 47, \'Africa\', 1),'
            '(142, 48, \'River Seine\', 1),'
            '(145, 49, \'Russia\', 1),'
            '(148, 50, \'Alaska\', 1),'
            '(151, 51, \'California\', 1),'
            '(154, 52, \'Rhode Island\', 1),'
            '(157, 53, \'Spain\', 1),'
            '(160, 54, \'7\', 1),'
            '(163, 55, \'Atlantic\', 1),'
            '(166, 56, \'Mexico\', 1),'
            '(169, 57, \'China\', 1),'
            '(172, 58, \'Hawaii\', 1),'
            '(175, 59, \'12\', 1),'
            '(178, 60, \'4\', 1),'
            '(181, 61, \'p\', 1),'
            '(184, 62, \'Elephant\', 1),'
            '(187, 63, \'Abraham Lincoln\', 1),'
            '(190, 64, \'Knight\', 1),'
            '(193, 65, \'Symbolism\', 1),'
            '(196, 66, \'Source\', 1),'
            '(199, 67, \'Interragotive\', 1),'
            '(202, 68, \'Breakfast\', 1),'
            '(205, 69, \'Government\', 1),'
            '(208, 70, \'Amusement\', 1),'
            '(211, 71, \'Thumb\', 1),'
            '(214, 72, \'Another\', 1),'
            '(217, 73, \'Grudge\', 1),'
            '(220, 74, \'Cousin\', 1),'
            '(223, 75, \'Height\', 1),'
            '(226, 76, \'Pamphlet\', 1),'
            '(229, 77, \'Imperative\', 1),'
            '(232, 78, \'Giraffe\', 1),'
            '(235, 79, \'Kangaroo\', 1),'
            '(238, 80, \'Mountain\', 1),'
            '(241, 81, \'Put the instructions into a function.\', 1),'
            '(244, 82, \'If the while loop is never broken, it will keep running forever.\', 1),'
            '(247, 83, \'A symbol which represent a stored value.\', 1),'
            '(250, 84, \'Set of instructions to do a single specified thing often than can take arguments and return a value.\', 1),'
            '(253, 85, \'Template of an object containing different methods and variables.\', 1),'
            '(256, 86, \'An instance of a class\', 1),'
            '(259, 87, \'N\', 1),'
            '(262, 88, \'To iterate through each element in a set of data.\', 1),'
            '(265, 89, \'[1,2,3,4,5]\', 1),'
            '(268, 90, \'cat == 1\', 1),'
            '(271, 91, \'Integer\', 1),'
            '(274, 92, \'Double\', 1),'
            '(277, 93, \'String\', 1),'
            '(280, 94, \'If, Else\', 1),'
            '(283, 95, \'bicycleName\', 1),'
            '(286, 96, \'SquareInt\', 1),'
            '(289, 97, \'A boolean expression\', 1),'
            '(292, 98, \'Notepad\', 1),'
            '(295, 99, \'Version Control System\', 1),'
            '(298, 100, \'When a class takes the properties of an existing class but adds its own properties.\', 1),'
            '(2, 1, \'100\', 0),'
            '(5, 2, \'Water, Ice, Steam\', 0),'
            '(8, 3, \'Nimbo\', 0),'
            '(11, 4, \'Lead\', 0),'
            '(14, 5, \'Nucleus\', 0),'
            '(17, 6, \'Dinosaurs\', 0),'
            '(20, 7, \'Solid rock\', 0),'
            '(23, 8, \'Clouds continue to collide with each other causing friction\', 0),'
            '(26, 9, \'When the earth starts spinning slightly faster\', 0),'
            '(29, 10, \'High wind speeds\', 0),'
            '(32, 11, \'When there is a build up electricity in the clouds and the clouds can not hold any more\', 0),'
            '(35, 12, \'When wind pulls water up into the sky and then water falls down\', 0),'
            '(38, 13, \'Water\', 0),'
            '(41, 14, \'Arctic\', 0),'
            '(44, 15, \'Volume / Mass\', 0),'
            '(47, 16, \'Density is above 1\', 0),'
            '(50, 17, \'Negatively charged part of an atom in the nucleus\', 0),'
            '(53, 18, \'Wires\', 0),'
            '(56, 19, \'The build up of both positive and negative charges sometimes due to friction\', 0),'
            '(59, 20, \'Magnetic\', 0),'
            '(62, 21, \'71\', 0),'
            '(65, 22, \'355\', 0),'
            '(68, 23, \'13.59\', 0),'
            '(71, 24, \'69\', 0),'
            '(74, 25, \'21\', 0),'
            '(77, 26, \'998\', 0),'
            '(80, 27, \'1240\', 0),'
            '(83, 28, \'1033\', 0),'
            '(86, 29, \'134.1\', 0),'
            '(89, 30, \'98.888\', 0),'
            '(92, 31, \'100\', 0),'
            '(95, 32, \'78\', 0),'
            '(98, 33, \'9\', 0),'
            '(101, 34, \'123\', 0),'
            '(104, 35, \'325.5\', 0),'
            '(107, 36, \'260\', 0),'
            '(110, 37, \'66\', 0),'
            '(113, 38, \'6\', 0),'
            '(116, 39, \'33\', 0),'
            '(119, 40, \'56\', 0),'
            '(122, 41, \'Mount Everest\', 0),'
            '(125, 42, \'51\', 0),'
            '(128, 43, \'Asia\', 0),'
            '(131, 44, \'58\', 0),'
            '(134, 45, \'Sahara Desert\', 0),'
            '(137, 46, \'Ukraine\', 0),'
            '(140, 47, \'South America\', 0),'
            '(143, 48, \'Dordogne\', 0),'
            '(146, 49, \'Poland\', 0),'
            '(149, 50, \'Texas\', 0),'
            '(152, 51, \'New York\', 0),'
            '(155, 52, \'Maine\', 0),'
            '(158, 53, \'England\', 0),'
            '(161, 54, \'6\', 0),'
            '(164, 55, \'Indian\', 0),'
            '(167, 56, \'Cuba\', 0),'
            '(170, 57, \'Germany\', 0),'
            '(173, 58, \'Alaska\', 0),'
            '(176, 59, \'55\', 0),'
            '(179, 60, \'16\', 0),'
            '(182, 61, \'a\', 0),'
            '(185, 62, \'Elephent\', 0),'
            '(188, 63, \'Abaham Lincon\', 0),'
            '(191, 64, \'Night\', 0),'
            '(194, 65, \'Simbolism\', 0),'
            '(197, 66, \'Sorse\', 0),'
            '(200, 67, \'Interogative\', 0),'
            '(203, 68, \'Breckfast\', 0),'
            '(206, 69, \'Goverment\', 0),'
            '(209, 70, \'Amuzment\', 0),'
            '(212, 71, \'Thum\', 0),'
            '(215, 72, \'Anothr\', 0),'
            '(218, 73, \'Gruge\', 0),'
            '(221, 74, \'Cosin\', 0),'
            '(224, 75, \'Hight\', 0),'
            '(227, 76, \'Pamflet\', 0),'
            '(230, 77, \'Impairative\', 0),'
            '(233, 78, \'Girafe\', 0),'
            '(236, 79, \'Kangaro\', 0),'
            '(239, 80, \'Mountin\', 0),'
            '(242, 81, \'Use an if statement\', 0),'
            '(245, 82, \'If there is no break, the while loop will never run.\', 0),'
            '(248, 83, \'A data type.\', 0),'
            '(251, 84, \'A type of loop.\', 0),'
            '(254, 85, \'A course designed to learn a new programming language or principle.\', 0),'
            '(257, 86, \'A piece of computer hardware, i.e. CPU\', 0),'
            '(260, 87, \'R\', 0),'
            '(263, 88, \'To perform the actions in the loop for each time it is called.\', 0),'
            '(266, 89, \'1,2,3,4,5\', 0),'
            '(269, 90, \'1 + 1\', 0),'
            '(272, 91, \'Double\', 0),'
            '(275, 92, \'Integer\', 0),'
            '(278, 93, \'Integer\', 0),'
            '(281, 94, \'Addition and Substraction\', 0),'
            '(284, 95, \'bn\', 0),'
            '(287, 96, \'SqInt\', 0),'
            '(290, 97, \'An else if clause\', 0),'
            '(293, 98, \'Visual Studio Code\', 0),'
            '(296, 99, \'Social Media\', 0),'
            '(299, 100, \'When an object is uninitialized by giving its value to another object.\', 0),'
            '(3, 1, \'181\', 0),'
            '(6, 2, \'Fluid, Air, Solid\', 0),'
            '(9, 3, \'Strato\', 0),'
            '(12, 4, \'Iron\', 0),'
            '(15, 5, \'Chloroplast\', 0),'
            '(18, 6, \'A type of rock that been on the earth since ancient times\', 0),'
            '(21, 7, \'Water\', 0),'
            '(24, 8, \'Cold humid air collides with air that is warm and dry\', 0),'
            '(27, 9, \'When the earth starts growing larger\', 0),'
            '(30, 10, \'Large objects falling into the ocean\', 0),'
            '(33, 11, \'When there is a metal object in a cloud\', 0),'
            '(36, 12, \'The clouds get sad\', 0),'
            '(39, 13, \'Chlorine\', 0),'
            '(42, 14, \'Mountains\', 0),'
            '(45, 15, \'Volume * Mass\', 0),'
            '(48, 16, \'The element is not metallic\', 0),'
            '(51, 17, \'Positively charged part of an atom that is not a part of the nucleus\', 0),'
            '(54, 18, \'Batteries\', 0),'
            '(57, 19, \'The application of electricity to an object\', 0),'
            '(60, 20, \'Lightning\', 0),'
            '(63, 21, \'51\', 0),'
            '(66, 22, \'375\', 0),'
            '(69, 23, \'14.12\', 0),'
            '(72, 24, \'61\', 0),'
            '(75, 25, \'196\', 0),'
            '(78, 26, \'1018\', 0),'
            '(81, 27, \'1570\', 0),'
            '(84, 28, \'1053\', 0),'
            '(87, 29, \'130.43\', 0),'
            '(90, 30, \'95.67\', 0),'
            '(93, 31, \'89\', 0),'
            '(96, 32, \'62\', 0),'
            '(99, 33, \'12\', 0),'
            '(102, 34, \'1230\', 0),'
            '(105, 35, \'328\', 0),'
            '(108, 36, \'61\', 0),'
            '(111, 37, \'16\', 0),'
            '(114, 38, \'-10\', 0),'
            '(117, 39, \'-71\', 0),'
            '(120, 40, \'72\', 0),'
            '(123, 41, \'Mount Ghana\', 0),'
            '(126, 42, \'52\', 0),'
            '(129, 43, \'North America\', 0),'
            '(132, 44, \'84\', 0),'
            '(135, 45, \'Gobi Desert\', 0),'
            '(138, 46, \'Estonia\', 0),'
            '(141, 47, \'Asia\', 0),'
            '(144, 48, \'Loire\', 0),'
            '(147, 49, \'Egypt\', 0),'
            '(150, 50, \'California\', 0),'
            '(153, 51, \'Colorado\', 0),'
            '(156, 52, \'Vermont\', 0),'
            '(159, 53, \'France\', 0),'
            '(162, 54, \'8\', 0),'
            '(165, 55, \'Mediterranean\', 0),'
            '(168, 56, \'Chile\', 0),'
            '(171, 57, \'France\', 0),'
            '(174, 58, \'Rhode Island\', 0),'
            '(177, 59, \'22\', 0),'
            '(180, 60, \'7\', 0),'
            '(183, 61, \'c\', 0),'
            '(186, 62, \'Elepant\', 0),'
            '(189, 63, \'Abaham Lincoln\', 0),'
            '(192, 64, \'Nite\', 0),'
            '(195, 65, \'Cymbolism\', 0),'
            '(198, 66, \'Sorce\', 0),'
            '(201, 67, \'Intairogative\', 0),'
            '(204, 68, \'Breakfust\', 0),'
            '(207, 69, \'Governmint\', 0),'
            '(210, 70, \'Amusment\', 0),'
            '(213, 71, \'Thume\', 0),'
            '(216, 72, \'Unother\', 0),'
            '(219, 73, \'Gruje\', 0),'
            '(222, 74, \'Cowsin\', 0),'
            '(225, 75, \'Hite\', 0),'
            '(228, 76, \'Pamflit\', 0),'
            '(231, 77, \'Imperivitive\', 0),'
            '(234, 78, \'Jirafe\', 0),'
            '(237, 79, \'Kangorou\', 0),'
            '(240, 80, \'Mountan\', 0),'
            '(243, 81, \'Use a switch statement\', 0),'
            '(246, 82, \'There is no need for a break in a while loop.\', 0),'
            '(249, 83, \'A type of function.\', 0),'
            '(252, 84, \'Predefined calls built into a programming language to perform different actions.\', 0),'
            '(255, 85, \'A type of variable.\', 0),'
            '(258, 86, \'A data type.\', 0),'
            '(261, 87, \'C++\', 0),'
            '(264, 88, \'You should never use a for-each loop.\', 0),'
            '(267, 89, \'12345\', 0),'
            '(270, 90, \'cat = 1\', 0),'
            '(273, 91, \'String\', 0),'
            '(276, 92, \'String\', 0),'
            '(279, 93, \'Float\', 0),'
            '(282, 94, \'For loop\', 0),'
            '(285, 95, \'theNameOfTheBicycle\', 0),'
            '(288, 96, \'Square\', 0),'
            '(291, 97, \'A loop\', 0),'
            '(294, 98, \'JetBrain Rider\', 0),'
            '(297, 99, \'Flashdrive\', 0),'
            '(300, 100, \'Another term for assigning a value to a variable.\', 0);');
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
            '(14, 14, \'Which of these are a type of climate?\', \'Science\', 14),'
            '(15, 15, \'What is the formula for density?\', \'Science\', 15),'
            '(16, 16, \'What makes an object float in water?\', \'Science\', 16),'
            '(17, 17, \'What are electrons?\', \'Science\', 17),'
            '(18, 18, \'Which of the following is always required in a complete electrical circuit?\', \'Science\', 18),'
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
            '(41, 1, \'What is the name of the tallest mountain in Africa?\', \'Geography\', 41),'
            '(42, 2, \'How many states are in the USA?\', \'Geography\', 42),'
            '(43, 3, \'What continent is England located in?\', \'Geography\', 43),'
            '(44, 4, \'How many countries are in Africa?\', \'Geography\', 44),'
            '(45, 5, \'What is the largest desert in the world?\', \'Geography\', 45),'
            '(46, 6, \'Which of these countries was not part of the Soviet Union?\', \'Geography\', 46),'
            '(47, 7, \'What continent is the Nile located on?\', \'Geography\', 47),'
            '(48, 8, \'Which river flows through Paris?\', \'Geography\', 48),'
            '(49, 9, \'Which country is located on two continents?\', \'Geography\', 49),'
            '(50, 10, \'What is the largest state in the USA?\', \'Geography\', 50),'
            '(51, 11, \'What state has the highest population?\', \'Geography\', 51),'
            '(52, 12, \'What is the smallest state?\', \'Geography\', 52),'
            '(53, 13, \'Where did Columbus set sail from?\', \'Geography\', 53),'
            '(54, 14, \'How many continents are there?\', \'Geography\', 54),'
            '(55, 15, \'Which is one of the major oceans?\', \'Geography\', 55),'
            '(56, 16, \'Which of these countries borders the USA?\', \'Geography\', 56),'
            '(57, 17, \'Which of these countries borders Russia?\', \'Geography\', 57),'
            '(58, 18, \'Which state is an island?\', \'Geography\', 58),'
            '(59, 19, \'How many countries are in South America?\', \'Geography\', 59),'
            '(60, 20, \'How many countries are included in the United Kingdom?\', \'Geography\', 60),'
            '(61, 1, \'Fill in the Blank: An a_ple a day keeps the doctor away.\', \'Spelling\', 61),'
            '(62, 2, \'Which is spelled correctly?\', \'Spelling\', 62),'
            '(63, 3, \'Who wrote the Gettysburg Address?\', \'Spelling\', 63),'
            '(64, 4, \'Fill in the Blank: A ______ in shining armor.\', \'Spelling\', 64),'
            '(65, 5, \'Which is spelled correctly?\', \'Spelling\', 65),'
            '(66, 6, \'Which is spelled correctly?\', \'Spelling\', 66),'
            '(67, 7, \'Which is spelled correctly?\', \'Spelling\', 67),'
            '(68, 8, \'Which is spelled correctly?\', \'Spelling\', 68),'
            '(69, 9, \'Which is spelled correctly?\', \'Spelling\', 69),'
            '(70, 10, \'Which is spelled correctly?\', \'Spelling\', 70),'
            '(71, 11, \'Which is spelled correctly?\', \'Spelling\', 71),'
            '(72, 12, \'Which is spelled correctly?\', \'Spelling\', 72),'
            '(73, 13, \'Which is spelled correctly?\', \'Spelling\', 73),'
            '(74, 14, \'Which is spelled correctly?\', \'Spelling\', 74),'
            '(75, 15, \'Which is spelled correctly?\', \'Spelling\', 75),'
            '(76, 16, \'Which is spelled correctly?\', \'Spelling\', 76),'
            '(77, 17, \'Which is spelled correctly?\', \'Spelling\', 77),'
            '(78, 18, \'Which is spelled correctly?\', \'Spelling\', 78),'
            '(79, 19, \'Which is spelled correctly?\', \'Spelling\', 79),'
            '(80, 20, \'Which is spelled correctly?\', \'Spelling\', 80),'
            '(81, 1, \'How can you repeat a set of instructions multiple times?\', \'Programming\', 81),'
            '(82, 2, \'Why do you need a break in a while loop?\', \'Programming\', 82),'
            '(83, 3, \'What is a variable?\', \'Programming\', 83),'
            '(84, 4, \'What is a function?\', \'Programming\', 84),'
            '(85, 5, \'What is a class?\', \'Programming\', 85),'
            '(86, 6, \'What is an object?\', \'Programming\', 86),'
            '(87, 7, \'Which of the following is not a programming language?\', \'Programming\', 87),'
            '(88, 8, \'Which of the following is not a programming language?\', \'Programming\', 88),'
            '(89, 9, \'What is the use of a for-each loop?\', \'Programming\', 89),'
            '(90, 10, \'Which of the following is a list?\', \'Programming\', 90),'
            '(91, 11, \'Which of the following evaluates to a boolean?\', \'Programming\', 91),'
            '(92, 12, \'What data type is this? 13\', \'Programming\', 92),'
            '(93, 13, \'What data type is this? 26.58\', \'Programming\', 93),'
            '(94, 14, \'Which of the following statements is a conditional statement?\', \'Programming\', 94),'
            '(95, 15, \'Which of the following is the best to use as a name of a variable representing the name of a bicycle?\', \'Programming\', 95),'
            '(96, 16, \'What is a good name for a function that takes in an integer and returns the number squared?\', \'Programming\', 96),'
            '(97, 17, \'What needs to be included in an if statement?\', \'Programming\', 97),'
            '(98, 18, \'Which is not a development environment?\', \'Programming\', 98),'
            '(99, 19, \'What is a common way to save and share code for collaboration?\', \'Programming\', 99),'
            '(100, 20, \'What is inheritance?\', \'Programming\', 100);');
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
      "SELECT q.question_text, a1.answer_string AS answer1, a2.answer_string AS answer2, a3.answer_string AS answer3, s.story_string, q.question_subject as subject " +
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
      subject: maps[0]['subject'],
    );
  });
  return eventList[0];
}

// Table Classes
class Save {
  final int save_id;
  int correct_answers;
  int wrong_answers;
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
