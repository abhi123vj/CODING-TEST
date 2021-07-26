import 'package:hive/hive.dart';
part 'feed.g.dart';

@HiveType(typeId: 0)
class Feeds extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String channelname;
  @HiveField(2)
  String title;
  @HiveField(3)
  String highthumbnail;
    @HiveField(4)
  String localpath;
    @HiveField(5)
  String imagename;

  Feeds(
      {required this.id,
      required this.channelname,
      required this.title,
      required this.highthumbnail,
       required this.localpath,
        required this.imagename});
}
