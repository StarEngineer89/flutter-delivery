import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'core/presentation/providers/provider_observers.dart';
import 'core/presentation/styles/app_images.dart';
import 'firebase_options.dart';

part 'core/presentation/services/main_initializer.dart';

void main() async {
  await _mainInitializer();
  runApp(
    ProviderScope(
      observers: [LogProviderObserver()],
      child: const MyApp(),
    ),
  );
}
