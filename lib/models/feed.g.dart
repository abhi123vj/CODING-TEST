// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedsAdapter extends TypeAdapter<Feeds> {
  @override
  final int typeId = 0;

  @override
  Feeds read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Feeds(
      id: fields[0] as String,
      channelname: fields[1] as String,
      title: fields[2] as String,
      highthumbnail: fields[3] as String,
      localpath: fields[4] as String,
      imagename: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Feeds obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.channelname)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.highthumbnail)
      ..writeByte(4)
      ..write(obj.localpath)
      ..writeByte(5)
      ..write(obj.imagename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
