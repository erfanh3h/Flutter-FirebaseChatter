import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'chat.g.dart';

@HiveType(typeId: 0)
class ChatModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String senderEmail;
  @HiveField(3)
  final String receiverEmail;
  @HiveField(4)
  final DateTime date;

  ChatModel({
    @required this.id,
    @required this.text,
    @required this.receiverEmail,
    @required this.senderEmail,
    @required this.date,
  });
  factory ChatModel.fromJson(
    Map datas,
    String id,
  ) {
    return ChatModel(
      id: id,
      text: datas['text'],
      receiverEmail: datas['receiverEmail'],
      senderEmail: datas['senderEmail'],
      date: DateTime.fromMillisecondsSinceEpoch(datas['date']),
    );
  }
}

// @HiveType(typeId: 0)
// class ChatDatabaseModel extends HiveObject {
//   @HiveField(0)
//   String name;

//   @HiveField(1)
//   int age;
// }
