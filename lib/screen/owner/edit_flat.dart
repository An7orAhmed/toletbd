import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';
import '../../model/rent.dart';
import '../../utilities.dart';

class EditFlat extends StatefulWidget {
  Rent rent;
  EditFlat(this.rent, {Key? key}) : super(key: key);

  @override
  State<EditFlat> createState() => _EditFlatState();
}

class _EditFlatState extends State<EditFlat> {
  bool rentType = false;
  final title = TextEditingController();
  final description = TextEditingController();
  final whichFloor = TextEditingController();
  final totalRoom = TextEditingController();
  final bathroom = TextEditingController();
  final totalSize = TextEditingController();
  final location = TextEditingController();
  final feeLow = TextEditingController();
  final feeHigh = TextEditingController();

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
    title.text = widget.rent.title;
    description.text = widget.rent.description;
    whichFloor.text = widget.rent.floorNo.toString();
    totalRoom.text = widget.rent.roomCount.toString();
    bathroom.text = widget.rent.bathroowCount.toString();
    totalSize.text = widget.rent.size.toString();
    location.text = widget.rent.location;
    feeLow.text = widget.rent.rentFeeStart.toString();
    feeHigh.text = widget.rent.rentFeeEnd.toString();

    rentType = widget.rent.rentType == "Family" ? true : false;
    List<bool> types = [rentType, !rentType];
    List<bool> lift = [widget.rent.isLiftAvailable, !widget.rent.isLiftAvailable];
    List<bool> parking = [widget.rent.isParkingAvailable, !widget.rent.isParkingAvailable];

    _saveRentData(context) {
      rentList.rents.removeWhere(
          (element) => element.addedBy == widget.rent.addedBy && element.addedTime == widget.rent.addedTime);
      rentList.rents.add(widget.rent);
      scafKey.currentState!.showSnackBar(snackBar(Colors.green, Colors.white, Icons.pending, 'Saving updated data...'));
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
      scafKey.currentState!.showSnackBar(snackBar(Colors.orange, Colors.white, Icons.pending, 'Uploading image...'));
      imageRef.putData(image, SettableMetadata(contentType: "image/jpeg")).whenComplete(() {
        scafKey.currentState!.showSnackBar(snackBar(Colors.green, Colors.white, Icons.done, 'Uploaded.'));
        storage.child(filename).getDownloadURL().then((value) {
          int i = widget.rent.imgList.indexOf("IMG-");
          int j = widget.rent.imgList.indexOf("jpg");
          String oldImg = widget.rent.imgList.substring(i, j + 3);
          storage.child(oldImg).delete();
          widget.rent.imgList = value;
          _loadAllImages();
          setState(() {});
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rent.title),
        actions: [IconButton(onPressed: () => _saveRentData(context), icon: const Icon(Icons.save))],
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
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  widget.rent.imgList.isEmpty
                      ? Image.asset("assets/home.png")
                      : CachedNetworkImage(
                          imageUrl: widget.rent.imgList,
                          placeholder: (context, url) => const LinearProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset("assets/home.png"),
                        ),
                  Container(
                    height: 40,
                    width: 70,
                    color: widget.rent.isRented ? Colors.redAccent : Colors.greenAccent,
                    child: Center(child: Text(widget.rent.isRented ? "RENTED" : "VACANT")),
                  ),
                ],
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
                      widget.rent.rentType = "Family";
                    } else {
                      widget.rent.rentType = "Bachelor";
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
                    widget.rent.isLiftAvailable = !widget.rent.isLiftAvailable;
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
                    widget.rent.isParkingAvailable = !widget.rent.isParkingAvailable;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Status: "),
                  ChoiceChip(
                    label: const Text("RENTED"),
                    labelPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    selected: widget.rent.isRented,
                    onSelected: ((value) {
                      widget.rent.isRented = !widget.rent.isRented;
                      setState(() {});
                    }),
                  ),
                  ChoiceChip(
                    label: const Text("VACANT"),
                    labelPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    selected: !widget.rent.isRented,
                    onSelected: ((value) {
                      widget.rent.isRented = !widget.rent.isRented;
                      setState(() {});
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
