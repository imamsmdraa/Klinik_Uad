import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klinik_uad/main.dart';

void main() {
  Future<void> openHome(WidgetTester tester) async {
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'ahmad');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.ensureVisible(find.text('Login').last);
    await tester.tap(find.text('Login').last);
    await tester.pumpAndSettle();
  }

  testWidgets('menampilkan intro dan login Klinik UAD', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.textContaining('The best'), findsOneWidget);
    expect(find.textContaining('your health'), findsOneWidget);

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.text('Login to your account'), findsOneWidget);
  });

  testWidgets('menampilkan beranda Klinik UAD', (tester) async {
    await tester.pumpWidget(const MyApp());
    await openHome(tester);

    expect(find.text('Klinik UAD'), findsOneWidget);
    expect(find.text('Ahmad Nur Hidayat'), findsOneWidget);
    expect(find.text('General Consultation'), findsOneWidget);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(find.text('Quick access'), findsOneWidget);
  });

  testWidgets('navigasi bawah berpindah ke janji', (tester) async {
    await tester.pumpWidget(const MyApp());
    await openHome(tester);

    await tester.tap(find.text('Appointments').first);
    await tester.pumpAndSettle();

    expect(find.text('Medical records'), findsNothing);
    expect(find.text('Appointments'), findsWidgets);
    expect(find.text('Booking Dokter'), findsOneWidget);
  });

  testWidgets('navigasi ke rekam medis menampilkan proteksi PIN', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await openHome(tester);

    await tester.tap(find.text('Records').first);
    await tester.pumpAndSettle();

    expect(find.text('Keamanan Rekam Medis'), findsOneWidget);
    expect(find.text('Akses Terenkripsi EMR Pasien'), findsOneWidget);
  });

  testWidgets('navigasi ke pengingat obat menampilkan kepatuhan obat', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await openHome(tester);

    await tester.tap(find.text('Alerts').first);
    await tester.pumpAndSettle();

    expect(find.text('Pengingat Minum Obat'), findsOneWidget);
    expect(find.text('Kepatuhan Hari Ini'), findsOneWidget);
    expect(find.text('Amoxicillin 500 mg'), findsOneWidget);
  });

  testWidgets('navigasi ke profil menampilkan parameter medis', (tester) async {
    await tester.pumpWidget(const MyApp());
    await openHome(tester);

    await tester.tap(find.text('Profile').first);
    await tester.pumpAndSettle();

    expect(find.text('Profil & Kesehatan'), findsOneWidget);
    expect(find.text('Parameter Fisik & Medis'), findsOneWidget);
    expect(
      find.text('Buka Kartu Pasien Digital (QR Check-in)'),
      findsOneWidget,
    );
  });
}
