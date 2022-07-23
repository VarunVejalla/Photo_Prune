import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_compare/image_compare.dart';

//from the image_picker API:
// "No configuration required - the plugin should work out of the box.
// It is however highly recommended to prepare for Android killing the
// application when low on memory. How to prepare for this is discussed
// in the Handling MainActivity destruction on Android section."


// get access to pictures somehow (either all or a user-selected subset)

// separate the pictures into groups
// want some measure ranging from 0 to 1 here saying how strict it is for differentiating between groups
// 0 should be "doesn't differentiate at all, everything's the same group"
// 1 should be "differentiates completely, every pic is a different group (unless two are the *exact* same)"
// should default to some "best" value in that range, but give user option to change it

// give the user the option to move pictures in groups around (in case the algorithm isn't perfect) and also have option to continue

// once the user has hit the continue button, identify and show "best" picture in each group

// give option to delete other pics or to select certain pics to delete
// might not be possible depending on how deleting photos is managed by non-standard photos apps

// from the best picture in each group, find k most memorable pictures

// give option to post it to instagram with some caption

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_prune/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SelectedImages images = SelectedImages();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectPage(title: 'Flutter Demo Home Page', images: images),
    );
  }
}

class SelectedImages {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageList = [];

  void addToImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
    imageList!.addAll(selectedImages);
    }
  }

}

class SelectPage extends StatefulWidget {
  final SelectedImages images;

  const SelectPage({Key? key, required this.title, required this.images}) : super(key: key);

  final String title;

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  void selectImages() async {
    widget.images.addToImages();

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Selecting Images"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                      "Pick Images from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    selectImages();
                  }
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: widget.images.imageList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(File(widget.images.imageList![index].path), fit: BoxFit.cover);
                        }
                    ),
                  )
              )
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Continue on to next phase",
        child: const Text("Next")
      ),
      persistentFooterButtons: [
        MaterialButton(
          onPressed: () {},
          child: const Text("Previous Collections")
        ),
        MaterialButton(
          onPressed: () {},
          child: const Text("About")
        )
      ],
    );
  }
}

// class PruningPage extends StatefulWidget {
//   const PruningPage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<PruningPage> createState() => _PruningPageState();
// }
//
// class _PruningPageState extends State<PruningPage> {
//
//
// }