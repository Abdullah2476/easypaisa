import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../data/easypaisa_contacts_data.dart';
import '../../models/easypaisa_contact_model.dart';
import '../../viewmodels/transfer_viewmodel.dart';
import 'easypaisa_amount_screen.dart';

/// Screen for Easypaisa Transfer.
/// Displays tabs for Send Money and History, My Easypaisa Favourites,
/// Mobile No. / Digital Account No. toggle, and an interactive receiver input field
/// that filters contacts using .where() and routes to the Amount screen.
class EasypaisaTransferScreen extends StatefulWidget {
  const EasypaisaTransferScreen({super.key});

  @override
  State<EasypaisaTransferScreen> createState() => _EasypaisaTransferScreenState();
}

class _EasypaisaTransferScreenState extends State<EasypaisaTransferScreen> {
  int _selectedTabIndex = 0; // 0: Send Money, 1: History
  bool _isMobileNoSelected = true; // true: Mobile No., false: Digital Account No
  late final TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              // Tabs: Send Money & History
              _buildTabBar(),

              // Main Body Content
              Expanded(
                child: _selectedTabIndex == 0 ? _buildSendMoneyContent() : _buildHistoryContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Custom App Bar matching the official UI
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xFF1E242B),
          size: 19,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'easypaisa Transfer',
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1E242B),
          letterSpacing: -0.2,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Easypaisa Transfer Help & Support'),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Text(
            'Help',
            style: GoogleFonts.outfit(
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4A5568),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  /// Top Tabs: Send Money vs History with exact active green underline indicator
  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0F2F5),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Tab 1: Send Money
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedTabIndex = 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Send Money',
                      style: GoogleFonts.outfit(
                        fontSize: 14.5,
                        fontWeight: _selectedTabIndex == 0 ? FontWeight.w600 : FontWeight.w500,
                        color: _selectedTabIndex == 0 ? const Color(0xFF00A859) : const Color(0xFF8C9BA5),
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    color: _selectedTabIndex == 0 ? const Color(0xFF00A859) : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),

          // Tab 2: History
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedTabIndex = 1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'History',
                      style: GoogleFonts.outfit(
                        fontSize: 14.5,
                        fontWeight: _selectedTabIndex == 1 ? FontWeight.w600 : FontWeight.w500,
                        color: _selectedTabIndex == 1 ? const Color(0xFF00A859) : const Color(0xFF8C9BA5),
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    color: _selectedTabIndex == 1 ? const Color(0xFF00A859) : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Content for Send Money Tab
  Widget _buildSendMoneyContent() {
    final filteredContacts = context.watch<TransferViewModel>().filteredContacts;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),

          // "My Easypaisa Favourites" Row with "See All"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'My Easypaisa Favourites',
                    style: GoogleFonts.outfit(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E242B),
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Viewing all favourites'),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: GoogleFonts.outfit(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E242B),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Segmented Control: Mobile No. vs Digital Account No
          _buildSegmentedControl(),

          const SizedBox(height: 24),

          // Section Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              _isMobileNoSelected
                  ? "Enter Receiver's Mobile Number"
                  : "Enter Receiver's Digital Account Number",
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E242B),
                letterSpacing: -0.1,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Working Input Field with signature Green accent bar on left edge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: _buildReceiverInputField(),
          ),

          // Real-time Filtered Contacts Suggestions using .where()
          if (filteredContacts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: _buildFilteredContactsList(filteredContacts),
            ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Pill Segmented Control matching the exact rounded design in the screenshot
  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F3F6),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Mobile No. Segment
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isMobileNoSelected = true),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: _isMobileNoSelected ? const Color(0xFF00A859) : Colors.transparent,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Mobile No.',
                    style: GoogleFonts.outfit(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: _isMobileNoSelected ? Colors.white : const Color(0xFF1E242B),
                    ),
                  ),
                ),
              ),
            ),

            // Digital Account No Segment
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isMobileNoSelected = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: !_isMobileNoSelected ? const Color(0xFF00A859) : Colors.transparent,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Digital Account No',
                    style: GoogleFonts.outfit(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: !_isMobileNoSelected ? Colors.white : const Color(0xFF1E242B),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Working Receiver Input Field with Green Accent Bar on the left border
  Widget _buildReceiverInputField() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD0D5DD),
          width: 1.1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Row(
          children: [
            // Signature vertical green accent indicator on the left edge
            Container(
              width: 4.5,
              height: double.infinity,
              color: const Color(0xFF00A859),
            ),

            // Working TextField
            Expanded(
              child: TextField(
                controller: _numberController,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E242B),
                ),
                decoration: InputDecoration(
                  hintText: _isMobileNoSelected
                      ? "Enter Receiver's Number or select from contacts"
                      : "Enter 11-digit Digital Account Number",
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF98A2B3),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF98A2B3),
                      size: 22,
                    ),
                    onPressed: () => _onSubmitNumber(_numberController.text),
                  ),
                ),
                onChanged: (val) {
                  context.read<TransferViewModel>().onSearchQueryChanged(val);
                },
                onSubmitted: (value) => _onSubmitNumber(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Real-time Suggestions List for Filtered Contacts using .where()
  Widget _buildFilteredContactsList(List<EasypaisaContactModel> contacts) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Material(
        color: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: contacts.length,
          separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF0F2F5)),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF2FAF6),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF00A859), width: 1.1),
              ),
              alignment: Alignment.center,
              child: Text(
                contact.initials,
                style: GoogleFonts.outfit(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E242B),
                ),
              ),
            ),
            title: Text(
              contact.name,
              style: GoogleFonts.outfit(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E242B),
              ),
            ),
            subtitle: Text(
              contact.phoneNumber,
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF5A6B75),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Color(0xFF8C9BA5),
            ),
            onTap: () => _navigateToAmountScreen(contact),
          );
        },
      ),
    ),
  );
}

  void _onSubmitNumber(String value) {
    if (value.trim().isEmpty) return;
    final clean = value.trim();

    // Use .where() filter from data layer
    final matches = filterContactsByQuery(clean);
    final targetReceiver = matches.isNotEmpty
        ? matches.first
        : EasypaisaContactModel(
            id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
            name: 'Flutter With Ahmad',
            phoneNumber: clean,
            initials: 'FW',
          );

    _navigateToAmountScreen(targetReceiver);
  }

  void _navigateToAmountScreen(EasypaisaContactModel receiver) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EasypaisaAmountScreen(receiver: receiver),
      ),
    );
  }

  /// Placeholder for History tab
  Widget _buildHistoryContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_rounded,
            size: 48,
            color: const Color(0xFF8C9BA5).withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            'No recent transfers found',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8C9BA5),
            ),
          ),
        ],
      ),
    );
  }
}
