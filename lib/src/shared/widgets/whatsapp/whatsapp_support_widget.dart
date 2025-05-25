import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppSupportWidget extends StatelessWidget {
  final String phoneNumber;
  final String message;
  final String buttonText;
  final String? helpText;
  final bool showFullWidth;
  final EdgeInsetsGeometry padding;
  final bool useOutlinedButton;

  const WhatsAppSupportWidget({
    super.key,
    this.phoneNumber = '+255758585847',
    this.message = '',
    this.buttonText = 'Wasiliana Nasi',
    this.helpText,
    this.showFullWidth = true,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.useOutlinedButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (helpText != null) ...[
            Text(
              helpText!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
          ],
          useOutlinedButton
              ? OutlinedButton.icon(
                  onPressed: _launchWhatsApp,
                  style: OutlinedButton.styleFrom(
                    minimumSize: showFullWidth
                        ? const Size(double.infinity, 48)
                        : const Size(0, 48),
                    foregroundColor: colorScheme.primary,
                    side: BorderSide(color: colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green[700],
                    size: 20,
                  ),
                  label: Text(buttonText),
                )
              : ElevatedButton.icon(
                  onPressed: _launchWhatsApp,
                  style: ElevatedButton.styleFrom(
                    minimumSize: showFullWidth
                        ? const Size(double.infinity, 48)
                        : const Size(0, 48),
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(
                    FontAwesomeIcons.whatsapp,
                    size: 20,
                  ),
                  label: Text(buttonText),
                ),
        ],
      ),
    );
  }

  void _launchWhatsApp() async {
    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl = 'https://wa.me/$phoneNumber?text=$encodedMessage';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
