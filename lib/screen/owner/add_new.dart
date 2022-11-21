import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toletbd/model/rent.dart';
import '../../constants.dart';
import '../../utilities.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  bool rentType = true;
  bool isLiftAvailable = false;
  bool isParkingAvailable = false;
  final title = TextEditingController();
  final description = TextEditingController();
  final whichFloor = TextEditingController();
  final totalRoom = TextEditingController();
  final bathroom = TextEditingController();
  final totalSize = TextEditingController();
  final location = TextEditingController();
  final feeLow = TextEditingController();
  final feeHigh = TextEditingController();
  String rentTypeLabel = "Family";
  String imgURL = "";

  List<Widget> typeLabel = [
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text("Family"),
    ),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text("Bachelor"),
    )
  ];
  List<Widget> stateLabel = [const Text("YES"), const Text("NO")];

  @override
  Widget build(BuildContext context) {
    List<bool> types = [rentType, !rentType];
    List<bool> lift = [isLiftAvailable, !isLiftAvailable];
    List<bool> parking = [isParkingAvailable, !isParkingAvailable];

    _addRentData(context) {
      if (title.text.isEmpty ||
          description.text.isEmpty ||
          location.text.isEmpty ||
          feeLow.text.isEmpty ||
          feeHigh.text.isEmpty ||
          totalRoom.text.isEmpty ||
          bathroom.text.isEmpty ||
          whichFloor.text.isEmpty ||
          totalSize.text.isEmpty) {
        scafKey.currentState!.showSnackBar(snackBar(Colors.orange, Colors.white,
            Icons.warning, 'Please fillup form properly.'));
        return;
      }
      var rent = Rent(
          addedBy: currentUser.email,
          title: title.text,
          imgList: imgURL,
          rentType: rentTypeLabel,
          description: description.text,
          location: location.text,
          addedTime: DateTime.now().millisecondsSinceEpoch.toString(),
          rentFeeStart: int.parse(feeLow.text),
          rentFeeEnd: int.parse(feeHigh.text),
          roomCount: int.parse(totalRoom.text),
          bathroowCount: int.parse(bathroom.text),
          floorNo: int.parse(whichFloor.text),
          size: int.parse(totalSize.text),
          isLiftAvailable: isLiftAvailable,
          isParkingAvailable: isParkingAvailable,
          isRented: false);
      rentList.rents.add(rent);
      scafKey.currentState!.showSnackBar(snackBar(
          Colors.green, Colors.white, Icons.pending, 'Adding new rent...'));
      db.collection("Data").doc("Rents").set(rentList.toMap());
      Navigator.of(context).pop();
    }

    _loadAllImages() {
      imgPath.clear();
      storage.listAll().then((value) {
        var items = value.items;
        for (var item in items) {
          item.getDownloadURL().then((value) => imgPath.add(value));
        }
      });
    }

    _uploadImage(context) async {
      var file = await ImagePicker().pickImage(source: ImageSource.gallery);
      var image = await file!.readAsBytes();
      var filename = "IMG-${DateTime.now().millisecondsSinceEpoch}.jpg";
      var imageRef = storage.child(filename);
      scafKey.currentState!.showSnackBar(snackBar(
          Colors.orange, Colors.white, Icons.pending, 'Uploading image...'));
      imageRef
          .putData(image, SettableMetadata(contentType: "image/jpeg"))
          .whenComplete(() {
        scafKey.currentState!.showSnackBar(
            snackBar(Colors.green, Colors.white, Icons.done, 'Uploaded.'));
        storage.child(filename).getDownloadURL().then((value) {
          imgURL = value;
          _loadAllImages();
          setState(() {});
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post new rent"),
        actions: [
          IconButton(
              onPressed: () => _addRentData(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: OutlinedButton(
                  onPressed: () => _uploadImage(context),
                  child: const Text("Choose Image..."),
                ),
              ),
              const SizedBox(height: 15),
              imgURL.isEmpty
                  ? Image.asset("assets/home.png")
                  : CachedNetworkImage(
                      imageUrl: imgURL,
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/home.png"),
                    ),
              const SizedBox(height: 15),
              TextField(
                controller: title,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter your post title",
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: description,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter your house details",
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: totalRoom,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter your how many rooms",
                  labelText: "Room Count",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: bathroom,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter your how many bathrooms",
                  labelText: "Bathroom Count",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: whichFloor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter which floor",
                  labelText: "Floor No.",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: totalSize,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter flat size in sq. feet",
                  labelText: "Size",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: location,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter your house location",
                  labelText: "Location",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: feeLow,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter minimum rent fee",
                  labelText: "Min. Fee",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: feeHigh,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter maximum rent fee",
                  labelText: "Max. Fee",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                title: const Text("Rent Type"),
                trailing: ToggleButtons(
                  isSelected: types,
                  children: typeLabel,
                  onPressed: (i) {
                    rentType = !rentType;
                    if (rentType == true) {
                      rentTypeLabel = "Family";
                    } else {
                      rentTypeLabel = "Bachelor";
                    }
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                title: const Text("Lift/Elevator"),
                trailing: ToggleButtons(
                  isSelected: lift,
                  children: stateLabel,
                  onPressed: (i) {
                    isLiftAvailable = !isLiftAvailable;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                title: const Text("Car Parking"),
                trailing: ToggleButtons(
                  isSelected: parking,
                  children: stateLabel,
                  onPressed: (i) {
                    isParkingAvailable = !isParkingAvailable;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: OutlinedButton(
                  onPressed: () => _addRentData(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Text("Add Rental"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
