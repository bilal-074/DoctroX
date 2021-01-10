import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

Future<String> classify(File image) async {
  print('ENTERED CLASSIFIER');
  // File image;
  // String text = '';

  FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);

  final ImageLabeler cloudLabeler = FirebaseVision.instance.imageLabeler();

  final List<ImageLabel> cloudLabels =
      await cloudLabeler.processImage(visionImage);

  // text = '';
  // for (ImageLabel label in cloudLabels) {
  // final double confidence = label.confidence;
  // final String currentLabel = label.text;
  // text += currentLabel + " " + confidence.toStringAsFixed(2) + "\n";
  // text += "$label.text   $confidence.toStringAsFixed(2) \n";
  // text = "'$label\.text'   '$confidence' \n";
  // text += label.text+"\n";
try{
  print("Inside Classifier: ${cloudLabels[0].text}");
}
catch(e)
{
  return("unclassified");
}
  cloudLabeler.close();
  String label = cloudLabels[0].text;
  return (label);
}
