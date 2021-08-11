import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:prooxyy_events/helpers/helpers.dart';
import 'package:prooxyy_events/widgets/app_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageUploader extends StatefulWidget {
  final Function onFileAdded;
  ImageUploader({required this.onFileAdded});
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  List<String> images = [];
  List<int> selection = [];
  bool uploading = false;
  int _index = 0;
  double? uploadProgress;

  void addImage() async {
    print('It at least came here: ');
    TaskSnapshot? uTask = await uploadFile();
    print('This is the value gotten from file upload: $uTask');
    if (uTask != null) {
      String downloadUrl = await uTask.ref.getDownloadURL();
      setState(() {
        images = [...images, downloadUrl];
      });
      widget.onFileAdded(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      images.length > 0
          ? Image.network(
              images[_index],
              fit: BoxFit.cover,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Center(
                child: Text('Aucune image ajoutée'),
              ),
            ),
      vBox20(),
      images.length > 0
          ? CarouselSlider(
              options: CarouselOptions(
                  height: 100,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.2),
              items: images.asMap().entries.map((entry) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: _index != entry.key
                                  ? ColorFilter.mode(
                                      Colors.black38, BlendMode.darken)
                                  : ColorFilter.mode(
                                      Colors.white10, BlendMode.darken),
                              image: NetworkImage(entry.value),
                              fit: BoxFit.cover),
                        )
                    );
                  },
                );
              }).toList(),
            )
          : Container(),
      vBox20(),
      images.length > 0
          ? AnimatedSmoothIndicator(
              activeIndex: this._index,
              count: images.length,
              effect: WormEffect(),
              onDotClicked: (index) {
                print('This is the $index');
                setState(() {
                  this._index = index;
                });
              },
            )
          : Container(),
      vBox20(),
      AppButton(
          text: 'Ajoutez une image',
          color: Theme.of(context).primaryColor,
          handler: addImage)
    ]));
  }
}
