import '';

class Item {
  final String name;
  final double price;
  final String image;
  const Item({
    required this.name,
    required this.price,
    required this.image,
  });
}

const List<Item> storeItems = [
  Item(
    name: "Shoe 1",
    price: 4090,
    image:
        "https: /images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=998&q=80",
  ),
  Item(
    name: "Shoe 2",
    price: 6990,
    image:
        "https: /images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=998&q=80",
  ),
  Item(
    name: "Shoe 3",
    price: 7990,
    image:
        "https: /images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=998&q=80",
  ),
  Item(
    name: "Shoe 4",
    price: 8990,
    image:
        "https: /images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=998&q=80",
  ),
];
