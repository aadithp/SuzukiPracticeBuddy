import 'dart:async';
import 'dart:math';
import 'package:SuzukiPracticeBuddy/screens/review/PiecePreview.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Piece.dart';
import 'SpinVelocity.dart';
import 'NonUniformCircularMotion.dart';
import 'Wheel.dart';

class SpinningWheel extends StatefulWidget {
  //image is the image of the wheel
  final Wheel image;
  final double height;
  final double width;

  //secondaryImage image that indicates which piece has been selected
  final Image secondaryImage;
  final double secondaryImageHeight;
  final double secondaryImageWidth;

  //pieces on the wheel
  final List<Piece> pieces;

  // final SpinningWheelController spinningWheel;
  final Function(Piece) onEnd;

  final colorMap;

  SpinningWheel(
      {@required this.image,
      @required this.width,
      @required this.height,
      @required this.secondaryImage,
      @required this.secondaryImageHeight,
      @required this.secondaryImageWidth,
      @required this.pieces,
      @required this.onEnd,
      @required this.colorMap});

  @override
  _SpinningWheelState createState() => _SpinningWheelState(colorMap);
}

class _SpinningWheelState extends State<SpinningWheel>
    with SingleTickerProviderStateMixin {
  final colorMap;

  _SpinningWheelState(this.colorMap);

  AnimationController _animationController;
  Animation<double> _animation;

  //_spinVelocity is used to calculate the rotation
  SpinVelocity _spinVelocity;

  //initialCircularVelocity is initial velocity of the wheel
  double _initialCircularVelocity = 0;

  // initialSpinAngle is the initial rotation angle of the wheel
  double _initialSpinAngle = 0;

  //motion is used to calculate the duration
  NonUniformCircularMotion _motion;

  //Duration of the animation
  double _totalDuration = 0;

  //Used to calculate the quadrant the wheel was dragged in
  Offset _localPosition = Offset(250.0, 250.0);

  //True if wheel is spinning backwards
  bool _isBackwards;

  //_currentDistance is the angle covered by the animation
  double _currentDistance = 0;

  //_renderBox is used to transform global positions to local positions
  RenderBox _renderBox;

  //_currentSector is the sector secondaryImage is pointing at
  int _currentSector = 1;

  //True if wheel has stopped spinning
  bool spun = false;

  //True if wheel has not spun for at least minimumSpinTime seconds
  //False if the spin is invalid
  bool goAgain = false;

  //The minimum time the wheel needs to spin for
  int minimumSpinTime = 3;
  Timer timer;

  //Current review piece choice
  Piece reviewPiece;

  //sectorAngle is the angle per sector
  double get sectorAngle => (2 * pi) / widget.pieces.length;

  bool _displayPreview = true;
  double _displayArrow = 1;

  //Used to position secondaryImage
  double get topSecondaryImage => -16;

  double get leftSecondaryImage =>
      widget.width / 2 - widget.secondaryImageWidth / 2;

  double get widthSecondaryImage => widget.secondaryImageWidth ?? widget.width;

  double get heightSecondaryImage =>
      widget.secondaryImageHeight ?? widget.height;

  final player = AudioCache();

  //Initialises the variables
  @override
  void initState() {
    super.initState();

    player.load('wheel_tick.mp3');

    reviewPiece = widget.pieces[0];
    _motion = new NonUniformCircularMotion(resistance: 0.5);
    _spinVelocity =
        new SpinVelocity(height: widget.height, width: widget.width);

    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //Stops the timer
        timer.cancel();
        if (spun) {
          _stopAnimation();
        } else {
          //Does not display the output if the spin duration is less than the minimum spin time
          goAgain = true;
          setState(() {});
        }
      }
    });
  }

  //Called when the animation is started
  void _startAnimation(DragEndDetails details) {
    //Sets spun to true if the wheel has spun for at least minimumSpinTime seconds
    setState(() {
      _displayArrow = 0;
    });
    timer = new Timer(Duration(seconds: minimumSpinTime), () => spun = true);
    goAgain = false;

    if (_animationController.isAnimating) return;

    //Calculates the velocity from the pixelsPerSecond value
    var velocity = _spinVelocity.getVelocity(
        _localPosition, details.velocity.pixelsPerSecond);

    _localPosition = null;
    _isBackwards = velocity < 0;
    _initialCircularVelocity =
        _spinVelocity.pixelPerSecondToRadians(velocity.abs());
    _totalDuration = _motion.duration(_initialCircularVelocity);

    _animationController.duration =
        Duration(milliseconds: (_totalDuration * 1000).round());

    _animationController.reset();
    _animationController.forward();
  }

  //Called when the wheel is being animated
  void _updateAnimationValues() {
    if (_animationController.isAnimating) {
      //Calculates and sets the total distance
      var currentTime = _totalDuration * _animation.value;
      _currentDistance =
          _motion.distance(_initialCircularVelocity, currentTime);
      if (_isBackwards) _currentDistance = -1 * _currentDistance;
    }

    var modulo = _motion.modulo(_currentDistance + _initialSpinAngle);
    int _newCurrentSector = _currentSector;
    _currentSector = widget.pieces.length -
        (_motion.modulo(modulo - sectorAngle / 2) ~/ sectorAngle);
    if (_currentSector != _newCurrentSector) {
      player.play('wheel_tick.mp3',
          mode: PlayerMode.LOW_LATENCY, stayAwake: false);
    }

    //Sets the initial angle to the current angle after wheel stops spinning
    if (!_animationController.isAnimating) {
      _initialSpinAngle = modulo;
      _currentDistance = 0;
    }
  }

  //Called after a valid spin
  void _stopAnimation() {
    if (_animationController.isAnimating) return;

    Timer _displayTimer = new Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _displayPreview = false;
      });
    });
    _animationController.stop();
    _animationController.reset();
    widget.onEnd(widget.pieces[_currentSector - 1]);
  }

  //Calculates the new angle after rotation
  void _moveWheel(DragUpdateDetails details) {
    if (_animationController.isAnimating) return;

    _localPosition = _updateLocalPosition(details.globalPosition);
    var angle = _spinVelocity.offsetToRadians(_localPosition);

    setState(() {
      _initialSpinAngle = angle;
    });
  }

  //Transforms global positions to local positions
  Offset _updateLocalPosition(Offset position) {
    if (_renderBox == null) {
      _renderBox = context.findRenderObject();
    }

    return _renderBox.globalToLocal(position);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.height + 400,
          width: widget.width,
          child: Stack(children: <Widget>[
            GestureDetector(
                onPanUpdate: _moveWheel,
                onPanEnd: _startAnimation,
                child: AnimatedBuilder(
                    animation: _animation,
                    child: Column(
                      children: [
                        Container(child: widget.image),
                        AnimatedOpacity(
                          duration: Duration(seconds: 3),
                          opacity: _displayArrow,
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                child: Image.asset('assets/arrow.png'),
                              ),
                              Text("Spin the wheel!"),
                            ],
                          ),
                        ),
                        // SizedBox(height: 50),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2
                            ),
                          ),
                          child: PiecePreview(
                            reviewPiece,
                            colorMap[reviewPiece],
                          ),
                        ),
                      ],
                    ),
                    builder: (context, child) {
                      _updateAnimationValues();
                      reviewPiece = widget.pieces[_currentSector - 1];
                      return Column(children: [
                        SizedBox(height: 10),
                        Transform.rotate(
                          angle: _initialSpinAngle + _currentDistance,
                          child: widget.image,
                        ),
                        AnimatedOpacity(
                          duration: Duration(seconds: 2),
                          opacity: _displayArrow,
                          child: Column(children: [
                            Container(
                              height: 40,
                              child: Image.asset('assets/arrow.png'),
                            ),
                            Text("Spin the wheel!"),
                          ]),
                        ),
                        SizedBox(height: 50),
                        _displayPreview
                            ? Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: PiecePreview(
                                  reviewPiece,
                                  colorMap[reviewPiece],
                                ),
                              )
                            : Container()
                      ]);
                    })),
            widget.secondaryImage != null
                ? Positioned(
                    top: topSecondaryImage,
                    left: leftSecondaryImage,
                    child: Container(
                      height: heightSecondaryImage,
                      width: widthSecondaryImage,
                      child: widget.secondaryImage,
                    ))
                : Container(),

            // goAgain
            //     ? Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     AlertDialog(
            //         title: Center(child: Text("Go again!", style: Theme.of(context).textTheme.headline6))
            //     )
            //   ],
            // ) : Container(),
          ]),
        )
      ],
    );
  }
}
