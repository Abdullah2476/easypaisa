import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/easypaisa_contact_model.dart';
import '../../widgets/receipt/easypaisa_receipt_dialog.dart';

/// Screen displayed upon successful transfer.
/// Strictly replicates the official Easypaisa UI from the user's screenshot:
/// - Top right Close 'X' button
/// - Celebration animation with green check circle and festive confetti particles
/// - Large amount display: "Rs. {amount}.00"
/// - "Successfully Sent to"
/// - Receiver avatar placeholder with green border, name, and easypaisa icon + phone number
/// - "View Receipt" & "Share" action rows
class EasypaisaSuccessScreen extends StatefulWidget {
  final EasypaisaContactModel receiver;
  final String amount;
  final DateTime? transactionTime;

  const EasypaisaSuccessScreen({
    super.key,
    required this.receiver,
    required this.amount,
    this.transactionTime,
  });

  @override
  State<EasypaisaSuccessScreen> createState() => _EasypaisaSuccessScreenState();
}

class _EasypaisaSuccessScreenState extends State<EasypaisaSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _confettiAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );

    _confettiAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amountVal = widget.amount.isEmpty ? '0' : widget.amount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Top Bar with Close 'X' button on the right
                _buildTopBar(context),

                // Main Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),

                        // Celebration Animated Tick with Confetti
                        _buildCelebrationTick(),

                        const SizedBox(height: 36),

                        // Amount Display: "Rs. {amount}.00"
                        _buildAmountDisplay(amountVal),

                        const SizedBox(height: 8),

                        // "Successfully Sent to" Label
                        Text(
                          'Successfully Sent to',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E242B),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Receiver Profile Card (Man image placeholder with green border)
                        _buildReceiverProfile(),

                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),

                // Bottom Divider & Action List (View Receipt & Share)
                _buildBottomActions(context, amountVal),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Top Bar with Close 'X' button
  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(
          Icons.close_rounded,
          size: 26,
          color: Color(0xFF8C9BA5),
        ),
        onPressed: () {
          // Return to home screen
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  /// Celebration Animated Tick with Confetti particles
  Widget _buildCelebrationTick() {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Confetti particles scattered around the checkmark
            Transform.scale(
              scale: _confettiAnim.value,
              child: SizedBox(
                width: 150,
                height: 150,
                child: CustomPaint(
                  painter: _CelebrationParticlesPainter(progress: _confettiAnim.value),
                ),
              ),
            ),

            // Central Green Checkmark Circle with Elastic Bounce
            Transform.scale(
              scale: _scaleAnim.value,
              child: Container(
                width: 76,
                height: 76,
                decoration: const BoxDecoration(
                  color: Color(0xFF00A859),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3300A859),
                      blurRadius: 18,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 46,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Large formatted Amount Display: Rs. {amount}.00
  Widget _buildAmountDisplay(String amountVal) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            'Rs. ',
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E242B),
            ),
          ),
          Text(
            amountVal,
            style: GoogleFonts.outfit(
              fontSize: 50,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E242B),
              letterSpacing: -0.5,
            ),
          ),
          Text(
            '.00',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E242B),
            ),
          ),
        ],
      ),
    );
  }

  /// Receiver Profile with green border avatar placeholder
  Widget _buildReceiverProfile() {
    return Column(
      children: [
        // Circular Avatar with vibrant green border
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF00A859),
              width: 2.0,
            ),
          ),
          child: ClipOval(
            child: Container(
              color: const Color(0xFFF0F4F2),
              // Placeholder for receiver image:
              child: Center(
                child: Text(
                  widget.receiver.initials,
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF00A859),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Receiver Name
        Text(
          widget.receiver.name,
          style: GoogleFonts.outfit(
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E242B),
          ),
        ),

        const SizedBox(height: 4),

        // Easypaisa Icon & Phone Number Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images_orig/easypaisamainlogo.png',
              width: 16,
              height: 16,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.account_balance_wallet_rounded,
                size: 16,
                color: Color(0xFF00A859),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              widget.receiver.phoneNumber,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E242B),
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Bottom Actions: View Receipt and Share
  Widget _buildBottomActions(BuildContext context, String amountVal) {
    return Material(
      color: Colors.white,
      shape: const Border(
        top: BorderSide(color: Color(0xFFEFF2F5), width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // "View Receipt" Tile
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            leading: const Icon(
              Icons.receipt_long_outlined,
              color: Color(0xFF1E242B),
              size: 24,
            ),
            title: Text(
              'View Receipt',
              style: GoogleFonts.outfit(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E242B),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Color(0xFF1E242B),
            ),
            onTap: () {
              _showReceiptModal(context, amountVal);
            },
          ),

          const Divider(height: 1, color: Color(0xFFF0F2F5)),

          // "Share" Tile
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            leading: const Icon(
              Icons.share_outlined,
              color: Color(0xFF1E242B),
              size: 22,
            ),
            title: Text(
              'Share',
              style: GoogleFonts.outfit(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E242B),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Color(0xFF1E242B),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Receipt shared successfully!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Official Receipt Dialog matching user screenshot
  void _showReceiptModal(BuildContext context, String amountVal) {
    showEasypaisaReceiptDialog(
      context,
      receiver: widget.receiver,
      amount: amountVal,
      transactionTime: widget.transactionTime ?? DateTime.now(),
    );
  }
}

/// Custom celebration painter rendering colorful confetti particles around the tick
class _CelebrationParticlesPainter extends CustomPainter {
  final double progress;

  _CelebrationParticlesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    // Particle definitions: [angleDegrees, distance, radius, colorHex]
    const particles = [
      [20.0, 58.0, 3.5, 0xFF1E242B], // dark circle
      [55.0, 62.0, 4.0, 0xFF00A859], // green dot
      [85.0, 54.0, 3.0, 0xFF283593], // navy dot
      [120.0, 64.0, 4.5, 0xFF00A859], // green dot
      [150.0, 56.0, 3.5, 0xFF8E24AA], // purple dot
      [190.0, 62.0, 4.0, 0xFF1E242B], // dark dot
      [225.0, 58.0, 3.5, 0xFF00A859], // green dot
      [260.0, 66.0, 4.5, 0xFF283593], // navy dot
      [300.0, 56.0, 3.5, 0xFF1E242B], // dark dot
      [335.0, 64.0, 4.0, 0xFF00A859], // green dot
    ];

    for (final p in particles) {
      final angle = (p[0] as double) * (math.pi / 180);
      final dist = (p[1] as double) * progress;
      final rad = (p[2] as double);
      final color = Color(p[3] as int);

      paint.color = color.withValues(alpha: (progress).clamp(0.0, 1.0));
      final x = center.dx + dist * math.cos(angle);
      final y = center.dy + dist * math.sin(angle);
      canvas.drawCircle(Offset(x, y), rad, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CelebrationParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
