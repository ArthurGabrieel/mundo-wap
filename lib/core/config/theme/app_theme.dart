import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  const AppTheme._();

  // Tema claro do aplicativo
  static ThemeData get light {
    final ThemeData theme = ThemeData.light();

    return theme.copyWith(
      // Cores principais
      primaryColor: colorBlue3,
      primaryColorDark: primaryColor,
      primaryColorLight: colorBlue3,
      primaryIconTheme: theme.iconTheme.copyWith(color: colorBlue3),
      iconTheme: theme.iconTheme.copyWith(color: colorBlue3),

      // Cores de fundo e canvas
      scaffoldBackgroundColor: colorGreyLight,
      canvasColor: colorBackgroundWhite,

      // Efeitos visuais
      splashColor: colorBackgroundWhite,
      highlightColor: colorInkHighlight,

      // Cores auxiliares
      dividerColor: colorGrey,
      unselectedWidgetColor: colorGrey,
      disabledColor: colorGreyIcon,
      secondaryHeaderColor: primaryColor,
      hintColor: colorGrey,
      indicatorColor: colorBlue3,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: colorBlue3),

      // Tema da AppBar
      appBarTheme: theme.appBarTheme.copyWith(
        color: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: fontColorWhite),
        titleTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: colorTituloappBAR,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Tema de diálogos
      dialogTheme: theme.dialogTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        titleTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: colorBlue3,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),

      // FloatingActionButton
      floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
        backgroundColor: colorBlue3,
        foregroundColor: fontColorWhite,
        elevation: 20,
        iconSize: 40,
        hoverColor: colorBlue3,
        splashColor: colorBlue3,
        focusColor: colorBlue3,
      ),

      // Cartões
      cardTheme: CardTheme(
        clipBehavior: Clip.hardEdge,
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
        color: fontColorWhite,
      ),

      // Seleção de texto
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: colorBlue3,
        selectionHandleColor: colorBlue3,
      ),

      // Divisores
      dividerTheme: theme.dividerTheme.copyWith(
        color: colorGrey,
        thickness: 0.5,
        space: 10.0,
      ),

      // Transições de página
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // Tipografia
      textTheme: _buildTextTheme(theme.textTheme),
      primaryTextTheme: _buildTextTheme(theme.primaryTextTheme),

      // Campos de entrada
      inputDecorationTheme: _buildInputTheme(theme.inputDecorationTheme),

      // Botões
      buttonTheme: _buildButtonTheme(theme.buttonTheme),

      // Botões elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBlue3,
          foregroundColor: fontColorWhite,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // Botões com borda
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorBlue3,
          side: const BorderSide(color: colorBlue3, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // Botões de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorBlue3,
          textStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),

      // SnackBars
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorError,
        contentTextStyle: const TextStyle(color: fontColorWhite),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Tooltips
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorBlue3,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(color: fontColorWhite),
      ),

      // Chips
      chipTheme: theme.chipTheme.copyWith(
        backgroundColor: colorGreyLight,
        selectedColor: colorBlue3,
        disabledColor: colorGrey,
        labelStyle: const TextStyle(color: colorBlack),
        secondaryLabelStyle: const TextStyle(color: fontColorWhite),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: fontColorWhite,
        selectedItemColor: colorBlue3,
        unselectedItemColor: colorGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),

      // TabBar
      tabBarTheme: const TabBarTheme(
        labelColor: colorBlue3,
        unselectedLabelColor: colorGrey,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorBlue3, width: 2),
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        // ignore: deprecated_member_use
        year2023: true,
        color: colorBlue3,
      ),

      // BottomSheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: fontColorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
    );
  }

  // === Métodos auxiliares ===

  // Estilo de texto personalizado
  static TextTheme _buildTextTheme(TextTheme theme) {
    return theme
        .copyWith(
          headlineLarge: theme.headlineLarge?.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: colorBackgroundWhite,
          ),
          bodySmall: theme.bodySmall?.copyWith(
            height: 1.4,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: theme.titleLarge?.copyWith(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: colorBlack,
          ),
          labelMedium: theme.labelMedium?.copyWith(fontSize: 18.0),
          bodyLarge: theme.bodyLarge?.copyWith(height: 1.4),
          bodyMedium: theme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
        )
        .apply(fontFamily: 'Poppins', displayColor: colorGrey);
  }

  // Estilo de campos de entrada personalizados
  static InputDecorationTheme _buildInputTheme(InputDecorationTheme theme) {
    return InputDecorationTheme(
      labelStyle: theme.labelStyle,
      helperStyle: theme.helperStyle,
      hintStyle: const TextStyle(color: colorGreyLight),
      errorStyle: theme.errorStyle,
      errorMaxLines: theme.errorMaxLines,
      contentPadding: theme.contentPadding,
      prefixStyle: theme.prefixStyle,
      suffixStyle: theme.suffixStyle,
      counterStyle: theme.counterStyle,
      errorBorder: theme.errorBorder,
      focusedErrorBorder: theme.focusedErrorBorder,
      disabledBorder: theme.disabledBorder,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: colorBlue3,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      filled: true,
      fillColor: colorTextField,
    );
  }

  // Estilo de botões personalizados
  static ButtonThemeData _buildButtonTheme(ButtonThemeData buttonTheme) {
    return buttonTheme.copyWith(
      textTheme: ButtonTextTheme.primary,
      buttonColor: colorBlue3,
      disabledColor: colorGreyLight,
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: colorBlue3),
    );
  }
}
