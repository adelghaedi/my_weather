import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class City extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;

  const City({this.id, required this.name});

  @override
  List<Object?> get props => [name];
}
