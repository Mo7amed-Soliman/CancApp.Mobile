import 'package:canc_app/core/helpers/responsive_helpers/size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void sizeProviderTestWidget() {
  // Test for `SizeProvider` widget
  testWidgets('SizeProvider test', (tester) async {
    await tester.pumpWidget(
      const SizeProvider(
        baseSize: Size(375, 812),
        width: 400,
        height: 800,
        child: SizedBox(),
      ),
    );

    // Get the element directly (Element IS the BuildContext)
    final element = tester.firstElement(find.byType(SizeProvider));

    // Use the element directly as context
    final sizeProvider = SizeProvider.of(element);
    // Print the retrieved values
    debugPrint('Base Size: ${sizeProvider.baseSize}');
    debugPrint('Width: ${sizeProvider.width}');
    debugPrint('Height: ${sizeProvider.height}');

    // Assertions
    expect(sizeProvider.baseSize, const Size(375, 812));
    expect(sizeProvider.width, 400);
    expect(sizeProvider.height, 800);
  });
}
