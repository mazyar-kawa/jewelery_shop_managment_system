class Items {
  String name;
  String image;
  double price;
  int size;
  String nameCategory;
  int id;
  int idCategory;
  String puring;
  bool isFavorite;

  Items({
    required this.name,
    required this.image,
    required this.price,
    required this.size,
    required this.nameCategory,
    required this.id,
    required this.idCategory,
    required this.puring,
    this.isFavorite = false,
  });
}

List<Items> items = [
  Items(
      name: 'item1',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      id: 1,
      isFavorite: true,
      idCategory: 1,
      puring: 'Gold'),
  Items(
      name: 'item2',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      isFavorite: false,
      nameCategory: 'Ring',
      id: 2,
      idCategory: 1,
      puring: 'Gold'),
  Items(
      name: 'item3',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 3,
      idCategory: 1,
      puring: 'Gold'),
  Items(
      name: 'item4',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 4,
      idCategory: 1,
      puring: 'Gold'),
  Items(
      name: 'item5',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 5,
      idCategory: 1,
      puring: 'Gold'),
  Items(
      name: 'item6',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 6,
      idCategory: 2,
      puring: 'Silver'),
  Items(
      name: 'item7',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 7,
      idCategory: 2,
      puring: 'Silver'),
  Items(
      name: 'item8',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 8,
      idCategory: 2,
      puring: 'Silver'),
  Items(
      name: 'item9',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 9,
      idCategory: 2,
      puring: 'Silver'),
  Items(
      name: 'item10',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 10,
      idCategory: 2,
      puring: 'Silver'),
  Items(
      name: 'item11',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 11,
      idCategory: 3,
      puring: 'Gold'),
  Items(
      name: 'item12',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 12,
      idCategory: 3,
      puring: 'Gold'),
  Items(
      name: 'item13',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 13,
      idCategory: 3,
      puring: 'Gold'),
  Items(
      name: 'item14',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 14,
      idCategory: 3,
      puring: 'Gold'),
  Items(
      name: 'item15',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 15,
      idCategory: 3,
      puring: 'Gold'),
  Items(
      name: 'item16',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 16,
      idCategory: 4,
      puring: 'Silver'),
  Items(
      name: 'item17',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 17,
      idCategory: 4,
      puring: 'Silver'),
  Items(
      name: 'item18',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 18,
      idCategory: 4,
      puring: 'Silver'),
  Items(
      name: 'item19',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 19,
      idCategory: 4,
      puring: 'Silver'),
  Items(
      name: 'item20',
      image:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      price: 190,
      size: 18,
      nameCategory: 'Ring',
      isFavorite: false,
      id: 20,
      idCategory: 4,
      puring: 'Silver'),
];
