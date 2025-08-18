import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lostnfound/model/item_display_model.dart';
import 'package:lostnfound/provider/auth_provider.dart';
import 'package:lostnfound/provider/item_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailScreen extends ConsumerStatefulWidget {
  final ItemDisplayModel item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  ConsumerState<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = false;
  String? _selectedStatus;
  String? _returnedToPsid;
  final _returnedToPsidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.item.status;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _returnedToPsidController.dispose();
    super.dispose();
  }

  // Enhanced email functionality with better error handling
  Future<void> _contactAdmin(BuildContext context) async {
    setState(() => _isLoading = true);

    try {
      const email = 'admin@lostnfoundLTFD.com';
      final subject = 'Claiming Lost Item: ${widget.item.title}';
      final body = '''Hello,

I believe the following item belongs to me:

Title: ${widget.item.title}
Location: ${widget.item.place}
Type: ${widget.item.type}
Date Found: ${widget.item.dateTime}
Description: ${widget.item.description}

Please assist me in claiming this item. I can provide additional verification if needed.

Thank you for your assistance.

Best regards''';

      // Try different URI schemes for better compatibility
      final List<String> emailUris = [
        'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
        'mailto:$email',
      ];

      bool launched = false;
      for (String uri in emailUris) {
        final Uri emailUri = Uri.parse(uri);
        if (await canLaunchUrl(emailUri)) {
          launched = await launchUrl(
            emailUri,
            mode: LaunchMode.externalApplication,
          );
          if (launched) break;
        }
      }

      if (!launched) {
        _showContactOptions(context);
      } else {
        _showSuccessSnackBar(context, 'Email app opened successfully');
      }
    } catch (e) {
      _showContactOptions(context);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Alternative contact options dialog
  void _showContactOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Contact Admin'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Email app could not be opened. Here are alternative options:'),
              const SizedBox(height: 16),
              _buildContactOption(
                icon: Icons.email,
                title: 'Copy Email Address',
                subtitle: 'admin@lostnfoundLTFD.com',
                onTap: () {
                  Clipboard.setData(
                      const ClipboardData(text: 'admin@lostnfoundLTFD.com'));
                  Navigator.pop(context);
                  _showSuccessSnackBar(
                      context, 'Email address copied to clipboard');
                },
              ),
              const SizedBox(height: 8),
              _buildContactOption(
                icon: Icons.content_copy,
                title: 'Copy Item Details',
                subtitle: 'Copy formatted item information',
                onTap: () {
                  final details = '''Item Details:
Title: ${widget.item.title}
Location: ${widget.item.place}
Type: ${widget.item.type}
Date: ${widget.item.dateTime}
Description: ${widget.item.description}''';
                  Clipboard.setData(ClipboardData(text: details));
                  Navigator.pop(context);
                  _showSuccessSnackBar(
                      context, 'Item details copied to clipboard');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text(subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;
    print("==============");
    print(user.toString());
    print("==============");
    print(user?.isAdmin.toString());
    print("==============");
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Item Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _shareItem(context),
            icon: const Icon(Icons.share),
            tooltip: 'Share Item',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              _buildImageSection(),
              const SizedBox(height: 20),

              // Item Details Form
              _buildFormField(
                label: 'Item Title',
                value: widget.item.title,
                icon: Icons.label,
              ),
              const SizedBox(height: 16),

              _buildFormField(
                label: 'Location Found',
                value: widget.item.place,
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),

              _buildFormField(
                label: 'Item Type',
                value: widget.item.type,
                icon: Icons.category,
              ),
              const SizedBox(height: 16),

              if (user?.isAdmin == 1) ...[
                _buildStatusDropdown(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (user == null || _selectedStatus == null) return;

                          setState(() => _isLoading = true);

                          try {
                            await ref.read(updateItemStatusProvider({
                              'itemId': widget.item.id, // Use item.id
                              'psid': user.psid,
                              'status': _selectedStatus!,
                              'returnedToPsid': _selectedStatus == 'RETURNED'
                                  ? _returnedToPsidController.text.trim()
                                  : null,
                            }).future);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Status updated successfully'),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to update: $e')),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() => _isLoading = false);
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Submit'),
                ),
              ] else ...[
                _buildFormField(
                  label: 'Status',
                  value: widget.item.status,
                  icon: Icons.info,
                ),
              ],
              const SizedBox(height: 16),

              _buildFormField(
                label: 'Date & Time Found',
                value: widget.item.dateTime,
                icon: Icons.access_time,
              ),
              const SizedBox(height: 16),

              // Tags section (if available)
              if (widget.item.tags.isNotEmpty)
                Column(
                  children: [
                    _buildFormField(
                      label: 'Tags',
                      value: widget.item.tags,
                      icon: Icons.tag,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              // Description Section
              _buildDescriptionField(),
              const SizedBox(height: 24),

              // Contact Button
              _buildContactButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    // Align with backend ItemStatus enum
    const statuses = ['REPORTED', 'LOST', 'FOUND', 'RETURNED'];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info, size: 20, color: Colors.deepPurple),
              const SizedBox(width: 8),
              Text(
                'Status',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedStatus,
            items: statuses
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedStatus = value; // Update local state
                });
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
            ),
          ),
          if (_selectedStatus == 'RETURNED') ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: _returnedToPsidController,
              decoration: InputDecoration(
                labelText: 'Returned To PSID (Optional)',
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                prefixIcon: const Icon(Icons.person, color: Colors.deepPurple),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return AspectRatio(
      aspectRatio: 16 / 9, // ✅ keeps image in 16:9 ratio
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: widget.item.image.isNotEmpty
              ? Image.network(
                  widget.item.image.startsWith('http')
                      ? widget.item.image
                      : 'http://192.168.102.130:8080${widget.item.image}',
                  fit: BoxFit.cover, // ✅ keeps aspect ratio while filling
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildImagePlaceholder(),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return _buildImagePlaceholder(showLoading: true);
                  },
                )
              : _buildImagePlaceholder(),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder({bool showLoading = false}) {
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      child: showLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported,
                    size: 60, color: Colors.grey[400]),
                const SizedBox(height: 8),
                Text(
                  'No Image Available',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.description,
                    size: 20, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                widget.item.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : () => _contactAdmin(context),
        icon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.email_outlined),
        label: Text(
          _isLoading ? 'Opening...' : 'Contact Admin',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
    );
  }

  void _shareItem(BuildContext context) {
    final shareText = '''Found Item: ${widget.item.title}

Location: ${widget.item.place}
Type: ${widget.item.type}
Date: ${widget.item.dateTime}

Description: ${widget.item.description}

Contact admin@lostnfoundLTFD.com to claim this item.''';

    Clipboard.setData(ClipboardData(text: shareText));
    _showSuccessSnackBar(context, 'Item details copied to clipboard');
  }
}
