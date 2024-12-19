import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app_flutter/widgets/product_card.dart';
import 'package:shop_app_flutter/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

void main() {
  testWidgets('Product list and add to cart', (WidgetTester tester) async {
    // Build the widget tree with the HomePage widget
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: const MaterialApp(
          home: const HomePage(),
        ),
      ),
    );

    // Verify that the product list is displayed.
    expect(
        find.text('Shoes\nCollection'), findsOneWidget); // Product list title
    expect(
        find.byType(ProductCard), findsWidgets); // Product cards are displayed

    // Tap the first product card and navigate to details page.
    await tester.tap(find.byType(ProductCard).first);
    await tester.pumpAndSettle();

    // Verify we are on the product details page
    expect(find.text('Details'), findsOneWidget);

    // Select a size and add to cart.
    await tester.tap(find.text('9')); // Assuming size 9 is one of the options
    await tester.pump();

    // Tap the 'Add To Cart' button.
    await tester.tap(find.text('Add To Cart'));
    await tester.pump();

    // Verify that the SnackBar shows the message 'Product added successfully!'
    expect(find.text('Product added successfully!'), findsOneWidget);

    // Navigate to the cart page
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    // Verify that the cart has the added product.
    expect(find.text('Men\'s Nike Shoes'), findsOneWidget);
  });
}
