//import 'dart:io';

import 'package:brave_player/musicplay.dart';
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';
//import 'package:just_audio_cache/just_audio_cache.dart';
//import 'package:brave_player/musicplay.dart';


class MusicsQuery extends StatefulWidget {
  const MusicsQuery({Key? key}) : super(key: key);

  @override
  State<MusicsQuery> createState() => _MusicsQueryState();
}

class _MusicsQueryState extends State<MusicsQuery> {

  final FlutterAudioQuery audioQuery= FlutterAudioQuery(); // For querying audios from phone/local
  List<SongInfo> songs=[]; // Holding list of audios queried/found
  int currentIndex=0; // hold current song
  final GlobalKey<MusicPlayerState> key=GlobalKey<MusicPlayerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAudios();   // initiate the function of querying audios
  }

  void getAudios() async{
    songs= await audioQuery.getSongs();
    setState(() {
      songs=songs;             // Function for getting all audios from device storage
    });
  }

  void changeAudio(bool isNext){
    if(isNext){
      if(currentIndex!=songs.length-1){
        currentIndex++;
      }
      else{
        if(currentIndex!=0){
          currentIndex--;
        }
      }

    }
    key.currentState?.setSong(songs[currentIndex]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Braveplay",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.lightGreen,
        elevation: 0.0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded,))
        ],
      ),
      body: ListView.separated(

          separatorBuilder: (context,index){
            return Divider(
              height: 10,
              color: Colors.lightGreen,
              endIndent: 0,
            );
          },
        physics: ClampingScrollPhysics(),
          itemCount: songs.length,
          itemBuilder: (context,index){
            return ListTile(
              leading: const CircleAvatar(
                backgroundImage:  AssetImage('images/music.png'),
                  //songs[index].albumArtwork==null?AssetImage('/images/music.png'):
                //                 FileImage(File(songs[index].albumArtwork),scale: 4),
              ),
              title: Text(
                songs[index].title,
              ),
              subtitle: Text(
                songs[index].artist,
              ),
              onTap: (){
                currentIndex=index;
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return MusicPlayer(songInfo: songs[currentIndex],changeAudio: changeAudio,key: key,);
                  })
                );
               },
            );

         },
      ),
    );
  }
}
