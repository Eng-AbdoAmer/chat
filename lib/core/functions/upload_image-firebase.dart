// //UploadTask? uploadTask;
//   void uploadImageToFirebaseStorage() async {
//     final path = 'files/${uploadImage!.name}';
//     final file = File(uploadImage!.path);
//     final ref = FirebaseStorage.instance.ref().child(path);
//     uploadTask = ref.putFile(file);
//     final snapShot = await uploadTask!.whenComplete(() {});
//     await snapShot.ref.getDownloadURL().then((value) async {
//       emit(AddImageInFirebaseLoadingState());
//       addImagesToFireStore(ImageItem(
//           imagePath: value,
//           imageName: path,
//           imageDate: DateFormat('y-MM-dd').format(DateTime.now()),
//           imageTime: DateFormat('h:mm').format(DateTime.now())));
//       emit(AddImageInFirebaseSuccessState());
//     }).catchError((error) {
//       emit(AddImageInFirebaseFailedState());
//     });
//   }