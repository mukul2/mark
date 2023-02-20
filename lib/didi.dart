import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(body: CreateApp())));

num map(num value, [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
    ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;

class CreateApp extends StatefulWidget{
  @override CreateAppState createState() => CreateAppState();
}

class CreateAppState extends State<CreateApp>{
  final List<Widget> _list = <Widget>[];
  final double _size = 140.0;

  double _x = pi * 0.25, _y = pi * 0.25;
  late Timer _timer;

  int get size => _list.length;

  @override
  Widget build(BuildContext context){
    return Stack(
        children: <Widget>[
          // Rainbow
     if(false)     LayoutBuilder(builder: (_, BoxConstraints c) => Stack(
              children: _list.map((Widget w){
                final num _i = map(size - _list.indexOf(w), 0, 150);

                return Positioned(
                    top: (c.maxHeight / 2 - _size / 2) + _i * c.maxHeight * 0.9,
                    left: (c.maxWidth / 2 - _size / 2) - _i * c.maxWidth * 0.9,
                    child: Transform.scale(scale: _i * 1.5 + 1.0, child: w)
                );
              }).toList()
          )),

          // Cube
          GestureDetector(
              onDoubleTap: _start,
              onPanUpdate: (DragUpdateDetails u) => setState((){
                _x = (_x + -u.delta.dy / 1) ;
                _y = (_y + -u.delta.dx / 1);
              }),
              child: Container(color: Colors.transparent, child: Cube(
                  color: Colors.grey.shade200, x: _x, y: _y, size: _size))
          ),
        ]
    );
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

  void _start(){
    if(_timer?.isActive ?? false){
      return;
    }

    _timer = Timer.periodic(Duration(milliseconds: 48), (_) => _add());
  }

  void _add(){
    if(size > 150)
      _list.removeRange(0, Colors.accents.length * 4); // Expensive, remove more at once

    setState(() => _list.add(
        Cube(x: _x, y: _y, color: Colors.accents[_timer.tick % Colors.accents.length].withOpacity(0.2), rainbow: true, size: _size)
    ));
  }
}

class Cube extends StatelessWidget{
  const Cube({ required this.x, required this.y, required this.color, required this.size, this.rainbow = false});

  static const double _shadow = 0.2, _halfPi = pi / 2, _oneHalfPi = pi + pi / 2;

  final double x, y, size;
  final Color color;
  final bool rainbow;

  double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

  @override
  Widget build(BuildContext context){
    final bool _topBottom = x < _halfPi || x > _oneHalfPi;
    final bool _northSouth = _sum < _halfPi || _sum > _oneHalfPi;
    final bool _eastWest = _sum < pi;
    print("y : "+y.toString());
    print("x : "+x.toString());
    print("_topBottom : "+_topBottom.toString());
    print("_northSouth : "+_northSouth.toString());
    print("_eastWest : "+_eastWest.toString());

    return Stack(children: <Widget>[
      _side(color :Colors.red,size : 450,zRot: y, xRot: -x, shadow: _getShadow(x).toDouble(), moveZ: _topBottom),
      _side(color :Colors.green,size : 450,yRot: y, xRot: _halfPi - x, shadow: _getShadow(_sum).toDouble(), moveZ: _northSouth),
      _side(color :Colors.blue,size : 450,yRot: -_halfPi + y, xRot: _halfPi - x, shadow: _shadow - _getShadow(_sum), moveZ: _eastWest)
    ]);
  }

  num _getShadow(double r){
    if(r < _halfPi){
      return map(r, 0, _halfPi, 0, _shadow);
    }else if(r > _oneHalfPi){
      return _shadow - map(r, _oneHalfPi, pi * 2, 0, _shadow);
    }else if(r < pi){
      return _shadow - map(r, _halfPi, pi, 0, _shadow);
    }

    return map(r, pi, _oneHalfPi, 0, _shadow);
  }

  Widget _side({required double size,required Color color,bool moveZ = true, double xRot = 0.0, double yRot = 0.0, double zRot = 0.0, double shadow = 0.0}){
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateX(xRot)..rotateY(yRot)..rotateZ(zRot)
          ..translate(0.0, 0.0, moveZ ? -size / 2 : size / 2),
        child: Container(
            alignment: Alignment.center,
            child: Container(child:  Center(child:moveZ? Text(moveZ.toString()+" - "+size.toString()+" - "+xRot.toString()+" - "+yRot.toString()+" - "+shadow.toString()):Container(width: 0,height: 0,)),
                constraints: BoxConstraints.expand(width: size, height: size),
                color: color,
                foregroundDecoration: BoxDecoration(color: Colors.black.withOpacity(0),
                    border: Border.all(width: 0.8, color: rainbow ? color.withOpacity(0.3) : Colors.black26))
            )
        )
    );
  }
}