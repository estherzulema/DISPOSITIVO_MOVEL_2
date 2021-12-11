import 'package:flutter/material.dart';
import 'package:istragaum/widgets/camera_view.dart';
import 'package:istragaum/widgets/feed.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: const Image(
              image: AssetImage('images/default_profile.jpg'),
            ),
          ),
        ),
        title: const Text(
          'Istragaum',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 35,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.black26,
            height: 1,
          ),
          preferredSize: const Size.fromHeight(1),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: const Feed(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CameraView(),
          )),
        },
        tooltip: 'Tirar foto',
        child: const Icon(
          Icons.photo_camera,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
    );
  }
}
