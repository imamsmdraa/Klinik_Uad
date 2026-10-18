import 'package:flutter_test/flutter_test.dart';
import 'package:klinik_uad/main.dart';

void main() {
  testWidgets('menampilkan beranda Klinik UAD', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Klinik UAD'), findsOneWidget);
    expect(find.text('Booking dokter'), findsOneWidget);
    expect(find.text('Layanan utama'), findsOneWidget);
  });

  testWidgets('navigasi bawah berpindah ke janji', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Janji'));
    await tester.pumpAndSettle();

    expect(find.text('Janji pemeriksaan'), findsOneWidget);
  });
}
