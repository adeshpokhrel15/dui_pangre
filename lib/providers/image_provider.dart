import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider =
    ChangeNotifierProvider.autoDispose((ref) => ImageProvider());
final imageProvider1 =
    ChangeNotifierProvider.autoDispose((ref) => ImageProvider1());

class ImageProvider extends ChangeNotifier {
  XFile? image; // XFile is a class from the image_picker package
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    image = await picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }
}

class ImageProvider1 extends ChangeNotifier {
  XFile? image; // XFile is a class from the image_picker package
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    image = await picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }
}
