import 'package:flutter_batch_4_project/helpers/helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatRupiah()', () {
    test('Mengembalikan format Rupiah dengan nilai positif', () {
      final result = formatRupiah(150000);
      expect(result, "Rp 150.000");
    });

    test('Mengembalikan format Rp 0 jika input adalah null', () {
      final result = formatRupiah(null);
      expect(result, "Rp 0");
    });

    test('Mengembalikan format Rp 0 jika input adalah 0', () {
      final result = formatRupiah(0);
      expect(result, "Rp 0");
    });

    test('Mengembalikan format (Rp 150.000) jika input adalah -150000', () {
      final result = formatRupiah(-150000);
      expect(result, "(Rp 150.000)");
    });
  });
}