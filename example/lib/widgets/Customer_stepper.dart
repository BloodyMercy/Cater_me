import 'package:flutter/material.dart';
const stepperGradientBackward = LinearGradient(
  colors: [
    Color.fromRGBO(253, 202, 29, 1),
    Color.fromRGBO(253, 202, 29, 1)
  ],
  stops: [0.4,0.5],
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,

);
const stepperGradientForward = LinearGradient(
  colors: [
    Color.fromRGBO(253, 202, 29, 1),
    Color.fromRGBO(253, 202, 29, 1),
   // Color(0xFF3F5521),
  ],
  stops: [0.0,0.5],
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,

);

class CustomStepper extends StatefulWidget {
  final Function onTap;
  final List<String> text;
  final ScrollController controller;
  int selected;
  CustomStepper({ this.text,this.selected=0,this.onTap, this.controller}){
    this.selected = this.selected - 1;
  }

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  List<GlobalKey> keys=[];

  incrementSelected(){
    setState(() {
      widget.selected++;
    });
  }

  List<Widget> buildStepperCircles(){
    List<Widget> stepperCircles = [];
    Color color;
    for(int i=0;i<widget.text.length;i++){
      if(i<=widget.selected){

        color=  Color.fromRGBO(253, 202, 29, 1);
      }
      else if(i>widget.selected){
        color= Color(0xFF3F5521);
      }
      else {
        color=  Color.fromRGBO(253, 202, 29, 1);
      }
      stepperCircles.add(
          Expanded(
            key: keys[i],
            child: GestureDetector(
              onTap:(){
                if(i<widget.selected) {
                  widget.onTap(i + 1);
                  Scrollable.ensureVisible(
                    keys[i].currentContext,
                    curve: Curves.fastOutSlowIn,
                    duration: kThemeAnimationDuration,
                  );
                } },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    width:25,
                    height:25,
                    decoration: BoxDecoration(
                      color:color,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(child: Text((i+1).toString(),style:TextStyle(color:Color(0xffffffff)))),
                  ),

                ],
              ),
            ),
          )
      );
    }
    return stepperCircles;
  }
  List<Widget> buildStepperText(){
    List<Widget> stepperText = [];
    for(int i=0;i<widget.text.length;i++){
      stepperText.add(
          Expanded(
            flex:1,
            child: Center(child: Text(widget.text[i],style: TextStyle(color: Color(0xFF3F5521)),)),
          )
      );
    }
    return stepperText;
  }
  List<Widget> buildStepperLine(double width){
    List<Widget> stepperLine = [];
    BoxDecoration boxDecoration;
    for(int i=0;i<widget.text.length-1;i++){
      if(i==0 && widget.selected == 0){
        boxDecoration = BoxDecoration(
            gradient: stepperGradientForward
        );
      }
      else if(widget.selected == widget.text.length-1 && i==widget.text.length-2){
        boxDecoration = BoxDecoration(
            color: Color(0xff3B3F52)
        );
      }
      else{
        if(i<widget.selected){
          boxDecoration = BoxDecoration(
              color: Color.fromRGBO(253, 202, 29, 1)
          );
        }
        else if(i>widget.selected){
          boxDecoration = BoxDecoration(
            color: Color(0xFF3F5521),
          );
        }
        else {
          boxDecoration = BoxDecoration(
            gradient: stepperGradientBackward,
          );
        }
      }

      stepperLine.add(
          Container(
            width:(3*width)/(widget.text.length),
            height: 5,
            decoration: boxDecoration,
          )
      );
    }
    return stepperLine;
  }
  @override
  void initState() {
    // TODO: implement initState
    keys = List.generate(widget.text.length, (index) => GlobalKey());

    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height:MediaQuery.of(context).size.height * 0.1,

      child: SingleChildScrollView(
        physics:ClampingScrollPhysics(),
        controller: widget.controller,
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*3,
          ),
          child: Stack(
            children: [
              Container(

                margin: EdgeInsets.only(top:50),
                child: Row(
                  children: [...buildStepperText()],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: (3*width)/(widget.text.length*2),
                    )  ,
                    ...buildStepperLine(width),
                    SizedBox(width: (3*width)/(widget.text.length*2),)  ,
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [...buildStepperCircles()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}