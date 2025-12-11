class AppSettings {
  final String themeMode;
  final int primaryColorArgb;

  const AppSettings({
    this.themeMode = 'system',
    this.primaryColorArgb = 0xFF6200EE,
  });

  AppSettings copyWith({String? themeMode, int? primaryColorArgb}) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      primaryColorArgb: primaryColorArgb ?? this.primaryColorArgb,
    );
  }

  bool get isLight => themeMode == 'light';
  bool get isDark => themeMode == 'dark';
  bool get isSystem => themeMode == 'system';
}
