import 'package:flutter/material.dart';
import 'package:nike_shoes_store/src/animations/shake_transition.dart';
import 'package:nike_shoes_store/src/pages/details_page.dart';
import 'package:nike_shoes_store/src/models/nike_shoe.dart';

class HomePage extends StatelessWidget {
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset('assets/nike_shoes/nike_logo.png',
                        height: 20.0),
                    Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            itemCount: shoes.length,
                            itemBuilder: (context, index) {
                              final shoesItem = shoes[index];
                              return NikeShoesItem(
                                shoesItem: shoesItem,
                                onTap: () {
                                  _onShoesPressed(shoesItem, context);
                                },
                              );
                            }))
                  ],
                ),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: notifierBottomBarVisible,
                  child: Container(
                    color: Colors.white.withOpacity(0.7),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Icon(Icons.home),
                        ),
                        Expanded(
                          child: Icon(Icons.search),
                        ),
                        Expanded(
                          child: Icon(Icons.favorite_border),
                        ),
                        Expanded(
                          child: Icon(Icons.shopping_cart),
                        ),
                        Expanded(
                          child: Center(
                            child: CircleAvatar(
                              radius: 13,
                              backgroundImage:
                                  AssetImage('assets/nike_shoes/person.jpg'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  builder: (context, value, child) {
                    return AnimatedPositioned(
                        duration: const Duration(milliseconds: 250),
                        left: 0,
                        right: 0,
                        bottom: value ? 0.0 : -kToolbarHeight * 1.5,
                        height: kToolbarHeight,
                        child: child);
                  })
            ],
          ),
        ));
  }

  void _onShoesPressed(NikeShoe shoesItem, BuildContext context) async {
    notifierBottomBarVisible.value = false;
    await Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (context, animation1, animation2) {
      return FadeTransition(
        opacity: animation1,
        child: DetailsPage(
          shoes: shoesItem,
        ),
      );
    }));
    notifierBottomBarVisible.value = true;
  }
}

class NikeShoesItem extends StatelessWidget {
  final NikeShoe shoesItem;
  final VoidCallback onTap;
  NikeShoesItem({Key key, this.shoesItem, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const itemHeight = 280.0;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: SizedBox(
          height: 250.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: Hero(
                  tag: 'background:${shoesItem.model}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Hero(
                    tag: 'number_${shoesItem.model}',
                    child: SizedBox(
                      height: itemHeight * 0.6,
                      child: Material(
                        color: Colors.transparent,
                        child: FittedBox(
                          child: Text(
                            shoesItem.modelNumber.toString(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.05),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                left: 90,
                height: itemHeight * 0.7,
                child: Hero(
                  tag: 'image_${shoesItem.model}',
                  child: Image.asset(
                    shoesItem.images.first,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 20,
                child: Icon(Icons.favorite_border, color: Colors.grey),
              ),
              Positioned(
                bottom: 20.0,
                right: 20,
                child: Icon(Icons.shopping_cart, color: Colors.grey),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      shoesItem.model,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '\$${shoesItem.oldPrice.toInt().toString()}',
                      style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      '\$${shoesItem.currentPrice.toInt().toString()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
