//import 'package:audioplayers/audioplayers.dart';
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';

class PlaySong extends StatefulWidget {

  SongInfo songInfo;
  Function changeAudio;
  final GlobalKey<PlaySongState> key;
   PlaySong({required this.songInfo, required this.changeAudio,required this.key}) : super(key: key);

  @override
  State<PlaySong> createState() => PlaySongState();
}

class PlaySongState extends State<PlaySong> {

  final AudioPlayer audioPlayer=AudioPlayer();
  double currentValue=0.0,minValue=0.0,maxValue=0.0;
  String currentTime='',endTime='';
  bool isPlaying=false;
  bool isRepeat=false;

  @override
  void initState() {
    setSong(widget.songInfo);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }


  void setSong(SongInfo songInfo) async{
    widget.songInfo=songInfo;
    await audioPlayer.setUrl(widget.songInfo.uri);


    currentValue=minValue;
    maxValue= audioPlayer.duration!.inSeconds.toDouble();
    setState(() {
      currentTime=getDuration(currentValue);
      endTime=getDuration(maxValue);
    });
    isPlaying=false;
    changeStatus();
    audioPlayer.positionStream.listen((duration) {
      currentValue=duration.inSeconds.toDouble();
      setState(() {
        currentTime=getDuration(currentValue);
      });
    });

    audioPlayer.playerStateStream.listen((event) {
      if(event.processingState==ProcessingState.completed){
          setState(() {


            audioPlayer.seek(Duration.zero);
            if(isRepeat==true){
              isPlaying=true;
            }else{
              isPlaying=false;
              isRepeat=false;
              audioPlayer.stop();
            }

          });
      }
    });

  }

  void changeStatus(){
    setState(() {
      isPlaying=!isPlaying;
    });
    if(isPlaying){
      audioPlayer.play();
    }
    else{
      audioPlayer.pause();
    }
  }

  String getDuration(double value){
    Duration duration=Duration(seconds: value.round());
    return [duration.inMinutes, duration.inSeconds].map((element) => element.remainder(60).toString().padLeft(2,'0')).join(":");
  }

  Widget slider(){
    return Container(
      width: MediaQuery.of(context).size.width/1.5,
      //height: 20,
      child: Slider.adaptive(
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          value: currentValue,
          min:minValue,
          max:maxValue,
          onChanged: (value){
            currentValue=value;
            audioPlayer.seek(Duration(seconds:currentValue.round()));
          }
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[500],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,top: 5,right: 5,bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.lightGreen[500],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 370,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/musicwallpaper.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 10,),

            Center(
              // child: Marquee(
              //   text: widget.songInfo.title,
              //   blankSpace: 20,
              //   pauseAfterRound: Duration(seconds: 1),
              // ),
              child: Text(
                widget.songInfo.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),

            SizedBox(height: 5,),

            Center(
              child: Text(
                widget.songInfo.artist,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
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

            //SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: IconButton(
                    icon: Icon(Icons.repeat),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: (){
                      if(isRepeat==false){
                        audioPlayer.setLoopMode(LoopMode.one);
                        setState(() {
                          isRepeat=true;
                          isPlaying=true;
                          Colors.green;
                        });
                      }else if(isRepeat==true){
                        audioPlayer.setLoopMode(LoopMode.off);
                        Colors.grey;
                        setState(() {
                          isPlaying=false;
                          isRepeat=false;
                        });
                      }
                    },
                  ),
                ),

                GestureDetector(
                  child: IconButton(
                    icon: Icon(Icons.skip_previous),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: (){
                      widget.changeAudio(false);
                    },
                  ),
                ),

                GestureDetector(
                  child:
                    Icon(isPlaying?Icons.pause_circle_filled_rounded:Icons.play_circle_fill,
                      size: 80,
                      color: Colors.white,
                  ),
                  onTap: (){
                    changeStatus();
                  },
                ),

                GestureDetector(
                  child: IconButton(
                    icon: Icon(Icons.skip_next),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: (){
                      widget.changeAudio(true);
                    },
                  ),
                ),

                GestureDetector(
                  child: IconButton(
                    icon: Icon(Icons.shuffle_sharp),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: (){
                      audioPlayer.setShuffleModeEnabled(true);
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
