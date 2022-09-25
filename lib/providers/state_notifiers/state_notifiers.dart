import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme_provider.dart';

final themeNotifierProvider =
    ChangeNotifierProvider<ThemeNotifier>((_) => ThemeNotifier());