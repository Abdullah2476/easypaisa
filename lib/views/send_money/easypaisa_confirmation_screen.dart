import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/easypaisa_contact_model.dart';
import 'easypaisa_success_screen.dart';

/// Screen for reviewing and confirming the Easypaisa transfer details ("Send Now" screen).
/// Strictly replicates the official Easypaisa UI from the provided screenshot:
/// - Custom rounded back button & large title "easypaisa Transfer"
/// - "Pay From" card with easypaisa logo and balance
/// - "Pay To" card with receiver details and verified green badge
/// - "Payment Summary" card showing Transfer amount, Fee (Free), and Total Amount
/// - "Favourite Contact" card with interactive toggle checkbox
/// - Review warning banner with info icon
/// - Green "Send Now" pill button
class EasypaisaConfirmationScreen extends StatefulWidget {
  final EasypaisaContactModel receiver;
  final String amount;

  const EasypaisaConfirmationScreen({
    super.key,
    required this.receiver,
    required this.amount,
  });

  @override
  State<EasypaisaConfirmationScreen> createState() => _EasypaisaConfirmationScreenState();
}

class _EasypaisaConfirmationScreenState extends State<EasypaisaConfirmationScreen> {
  bool _isFavourite = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final formattedAmount = widget.amount.isEmpty ? '0' : widget.amount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom Rounded Back Button
                  _buildBackButton(context),

                  const SizedBox(height: 18),

                  // Screen Title
                  Text(
                    'easypaisa Transfer',
                    style: GoogleFonts.outfit(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E242B),
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // 1. Pay From Section
                  _buildSectionLabel('Pay From'),
                  const SizedBox(height: 8),
                  _buildPayFromCard(),

                  const SizedBox(height: 18),

                  // 2. Pay To Section
                  _buildSectionLabel('Pay To'),
                  const SizedBox(height: 8),
                  _buildPayToCard(),

                  const SizedBox(height: 18),

                  // 3. Payment Summary Section
                  _buildSectionLabel('Payment Summary'),
                  const SizedBox(height: 8),
                  _buildPaymentSummaryCard(formattedAmount),

                  const SizedBox(height: 16),

                  // 4. Favourite Contact Card
                  _buildFavouriteCard(),

                  const SizedBox(height: 16),

                  // 5. Disclaimer / Review Warning Banner
                  _buildReviewWarningBanner(),

                  const SizedBox(height: 24),

                  // 6. "Send Now" Action Button
                  _buildSendNowButton(context, formattedAmount),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Custom Rounded Back Button Container
  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.1,
          ),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xFF1E242B),
          size: 15,
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1E242B),
        letterSpacing: -0.1,
      ),
    );
  }

  /// "Pay From" Card
  Widget _buildPayFromCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFF2F5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Easypaisa Main Logo
          Image.asset(
            'assets/images_orig/easypaisamainlogo.png',
            width: 26,
            height: 26,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.account_balance_wallet_rounded,
              color: Color(0xFF00A859),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Account Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'easypaisa',
                  style: GoogleFonts.outfit(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E242B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Balance Rs. 0.45',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E242B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// "Pay To" Card
  Widget _buildPayToCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFF2F5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular Avatar Container with Logo
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFEFF2F5),
                width: 1.2,
              ),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images_orig/easypaisamainlogo.png',
              width: 26,
              height: 26,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.person_rounded,
                color: Color(0xFF00A859),
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Receiver Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiver.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E242B),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Account Number :  ${widget.receiver.phoneNumber}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5F6E76),
                  ),
                ),
              ],
            ),
          ),

          // Green Verified Checkmark
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF00A859),
                width: 1.4,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.check_rounded,
              color: Color(0xFF00A859),
              size: 15,
            ),
          ),
        ],
      ),
    );
  }

  /// "Payment Summary" Card
  Widget _buildPaymentSummaryCard(String formattedAmount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFF2F5), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Transfer Amount Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Transfer amount',
                  style: GoogleFonts.outfit(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E242B),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Rs. $formattedAmount',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E242B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Fee Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Fee (including tax)',
                  style: GoogleFonts.outfit(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E242B),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Free',
                style: GoogleFonts.outfit(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E242B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Total Amount Row (Large & Bold)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  'Total Amount',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E242B),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Rs. $formattedAmount.00',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E242B),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// "Favourite Contact" Card with Toggleable Checkbox
  Widget _buildFavouriteCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFavourite = !_isFavourite;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEFF2F5), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox Container
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: _isFavourite ? const Color(0xFF00A859) : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: const Color(0xFF00A859),
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: _isFavourite
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
            const SizedBox(width: 12),

            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Favourite Contact',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E242B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Add this recipient as a favourite for easy',
                    style: GoogleFonts.outfit(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF5F6E76),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Review Warning Disclaimer Banner
  Widget _buildReviewWarningBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E242B),
          width: 1.1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_rounded,
            color: Color(0xFF1E242B),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Please review the details carefully before sending money.',
              style: GoogleFonts.outfit(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E242B),
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// "Send Now" Action Pill Button with 3 seconds delay & progress spinner
  Widget _buildSendNowButton(BuildContext context, String formattedAmount) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () {
                _handleSendNow(formattedAmount);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00A859),
          disabledBackgroundColor: const Color(0xFF00A859).withValues(alpha: 0.8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Send Now',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _handleSendNow(String formattedAmount) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final sentTime = DateTime.now();

    // 3 seconds delay to next screen when clicking Send Now
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EasypaisaSuccessScreen(
          receiver: widget.receiver,
          amount: formattedAmount,
          transactionTime: sentTime,
        ),
      ),
    );
  }
}
