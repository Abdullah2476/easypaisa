import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/easypaisa_contact_model.dart';
import '../../viewmodels/transfer_viewmodel.dart';
import 'easypaisa_confirmation_screen.dart';

/// Screen where the user enters the transfer amount for the selected receiver.
/// Matches the official Easypaisa UI with 100% visual fidelity:
/// - Mint green header with receiver avatar, name, and phone
/// - Large centered "Rs. 0" amount display with working numeric input
/// - Optional message action
/// - Rounded "Next" action button (dynamically enabled when amount > 0)
class EasypaisaAmountScreen extends StatefulWidget {
  final EasypaisaContactModel receiver;

  const EasypaisaAmountScreen({
    super.key,
    required this.receiver,
  });

  @override
  State<EasypaisaAmountScreen> createState() => _EasypaisaAmountScreenState();
}

class _EasypaisaAmountScreenState extends State<EasypaisaAmountScreen> {
  late final TextEditingController _amountController;
  late final TextEditingController _messageController;
  late final FocusNode _amountFocusNode;
  bool _showMessageField = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _messageController = TextEditingController();
    _amountFocusNode = FocusNode();

    // Auto-focus amount field and select receiver after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TransferViewModel>().selectReceiver(widget.receiver);
        _amountFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    // Clean resource disposal to prevent memory leaks
    _amountController.dispose();
    _messageController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _onAmountChanged(String val) {
    context.read<TransferViewModel>().setAmount(val);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransferViewModel>();
    final amountText = vm.amount;
    final isEnabled = vm.isAmountValid;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Top Pastel Mint Green Header Card with Receiver Info
                _buildMintHeader(context),

                // Scrollable Content for Amount Entry & Actions
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Enter Amount" Heading
                        Text(
                          'Enter Amount',
                          style: GoogleFonts.outfit(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E242B),
                            letterSpacing: -0.2,
                          ),
                        ),

                        const SizedBox(height: 36),

                        // Interactive Large Amount Display: "Rs. {amount}"
                        GestureDetector(
                          onTap: () => _amountFocusNode.requestFocus(),
                          behavior: HitTestBehavior.opaque,
                          child: Center(
                            child: FittedBox(
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
                                    amountText.isEmpty ? '0' : amountText,
                                    style: GoogleFonts.outfit(
                                      fontSize: 44,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1E242B),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Hidden input field that receives keyboard input cleanly
                        Opacity(
                          opacity: 0,
                          child: SizedBox(
                            height: 0,
                            width: 0,
                            child: TextField(
                              controller: _amountController,
                              focusNode: _amountFocusNode,
                              keyboardType: TextInputType.number,
                              onChanged: _onAmountChanged,
                            ),
                          ),
                        ),

                        const SizedBox(height: 36),

                        // "+ Add a Message Here (Optional)" Action
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showMessageField = !_showMessageField;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                _showMessageField
                                    ? Icons.remove_circle_outline_rounded
                                    : Icons.add_circle_outline_rounded,
                                size: 20,
                                color: const Color(0xFF1E242B),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'Add a Message Here (Optional)',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1E242B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Expandable optional message field
                        if (_showMessageField) ...[
                          const SizedBox(height: 12),
                          TextField(
                            controller: _messageController,
                            onChanged: (val) => context.read<TransferViewModel>().setOptionalMessage(val),
                            decoration: InputDecoration(
                              hintText: 'e.g. Gift, Lunch, Rent',
                              hintStyle: GoogleFonts.outfit(
                                fontSize: 13,
                                color: const Color(0xFF98A2B3),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFF00A859), width: 1.5),
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 48),

                        // Rounded "Next" Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isEnabled
                                ? () {
                                    _handleNext(context, vm);
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isEnabled
                                  ? const Color(0xFF00A859)
                                  : const Color(0xFF9E9EA7),
                              disabledBackgroundColor: const Color(0xFF9E9EA7),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: Text(
                              'Next',
                              style: GoogleFonts.outfit(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Top Pastel Mint Green Header Card
  Widget _buildMintHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF2FAF6),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation Row: Back Button & Title
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF1E242B),
                    size: 19,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'easypaisa Transfer',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E242B),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Subtitle: "Sending to easypaisa account"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'Sending to easypaisa account',
              style: GoogleFonts.outfit(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E242B),
                letterSpacing: -0.1,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Receiver Info Card Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                // Circular Avatar with Green Border and Bold Initials
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00A859),
                      width: 1.2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.receiver.initials,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E242B),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Receiver Name & Number
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.receiver.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E242B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          // Small Easypaisa green badge
                          Image.asset(
                            'assets/images_orig/easypaisa_logo.png',
                            width: 14,
                            height: 14,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.verified_rounded,
                              size: 14,
                              color: Color(0xFF00A859),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.receiver.phoneNumber,
                        style: GoogleFonts.outfit(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4A5568),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext(BuildContext context, TransferViewModel vm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EasypaisaConfirmationScreen(
          receiver: widget.receiver,
          amount: vm.amount,
        ),
      ),
    );
  }
}
