class NikeShoe {
  final String model;
  final double oldPrice;
  final double currentPrice;
  final List<String> images;
  final int modelNumber;
  final int color;

  NikeShoe(
      {this.model,
      this.oldPrice,
      this.currentPrice,
      this.images,
      this.modelNumber,
      this.color});
}

final shoes = <NikeShoe>[
  NikeShoe(
      model: 'AIR MAX 90 EZ BLACK',
      currentPrice: 149.9,
      oldPrice: 299.9,
      images: [
        'assets/nike_shoes/shoes_1_1.jpg',
        'assets/nike_shoes/shoes_1_2.jpg',
        'assets/nike_shoes/shoes_1_3.jpg',
        'assets/nike_shoes/shoes_1_4.jpg'
      ],
      modelNumber: 90,
      color: 0xFFF6F6F6),
  NikeShoe(
      model: 'AIR MAX 95 RED',
      currentPrice: 299.9,
      oldPrice: 399.9,
      images: [
        'assets/nike_shoes/shoes_2_1.jpg',
        'assets/nike_shoes/shoes_2_2.jpg',
        'assets/nike_shoes/shoes_2_3.jpg',
        'assets/nike_shoes/shoes_2_4.jpg'
      ],
      modelNumber: 95,
      color: 0xFFFCF5EB),
  NikeShoe(
      model: 'AIR MAX 270 GOLD',
      currentPrice: 199.9,
      oldPrice: 349.9,
      images: [
        'assets/nike_shoes/shoes_3_1.jpg',
        'assets/nike_shoes/shoes_3_2.jpg',
        'assets/nike_shoes/shoes_3_3.jpg',
        'assets/nike_shoes/shoes_3_4.jpg'
      ],
      modelNumber: 270,
      color: 0xFFFEF7ED),
  NikeShoe(
      model: 'AIR MAX 98 FREE',
      currentPrice: 199.9,
      oldPrice: 279.9,
      images: [
        'assets/nike_shoes/shoes_4_1.jpg',
        'assets/nike_shoes/shoes_4_2.jpg',
        'assets/nike_shoes/shoes_4_3.jpg',
        'assets/nike_shoes/shoes_4_4.jpg'
      ],
      modelNumber: 98,
      color: 0xFFEDF3FD),
];
