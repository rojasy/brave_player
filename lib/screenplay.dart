import 'package:flutter/material.dart';

class ScreenUI extends StatefulWidget {
  const ScreenUI({Key? key}) : super(key: key);

  @override
  State<ScreenUI> createState() => _ScreenUIState();
}

class _ScreenUIState extends State<ScreenUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(onPressed: (){}, child: Text("Local")),
                SizedBox(width: 10,),
                TextButton(onPressed: (){}, child: Text("Online")),
              ],
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/music.png"),
                  fit: BoxFit.cover,
                )
              ),
            ),
            SizedBox(height: 5,),
            Center(
              child: Text("Diamond Platnumz- Fine official Audio"),
            ),
            SizedBox(width: 1,),
            Center(
              child: Text("Diamond Platnumz"),
            ),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("0:0"),
                  slider(),
                  Text("3:0"),
                ],
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.play_disabled,size: 24,)
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.skip_previous,size: 24,)
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.play_circle_fill_rounded, size: 50,)
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.skip_next,size: 24,)
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.shuffle_sharp,size: 24,)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget slider(){
    return Container(
      width: 250,
        child: Slider.adaptive(
          activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            value: 0.0,
            onChanged: (value){}
        ),
    );
  }
}
