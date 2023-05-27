
import 'dart:io';

import 'package:brave_player/playSong.dart';
import 'package:flutter/material.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongsList extends StatefulWidget {
  const SongsList({Key? key}) : super(key: key);

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {

  final FlutterAudioQuery audioQuery= FlutterAudioQuery();
  List<SongInfo>song=[];
  int currentSong=0;
  final GlobalKey<PlaySongState> key=GlobalKey<PlaySongState>();

  @override
  void initState() {
    super.initState();
    listSong();
  }

  void listSong()async{
    song=await audioQuery.getSongs();
    setState(() {
      song=song;
    });
  }

  void changeAudio(bool isNext){
    if(isNext){
      if(currentSong!=song.length-1){
        currentSong++;
      }
      else{
        if(currentSong!=0){
          currentSong--;
        }
      }
    }
    key.currentState?.setSong(song[currentSong]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: song.length,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context,index){
          return const Divider(
            height: 5,
            color: Colors.lightGreen,
            endIndent: 0,
          );
        },
        itemBuilder: (context,index){
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: song[index].albumArtwork==null?AssetImage("images/musicwallpaper.jpg"):
              Image.file(File(song[index].albumArtwork)).image,
            ),
            title: Text(
              song[index].title,
            ),
            subtitle: Text(
              song[index].artist,
            ),
            onTap: (){
              currentSong=index;
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                return PlaySong( songInfo: song[currentSong],changeAudio: changeAudio, key: key,);
              }
              ));

            },
          );
        },
    );

  }
}
