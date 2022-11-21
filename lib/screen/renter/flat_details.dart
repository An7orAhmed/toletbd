import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:toletbd/screen/renter/contact_form.dart';
import '../../model/rent.dart';

class FlatDetails extends StatelessWidget {
  Rent rent;
  FlatDetails(this.rent, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(rent.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  rent.imgList.isEmpty
                      ? Image.asset("assets/home.png")
                      : CachedNetworkImage(
                          imageUrl: rent.imgList,
                          placeholder: (context, url) => const LinearProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset("assets/home.png"),
                        ),
                  Container(
                    height: 40,
                    width: 70,
                    color: rent.isRented ? Colors.redAccent : Colors.greenAccent,
                    child: Center(child: Text(rent.isRented ? "RENTED" : "VACANT")),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(rent.description),
              const SizedBox(height: 15),
              ListTile(
                title: const Text("Rent Type"),
                trailing: Text(rent.rentType),
              ),
              ListTile(
                title: const Text("Which Floor"),
                trailing: Text("${rent.floorNo}"),
              ),
              ListTile(
                title: const Text("Total Room"),
                trailing: Text("${rent.roomCount}"),
              ),
              ListTile(
                title: const Text("Bathroom"),
                trailing: Text("${rent.bathroowCount}"),
              ),
              ListTile(
                title: const Text("Total Size"),
                trailing: Text("${rent.size} sq. feet"),
              ),
              ListTile(
                title: const Text("Lift/Elevator"),
                trailing: Text(rent.isLiftAvailable ? "YES" : "NO"),
              ),
              ListTile(
                title: const Text("Car Parking"),
                trailing: Text(rent.isParkingAvailable ? "YES" : "NO"),
              ),
              ListTile(
                title: const Text("Location"),
                trailing: Text(rent.location),
              ),
              ListTile(
                title: const Text("Expected Rent"),
                trailing: Text("${rent.rentFeeStart}-${rent.rentFeeEnd}TK"),
              ),
              rent.isRented
                  ? const SizedBox.shrink()
                  : Center(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ContactForm(rent.addedBy),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          child: Text("Contact with owner"),
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
