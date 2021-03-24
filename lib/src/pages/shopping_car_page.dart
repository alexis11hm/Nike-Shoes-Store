import 'package:flutter/material.dart';
import 'package:nike_shoes_store/src/models/nike_shoe.dart';

const _buttonSizeWidth = 160.0;
const _buttonSizeHeight = 60.0;
const _buttonCircularSize = 60.0;
const _finalImageSize = 30.0;
const _imageSize = 150.0;

class ShoppingCarPage extends StatefulWidget {
  final NikeShoe shoes;

  const ShoppingCarPage({Key key, @required this.shoes}) : super(key: key);

  @override
  _ShoppingCarPageState createState() => _ShoppingCarPageState();
}

class _ShoppingCarPageState extends State<ShoppingCarPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animationResize;
  Animation _animationMovementIn;
  Animation _animationMovementOut;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    _animationResize = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.3)));

    _animationMovementIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.6, curve: Curves.fastLinearToSlowEaseIn)));

    _animationMovementOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.7, 1.0, curve: Curves.elasticIn)));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(true);
      }
    });
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPanel(BuildContext context) {
    final currentImageSize = (_imageSize * _animationResize.value)
        .clamp(_finalImageSize, _imageSize);
    final size = MediaQuery.of(context).size;
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 1.0, end: 0.0),
      curve: Curves.easeIn,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, value * size.height * 0.6),
          child: child,
        );
      },
      child: Container(
        height: (size.height * 0.6 * _animationResize.value)
            .clamp(_buttonCircularSize, size.height * 0.6),
        width: (size.width * _animationResize.value)
            .clamp(_buttonCircularSize, size.width),
        decoration: BoxDecoration(
            color: Colors.white, //Color(0xFFF6F6F6),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: _animationResize.value == 1
                    ? Radius.circular(0)
                    : Radius.circular(30),
                bottomRight: _animationResize.value == 1
                    ? Radius.circular(0)
                    : Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: _animationResize.value == 1
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    widget.shoes.images.first,
                    width: currentImageSize,
                    height: currentImageSize,
                  ),
                  if (_animationResize.value == 1) ...[
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: <Widget>[
                        Text(widget.shoes.model,
                            style: TextStyle(fontSize: 10.0)),
                        Text(
                          '\$${widget.shoes.currentPrice.toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        )
                      ],
                    )
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final buttonSizeWidth =
                  (_buttonSizeWidth * _animationResize.value)
                      .clamp(_buttonCircularSize, _buttonSizeWidth);
              final _panelSizeWidth = (size.width * _animationResize.value)
                  .clamp(_buttonCircularSize, size.width);
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned.fill(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.black87,
                    ),
                  )),
                  Positioned.fill(
                      child: Stack(
                    children: <Widget>[
                      if (_animationMovementIn.value != 1)
                        Positioned(
                            top: size.height * 0.4 +
                                (_animationMovementIn.value *
                                    size.height *
                                    0.4437),
                            left: size.width / 2 - _panelSizeWidth / 2,
                            width: _panelSizeWidth,
                            child: _buildPanel(context)),
                      Positioned(
                        left: size.width / 2 - buttonSizeWidth / 2,
                        bottom: 40 - (_animationMovementOut.value * 100),
                        child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 400),
                          tween: Tween(begin: 1.0, end: 0.0),
                          curve: Curves.easeIn,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0.0, value * size.height * 0.6),
                              child: child,
                            );
                          },
                          child: InkWell(
                            onTap: () {
                              _controller.forward();
                            },
                            child: Container(
                              width: buttonSizeWidth,
                              height: (_buttonSizeHeight *
                                      _animationResize.value)
                                  .clamp(
                                      _buttonCircularSize, _buttonSizeHeight),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                    if (_animationResize.value == 1) ...[
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text('Add to car',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              );
            }));
  }
}
