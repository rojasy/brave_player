//import 'package:audioplayers/audioplayers.dart';
// ignore_for_file: must_be_immutable

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:brave_player/musics.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
//import 'package:just_audio_cache/just_audio_cache.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  SongInfo songInfo;
  Function changeAudio;
  final GlobalKey<MusicPlayerState> key;
  MusicPlayer({required this.songInfo,required this.changeAudio,required this.key}):super(key: key);
  //const MusicPlayer({Key? key}) : super(key: key);

  @override
  MusicPlayerState createState() => MusicPlayerState();
}


class MusicPlayerState extends State<MusicPlayer> {

  double minValue=0.0, maxValue=0.0, currentValue=0.0;
  String currentTime='', endTime='';
  bool isPlaying=false;
  bool isRepeat=false;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSong(widget.songInfo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }



  void setSong(SongInfo songInfo) async{
    widget.songInfo=songInfo;
    await player.setUrl(widget.songInfo.uri);

    currentValue=minValue;
    maxValue= player.duration!.inSeconds.toDouble();
    setState(() {
      currentTime=getDuration(currentValue);
      endTime=getDuration(maxValue);
    });
    isPlaying=false;
    changeStatus();
    player.positionStream.listen((duration) {
      currentValue=duration.inSeconds.toDouble();
      setState(() {
        currentTime=getDuration(currentValue);
      });
    });
  }

  void changeStatus(){
    setState(() {
      isPlaying=!isPlaying;
    });
    if(isPlaying){
      player.play();
    }
    else{
      player.pause();
    }
  }

  String getDuration(double value){
    Duration duration=Duration(seconds: value.round());
    return [duration.inMinutes, duration.inSeconds].map((element) => element.remainder(60).toString().padLeft(2,'0')).join(":");
  }

  Widget slider(){
    return Container(
      width: MediaQuery.of(context).size.width/1.5,
      height: 20,
      child: Slider.adaptive(
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          value: currentValue,
          min: minValue,
          max: maxValue,
          onChanged: (value){
            currentValue=value;
            player.seek(Duration(seconds:currentValue.round()));
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
            ),
            Center(
              child: Container(
                height: 300,
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/musicwallpaper.jpg"),
                  maxRadius: 350,
                  minRadius: 100,
                 // radius: 150,
                )
              ),
            ),
            SizedBox(height: 5,),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      Text(
                        widget.songInfo.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),

                  //SizedBox(height: 1,),
                     Text(
                      widget.songInfo.artist,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                ],
              ),
            ),



            Expanded(
              child: Container(transform: Matrix4.translationValues(0, -15, 0),margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Text(currentTime, style: TextStyle(
                          color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w500,
                      ),
                      ),
                    slider(),
                      Text(endTime, style: TextStyle(
                          color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w500,
                      ))
              ],),),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: IconButton(
                      icon: Icon(Icons.repeat,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      //behavior:HitTestBehavior.translucent,
                      onPressed: (){
                        // if(isRepeat==false){
                        //   player.setReleaseMode(ReleaseMode.LOOP);
                        //   setState(() {
                        //     isRepeat=true;
                        //   });
                        // }else if(isRepeat==true){
                        //   player.setREleaseMode(ReleaseMode.RELEASE);
                        //   isRepeat=false;
                        // }
                      },
                    ),
                  ),
                  GestureDetector(
                    child: IconButton(
                      icon: Icon(Icons.skip_previous,
                      size: 50.0,
                        color: Colors.white,
                      ),
                      //behavior:HitTestBehavior.translucent,
                      onPressed: (){
                        widget.changeAudio(false);
                      },
                    ),
                  ),

                  GestureDetector(
                    child:
                      Icon(isPlaying?Icons.pause_circle_filled_rounded:Icons.play_circle_fill_rounded,
                        size: 100.0,
                        color: Colors.white,
                      ),
                      //behavior:HitTestBehavior.translucent,
                      onTap: (){
                        changeStatus();
                      },

                  ),

                  GestureDetector(
                    child: IconButton(
                      icon: Icon(Icons.skip_next,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      //behavior:HitTestBehavior.translucent,
                      onPressed: (){
                        widget.changeAudio(true);
                      },
                    ),
                  ),
                  GestureDetector(
                    child: IconButton(
                      icon: Icon(Icons.shuffle_sharp,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      //behavior:HitTestBehavior.translucent,
                      onPressed: (){

                      },
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
