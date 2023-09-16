import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserId extends StatefulWidget {
  const UserId({Key? key}) : super(key: key);

  @override
  State<UserId> createState() => _UserIdState();
}

class _UserIdState extends State<UserId> {
  // ignore: unused_field
  late File _file;

  // ignore: non_constant_identifier_names
  Future Pickercamera() async {
    // ignore: deprecated_member_use
    final myfile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _file = File(myfile!.path);
    });
  }

  @override
  // void initState() {
  //   super.initState();
  //   //File = file;
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image uploud'),
      ),
      body: Column(
        children: <Widget>[
          IconButton(onPressed: Pickercamera, icon: const Icon(Icons.photo)),
          // ignore: unnecessary_null_comparison
         // Center(child: _file==null ? const Text('image') : Image.file(_file))
        ],
      ),
    );
  }
}
