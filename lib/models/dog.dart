
import 'package:hive/hive.dart';
part 'dog.g.dart';

// flutter packages pub run build_runner build

@HiveType(typeId: 0)
class Dog {

  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;

  Dog({required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {      
      'name': name,
      'age': age
    };
  }

  static Dog fromMap(Map<String, dynamic> map) {
    return Dog(name: map['name'], age: map['age']);
  }
}