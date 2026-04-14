import 'package:clean_arch_base/src/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductModel.fromJson', () {
    test('parses product fields from API payload', () {
      final model = ProductModel.fromJson(<String, dynamic>{
        'id': 1,
        'title': 'Phone',
        'description': 'Flagship device',
        'price': 999,
        'thumbnail': 'https://example.com/image.png',
        'rating': 4.7,
      });

      expect(model.id, 1);
      expect(model.title, 'Phone');
      expect(model.description, 'Flagship device');
      expect(model.price, 999);
      expect(model.thumbnail, 'https://example.com/image.png');
      expect(model.rating, 4.7);
    });

    test('falls back safely when optional values are missing', () {
      final model = ProductModel.fromJson(<String, dynamic>{'id': 2});

      expect(model.title, isEmpty);
      expect(model.description, isEmpty);
      expect(model.price, 0);
      expect(model.thumbnail, isEmpty);
      expect(model.rating, 0);
    });
  });
}
