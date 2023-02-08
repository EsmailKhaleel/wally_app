// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallyapp/screens/add_wallpaper_screen.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var images = [
    "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg",
    "https://thumbs.dreamstime.com/b/yellow-dahlia-fine-art-flower-photography-black-background-yellow-dahlia-fine-art-flower-photography-black-background-198343653.jpg",
    "https://w0.peakpx.com/wallpaper/654/556/HD-wallpaper-white-flower-ds-ali-flowers-black-lotus-pink-beautiful-nature-new-thumbnail.jpg",
    "https://as1.ftcdn.net/v2/jpg/02/96/12/56/1000_F_296125609_R9udLZ4jFj6Qx8RbBHo8EWCX78714uxL.jpg",
    "https://c0.wallpaperflare.com/preview/781/619/672/red-rose-behind-white-flowers-in-black-background-thumbnail.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOoCUh46b_yY--kR1U4KPXUiNvy471AM00HsRij1rYsOv4HL4K9TsdtDPtA_7QpAzxRWM&usqp=CAU",
    "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg",
    "https://thumbs.dreamstime.com/b/yellow-dahlia-fine-art-flower-photography-black-background-yellow-dahlia-fine-art-flower-photography-black-background-198343653.jpg",
    "https://w0.peakpx.com/wallpaper/654/556/HD-wallpaper-white-flower-ds-ali-flowers-black-lotus-pink-beautiful-nature-new-thumbnail.jpg",
    "https://as1.ftcdn.net/v2/jpg/02/96/12/56/1000_F_296125609_R9udLZ4jFj6Qx8RbBHo8EWCX78714uxL.jpg",
    "https://c0.wallpaperflare.com/preview/781/619/672/red-rose-behind-white-flowers-in-black-background-thumbnail.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOoCUh46b_yY--kR1U4KPXUiNvy471AM00HsRij1rYsOv4HL4K9TsdtDPtA_7QpAzxRWM&usqp=CAU",
    "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  fetchUserData() async {
    final u = await _auth.currentUser;
    setState(() {
      user = u!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: FadeInImage(
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                          placeholder: AssetImage("assets/placeholder.jpg"),
                          image: NetworkImage(user!.photoURL!))),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    user!.displayName!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Wallpapers",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => AddWallpaperScreen()),
                                  fullscreenDialog: true,
                                ));
                          },
                          icon: Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: images.length,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
