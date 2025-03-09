import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/dog_form.dart';
import 'package:flutter_hive_demo/models/dog.dart';
import 'package:hive/hive.dart';

class DogList extends StatefulWidget {
  const DogList({super.key});

  @override
  State<DogList> createState() => _DogListState();
}

class _DogListState extends State<DogList> {
  late List<Dog> dogs;
  late Box<Dog> dogBox;

  @override
  void initState() {
    super.initState();
    dogBox = Hive.box<Dog>('dogs');
    dogs = dogBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dog List')),
      body:
          dogs.isEmpty
              ? Center(child: Text('No dogs found.'))
              : ListView.builder(
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  final dog = dogs[index];
                  return ListTile(
                    title: Text(dog.name),
                    subtitle: Text('Age: ${dog.age}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DogForm(dog: dog),
                              ),
                            ).then((value) {
                              if (value == true) {
                                // Refresh the list
                                setState(() {
                                  dogs = dogBox.values.toList();
                                });
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await dogBox.delete(dog.name);
                            setState(() {
                              dogs = dogBox.values.toList();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DogForm()),
          ).then((value) {
            if (value == true) {
              setState(() {
                dogs = dogBox.values.toList();
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
