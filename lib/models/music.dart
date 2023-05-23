import 'package:uuid/uuid.dart' ;

const uuid = Uuid();

class Music{
  Music({
    required this.title,
    required this.artist,
    required this.url,
    required this.musicLink,
    required this.isFav,
  }):id = uuid.v4();

  final String id;
  final String title;
  final String artist;
  final String url;
  final String musicLink;
  final bool isFav;
}