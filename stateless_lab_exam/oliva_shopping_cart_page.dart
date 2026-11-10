import 'package:flutter/material.dart';

const _blue = Color(0xFF2165E8);
const _navy = Color(0xFF101E49);
const _muted = Color(0xFF536078);
const _line = Color(0xFFD5DCE9);

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  void _log(String message) => debugPrint(message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => _log('Back clicked'),
          icon: const Icon(Icons.arrow_back, color: _navy, size: 28),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(color: _navy, fontSize: 23, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Shopping bag',
            onPressed: () => _log('Cart clicked'),
            icon: SizedBox(
              width: 42,
              height: 42,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.shopping_bag_outlined, color: _navy, size: 27),
                  ),
                  Positioned(
                    top: -2,
                    right: -1,
                    child: Container(
                      width: 19,
                      height: 19,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: _blue, shape: BoxShape.circle),
                      child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFFDCE9FF), borderRadius: BorderRadius.circular(10)),
                    child: const Text('CAMPUS STORE', style: TextStyle(color: _blue, fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: .4)),
                  ),
                  const SizedBox(height: 14),
                  Text('Ready for checkout', style: TextStyle(color: _navy, fontSize: 32, height: 1.1, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 7),
                  const Text('Review your items before placing your order.', style: TextStyle(color: _muted, fontSize: 15)),
                  const SizedBox(height: 24),
                  const _DeliveryCard(),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Order Items', style: TextStyle(color: _navy, fontSize: 22, fontWeight: FontWeight.w800)),
                      Text('3 items', style: TextStyle(color: _muted, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 13),
                  const CartItemCard(productName: 'Wireless Mouse', price: 'PHP 450.00', quantity: 1, icon: Icons.mouse_outlined),
                  const SizedBox(height: 12),
                  const CartItemCard(productName: 'USB-C Hub', price: 'PHP 850.00', quantity: 1, icon: Icons.usb_rounded),
                  const SizedBox(height: 12),
                  const CartItemCard(productName: 'Laptop Stand', price: 'PHP 700.00', quantity: 1, icon: Icons.laptop_chromebook_outlined),
                  const SizedBox(height: 20),
                  const _DiscountBanner(),
                  const SizedBox(height: 20),
                  const _PaymentSummary(),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: FilledButton.icon(
                      onPressed: () => _log('Place order clicked! Total: PHP 1850.00'),
                      style: FilledButton.styleFrom(backgroundColor: _blue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      icon: const Icon(Icons.lock_outline, size: 21),
                      label: const Text('Place Order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: _blue, size: 29),
          const SizedBox(width: 13),
          Container(width: 1, height: 44, color: _line),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Deliver to Glenn Oliva', style: TextStyle(color: _navy, fontSize: 16, fontWeight: FontWeight.w800)),
                SizedBox(height: 3),
                Text('Matina, Davao City', style: TextStyle(color: _muted, fontSize: 14)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => debugPrint('Change delivery address clicked'),
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4)),
            child: const Text('Change', style: TextStyle(color: _blue, fontSize: 15, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.icon,
  });

  final String productName;
  final String price;
  final int quantity;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(color: const Color(0xFFD8E9FF), borderRadius: BorderRadius.circular(13)),
            child: Icon(icon, color: const Color(0xFF174B9C), size: 39),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _navy, fontSize: 17, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(color: _blue, fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: 9),
                Row(
                  children: [
                    _QuantityButton(icon: Icons.remove, onPressed: () => debugPrint('Decrease quantity: $productName')),
                    Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(border: Border.all(color: _line), borderRadius: BorderRadius.circular(9)),
                      child: Text('$quantity', style: const TextStyle(color: _navy, fontSize: 15, fontWeight: FontWeight.w700)),
                    ),
                    _QuantityButton(icon: Icons.add, onPressed: () => debugPrint('Increase quantity: $productName')),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Delete $productName',
            onPressed: () => debugPrint('Remove item: $productName'),
            icon: const Icon(Icons.delete_outline, color: Color(0xFF5D6676), size: 23),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(padding: EdgeInsets.zero, foregroundColor: _blue, side: const BorderSide(color: _blue, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
        child: Icon(icon, size: 20),
      ),
    );
  }
}

class _DiscountBanner extends StatelessWidget {
  const _DiscountBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: const Color(0xFFDCEBFF), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          const Icon(Icons.sell_outlined, color: _blue, size: 29),
          const SizedBox(width: 13),
          Container(width: 1, height: 42, color: const Color(0xFF9EB8E5)),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('STUDENT10 applied', style: TextStyle(color: Color(0xFF16458F), fontSize: 16, fontWeight: FontWeight.w800)),
                SizedBox(height: 3),
                Text('10% discount on items', style: TextStyle(color: _muted, fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: _blue, size: 30),
        ],
      ),
    );
  }
}

class _PaymentSummary extends StatelessWidget {
  const _PaymentSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: Text('Payment Summary', style: TextStyle(color: _navy, fontSize: 21, fontWeight: FontWeight.w800))),
          const SizedBox(height: 13),
          const _AmountRow(label: 'Subtotal', amount: 'PHP 2,000.00'),
          const SizedBox(height: 8),
          const _AmountRow(label: 'Discount (10%)', amount: '− PHP 200.00'),
          const SizedBox(height: 8),
          const _AmountRow(label: 'Delivery Fee', amount: 'PHP 50.00'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 13), child: Divider(height: 1, color: _line)),
          const _AmountRow(label: 'Total', amount: 'PHP 1,850.00', emphasized: true),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({required this.label, required this.amount, this.emphasized = false});

  final String label;
  final String amount;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: _navy, fontSize: emphasized ? 19 : 15, fontWeight: emphasized ? FontWeight.w800 : FontWeight.w400);
    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        Text(amount, style: style),
      ],
    );
  }
}

BoxDecoration _cardDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: _line),
    );
