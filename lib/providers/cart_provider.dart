import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_model.dart';

final cartPostProvider = ChangeNotifierProvider((ref) => CartPostProvider());

class CartPostProvider extends ChangeNotifier {
  List<CartPost> cartPosts = [];

  void addCartPost(CartPost cartPost) {
    cartPosts.add(cartPost);
    print(cartPost);
    notifyListeners();
  }

  // Other methods for editing and deleting cart posts can be added here
}
