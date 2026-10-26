import 'package:flutter/material.dart';
import '../features/appointment/presentation/pages/booking_page.dart';
import '../features/appointment/presentation/pages/queue_page.dart';
import '../features/consultation/presentation/pages/consultation_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/medical_record/presentation/pages/medical_record_page.dart';
import '../features/profile/presentation/pages/digital_medical_card_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/reminder/presentation/pages/medication_reminder_page.dart';

abstract final class AppRouter {
  static const home = '/';
  static const booking = '/booking';
  static const queue = '/queue';
  static const medicalRecord = '/medical-record';
  static const reminder = '/reminder';
  static const consultation = '/consultation';
  static const profile = '/profile';
  static const digitalCard = '/digital-card';

  static final routes = <String, WidgetBuilder>{
    home: (_) => const HomePage(),
    booking: (_) => const BookingPage(),
    queue: (_) => const QueuePage(),
    medicalRecord: (_) => const MedicalRecordPage(),
    reminder: (_) => const MedicationReminderPage(),
    consultation: (_) => const ConsultationPage(),
    profile: (_) => const ProfilePage(),
    digitalCard: (_) => const DigitalMedicalCardPage(),
  };
}
