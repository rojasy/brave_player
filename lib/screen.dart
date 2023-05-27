import 'package:brave_player/songs.dart';
import "package:flutter/material.dart";

class  extends StatefulWidget {
  const ({Key? key}) : super(key: key);

  @override
  State<> createState() => _State();
}

class _State extends State<> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController= TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Braveplay"),
        backgroundColor: Colors.lightGreen[500],
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: (){},
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: [
            Text("Songs",style: TextStyle(fontSize: 20,color: Colors.white),),
            Text("Albums",style: TextStyle(fontSize: 20,color: Colors.white),),
            Text("Artists",style: TextStyle(fontSize: 20,color: Colors.white),),
          ],

        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          SongsList(),
          Center(
            child:
            Text("Albums"),
          ),
          Center(
            child:
            Text("Artsits"),
          ),
        ],
      ),
    );
  }
}
