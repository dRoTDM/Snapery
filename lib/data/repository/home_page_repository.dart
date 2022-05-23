import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tflite/tflite.dart';

class HomePageRepository {
  // final ImagePicker _picker = ImagePicker();

  // Future pickImage() async {
  //   var image = await _picker.getImage(source: ImageSource.gallery);
  //   if (image == null) return null;

  //   loading = true;
  //   image = image;

  //   classifyImage(image);
  // }

  classifyImage(PickedFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    print("This is the firstoutput $output");

    String data = output[0]['label'];

    List<String> outputs = data.split(',');

    print("This is the output $outputs");
    return outputs;
  }

  addToFoodDiary({
    @required CollectionReference foodDiary,
    @required final String username,
    @required final String name,
    @required final String calories,
    @required final String carbohydrate,
    @required final String protein,
    @required final String fat,
  }) async {
    foodDiary.add({
      'username': username,
      'name': name,
      'calories': calories,
      'carbohydrate': carbohydrate,
      'protein': protein,
      'fat': fat,
      'date': DateTime.now(),
    });
  }
}
