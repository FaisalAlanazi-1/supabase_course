import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_course/services/note.dart';

class Create extends StatefulWidget {
  final Map<String, dynamic>? note;
  const Create({super.key, this.note});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController contentCon = TextEditingController();
  File? pickedImage;

  @override
  void initState() {
    // TODO: implement initState
    widget.note != null ? titleCon.text = widget.note!['title'] : null;
    widget.note != null ? contentCon.text = widget.note!['content'] : null;
    super.initState();
  }

  Future<void> pickImage() async {
    final image = await ImagePicker.platform.getImageFromSource(
      source: ImageSource.gallery,
    );
    image != null
        ? setState(() {
            pickedImage = File(image.path);
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.note != null ? 'Edit' : 'Add',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: ListView(
          children: [
            // title
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: titleCon,
              decoration: InputDecoration(
                hint: Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            // content
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: contentCon,
              decoration: InputDecoration(
                hint: Text(
                  'Content',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 50),
            pickedImage != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.file(pickedImage!),
                  )
                : SizedBox.shrink(),
            // upload image
            ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: Text(
                'Pick image',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Save Button
            ElevatedButton(
              onPressed: () async {
                try {
                  final String? imagePath;
                  pickedImage != null
                      ? imagePath = await Note().uploadImage(pickedImage!)
                      : imagePath = null;
                  widget.note == null
                      ? Note().create(titleCon.text, contentCon.text, imagePath)
                      : Note().update(
                          widget.note!['id'],
                          titleCon.text,
                          contentCon.text,
                          imagePath,
                        );
                  Navigator.of(context).pop();
                } on Exception catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
