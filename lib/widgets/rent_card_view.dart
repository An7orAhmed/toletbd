import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:toletbd/screen/owner/edit_flat.dart';
import 'package:toletbd/screen/renter/flat_details.dart';
import '../model/rent.dart';

Widget rentCardView(context, Rent rent) {
  return Card(
    elevation: 4.5,
    margin: const EdgeInsets.all(15),
    child: InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlatDetails(rent))),
      child: Column(
        children: [
          Expanded(
            child: rent.imgList.isEmpty
                ? Image.asset("assets/home.png")
                : CachedNetworkImage(
                    imageUrl: rent.imgList,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const LinearProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset("assets/home.png"),
                  ),
          ),
          ListTile(
            title: Text(rent.title),
            subtitle: Text(rent.location),
            trailing: Container(
              height: 40,
              width: 70,
              color: rent.isRented ? Colors.redAccent : Colors.greenAccent,
              child: Center(child: Text(rent.isRented ? "RENTED" : "VACANT")),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget rentCardViewAdmin(context, Rent rent) {
  return Card(
    elevation: 4.5,
    margin: const EdgeInsets.all(15),
    child: InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditFlat(rent))),
      child: Column(
        children: [
          Expanded(
            child: rent.imgList.isEmpty
                ? Image.asset("assets/home.png")
                : CachedNetworkImage(
                    imageUrl: rent.imgList,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const LinearProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset("assets/home.png"),
                  ),
          ),
          ListTile(
            title: Text(rent.title),
            subtitle: Text(rent.location),
            trailing: Container(
              height: 40,
              width: 70,
              color: rent.isRented ? Colors.redAccent : Colors.greenAccent,
              child: Center(child: Text(rent.isRented ? "RENTED" : "VACANT")),
            ),
          ),
        ],
      ),
    ),
  );
}
