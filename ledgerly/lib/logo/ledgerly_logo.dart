import 'package:flutter/material.dart';

class LedgerlyLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;

  const LedgerlyLogo({
    super.key,
    this.iconSize = 100,
    this.fontSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Logo Icon with Glow
    Widget logoIcon = Container(
      padding: EdgeInsets.all(iconSize * 0.25),
      decoration: BoxDecoration(
        color: Colors.indigoAccent.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.indigoAccent.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.account_balance_wallet_rounded,
        size: iconSize,
        color: Colors.indigoAccent,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        logoIcon,
        SizedBox(height: iconSize * 0.3),

        // 2. Main Title (Ledgerly)
        Text(
          "Ledgerly",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: fontSize,
            letterSpacing: 1.5,
            // If you added Doto/Silkscreen, apply it here
          ),
        ),

        const SizedBox(height: 15),

        // 3. Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Your private offline financial companion',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 18,
              color: Colors.grey, // Slightly dimmed for hierarchy
            ),
          ),
        ),

        const SizedBox(height: 40), // More space before the loading bar

        // 4. Nothing-style Loading Bar
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: LinearProgressIndicator(
            backgroundColor: Colors.white10,
            color: Colors.indigoAccent,
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}