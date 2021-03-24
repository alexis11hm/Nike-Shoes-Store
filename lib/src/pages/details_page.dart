import 'package:flutter/material.dart';
import 'package:nike_shoes_store/src/animations/shake_transition.dart';
import 'package:nike_shoes_store/src/components/talla_component.dart';
import 'package:nike_shoes_store/src/models/nike_shoe.dart';
import 'package:nike_shoes_store/src/pages/shopping_car_page.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({Key key, @required this.shoes}) : super(key: key);
  final NikeShoe shoes;
  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);

  void _openShoppingCar(BuildContext context) async {
    notifierButtonsVisible.value = false;
    await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: ShoppingCarPage(shoes: shoes),
          );
        },
        opaque: false));
    notifierButtonsVisible.value = true;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtonsVisible.value = true;
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/nike_shoes/nike_logo.png', height: 20.0),
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildCarousel(context),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ShakeTransition(
                        axis: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(shoes.model,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                )),
                            const Spacer(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text('\$${shoes.oldPrice.toString()}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 13.0,
                                      )),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Text('\$${shoes.currentPrice.toString()}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1100),
                        child: Text(
                          'AVAILABLE SIZES',
                          style: TextStyle(fontSize: 11.0),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ShoeSizeItem(text: '6'),
                            ShoeSizeItem(text: '7'),
                            ShoeSizeItem(text: '8'),
                            ShoeSizeItem(text: '9'),
                            ShoeSizeItem(text: '10'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Description:',
                        style: TextStyle(fontSize: 13.0),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: notifierButtonsVisible,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    FloatingActionButton(
                        heroTag: 'fav_1',
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                        onPressed: () {}),
                    Spacer(),
                    FloatingActionButton(
                        heroTag: 'fav_2',
                        backgroundColor: Colors.black,
                        child: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          _openShoppingCar(context);
                        })
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    left: 0,
                    right: 0,
                    bottom: value ? 0.0 : -kToolbarHeight,
                    child: child);
              })
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Hero(
                  tag: 'background_${shoes.model}',
                  child: Container(color: Color(shoes.color)))),
          Positioned(
            right: 70,
            left: 70,
            top: 10.0,
            child: Hero(
              tag: 'number_${shoes.model}',
              child: ShakeTransition(
                axis: Axis.vertical,
                duration: const Duration(milliseconds: 1400),
                offset: 15,
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      shoes.modelNumber.toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.05),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          PageView.builder(
              itemCount: shoes.images.length,
              itemBuilder: (context, index) {
                final tag = index == 0
                    ? 'image_${shoes.model}'
                    : 'image_${shoes.model}_$index';
                return Container(
                  child: ShakeTransition(
                    duration: index == 0
                        ? Duration(milliseconds: 1000)
                        : Duration.zero,
                    axis: Axis.vertical,
                    offset: 10,
                    child: Hero(
                      tag: tag,
                      child: Image.asset(
                        shoes.images[index],
                        height: 200.0,
                        width: 200.0,
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
