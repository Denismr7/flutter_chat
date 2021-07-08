import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) onImagePicked;
  const UserImagePicker(this.onImagePicked);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  void _pickImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 30,
      maxWidth: 150,
    );
    if (pickedFile == null) {
      return;
    }

    setState(() {
      _pickedImage = File(pickedFile.path);
    });
    widget.onImagePicked(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage!),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
          style: TextButton.styleFrom(
            onSurface: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
