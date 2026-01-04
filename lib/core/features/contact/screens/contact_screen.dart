import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../models/contact_form_model.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactForm = ContactFormData();
  bool _isSubmitting = false;
  String? _submitMessage;
  bool _isSuccess = false;

  // Business type options
  final List<String> _businessTypes = [
    'Barbers',
    'Gym',
    'Café',
    'Restaurant',
    'Fashion Retail',
    'Beauty Salon',
    'Spa',
    'Hotel',
    'Office',
    'Other',
  ];

  // Plan options
  final List<String> _planOptions = [
    'Select a plan',
    'Retail - Basic £149.99/Year',
    'Retail - Premium £179.99/Year',
    'Retail - Elite £199.99/Year',
    'Custom Quote',
  ];

  // SMTP Configuration - FIXED settings for your domain
  static const String _smtpUsername = 'app-enquiry@spy-darecordings.com';
  static const String _smtpPassword = 'Sales@123!#';
  static const String _smtpHost = 'mail.spy-darecordings.com';
  static const int _smtpPort = 465;

  // Send email directly via SMTP
  Future<void> _sendEmailViaSMTP() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (!_contactForm.validate() || _contactForm.interestedPlan.isEmpty || _contactForm.interestedPlan == 'Select a plan') {
      setState(() {
        _submitMessage = 'Please fill in all required fields';
        _isSuccess = false;
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _submitMessage = null;
    });

    try {
      // Create SMTP server with correct settings
      final smtpServer = SmtpServer(
        _smtpHost,
        username: _smtpUsername,
        password: _smtpPassword,
        port: _smtpPort,
        ssl: true, // Changed to true for port 465
        allowInsecure: false, // Changed to false for security
      );

      // Create HTML email
      final htmlMessage = _createHtmlEmail();

      // Create plain text version
      final textMessage = _createTextEmail();

      // Create the email message
      final message = Message()
        ..from = Address(_smtpUsername, 'Spy-da Recordings')
        ..recipients.addAll([
          'sales@spy-darecordings.com',
          'bobby@spy-darecordings.com',
          'zak@spy-damusicgroup.com'
        ])
        ..subject = 'Spy-da Recordings: ${_contactForm.businessName}'
        ..text = textMessage
        ..html = htmlMessage;

      // Send the email with timeout
      final sendReport = await send(message, smtpServer)
          .timeout(Duration(seconds: 30));

      // Check if email was sent successfully
      if (sendReport != null) {
        setState(() {
          _isSubmitting = false;
          _isSuccess = true;
          _submitMessage = 'Thank you! Your message has been sent successfully. Our team will contact you within 24 hours.';
        });

        // Clear form
        _resetForm();
      } else {
        setState(() {
          _isSubmitting = false;
          _isSuccess = false;
          _submitMessage = 'Failed to send email. Please try again.';
        });
      }
    } on TimeoutException catch (_) {
      setState(() {
        _isSubmitting = false;
        _isSuccess = false;
        _submitMessage = 'Connection timeout. Please check your internet connection and try again.';
      });
    } catch (e) {
      print('Email sending error: $e');
      setState(() {
        _isSubmitting = false;
        _isSuccess = false;
        _submitMessage = 'Email sending failed. Please try again.';
      });
    }
  }

  String _createHtmlEmail() {
    return """
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spy-Da Music Prouction</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background-color: #d32f2f; color: white; padding: 20px; text-align: center; border-radius: 5px 5px 0 0; }
        .content { border: 1px solid #ddd; border-top: none; padding: 20px; border-radius: 0 0 5px 5px; }
        .section { margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .section:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
        .label { font-weight: bold; color: #d32f2f; margin-bottom: 5px; display: block; }
        .value { margin-bottom: 10px; padding-left: 15px; }
        .footer { margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; font-size: 12px; color: #666; text-align: center; }
        .plan-badge { display: inline-block; background-color: #4CAF50; color: white; padding: 5px 10px; border-radius: 3px; font-weight: bold; margin-top: 5px; }
        .callback-badge { display: inline-block; background-color: #2196F3; color: white; padding: 5px 10px; border-radius: 3px; font-weight: bold; margin-top: 5px; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Spy-da Recordings</h1>
    </div>
    
    <div class="content">
        <div class="section">
            <span class="label">BUSINESS INFORMATION</span>
            <div class="value">
                <strong>Business Name:</strong> ${_contactForm.businessName}<br>
                <strong>Contact Name:</strong> ${_contactForm.contactName}<br>
                <strong>Email:</strong> ${_contactForm.email}<br>
                <strong>Phone:</strong> ${_contactForm.phone.isNotEmpty ? _contactForm.phone : 'Not provided'}<br>
                <strong>Business Type:</strong> ${_contactForm.businessType}<br>
                <strong>Number of Locations:</strong> ${_contactForm.locations}
            </div>
        </div>
        
        <div class="section">
            <span class="label">PLAN INTEREST</span>
            <div class="value">
                <div class="plan-badge">${_contactForm.interestedPlan}</div><br>
                <strong>Callback Requested:</strong> 
                ${_contactForm.requestCallback ? '<span class="callback-badge">YES - Please Call Back</span>' : 'No'}
            </div>
        </div>
        
        ${_contactForm.message.isNotEmpty ? '''
        <div class="section">
            <span class="label">MESSAGE</span>
            <div class="value">
                ${_contactForm.message.replaceAll('\n', '<br>')}
            </div>
        </div>
        ''' : ''}
        
        <div class="section">
            <span class="label">SUBMISSION DETAILS</span>
            <div class="value">
                <strong>Submitted via:</strong> Spy-da Recordings Mobile App<br>
                <strong>Submission Time:</strong> ${DateTime.now().toString()}<br>
                <strong>IP Address:</strong> N/A (Mobile App)
            </div>
        </div>
    </div>
    
    <div class="footer">
        <p>This email was automatically generated from the Spy-da Recordings contact form.</p>
        <p>© ${DateTime.now().year} Spy-da Recordings. All rights reserved.</p>
    </div>
</body>
</html>
""";
  }

  String _createTextEmail() {
    return """
SPY-DA RECORDINGS SUBMISSION
===========================

BUSINESS INFORMATION:
• Business Name: ${_contactForm.businessName}
• Contact Name: ${_contactForm.contactName}
• Email: ${_contactForm.email}
• Phone: ${_contactForm.phone.isNotEmpty ? _contactForm.phone : 'Not provided'}
• Business Type: ${_contactForm.businessType}
• Number of Locations: ${_contactForm.locations}

PLAN INTEREST:
• Selected Plan: ${_contactForm.interestedPlan}
• Callback Requested: ${_contactForm.requestCallback ? 'YES - Please Call Back' : 'No'}

${_contactForm.message.isNotEmpty ? '''
MESSAGE:
${_contactForm.message}
''' : ''}

SUBMISSION DETAILS:
• Submitted via: Spy-da Recordings Mobile App
• Submission Time: ${DateTime.now().toString()}
• IP Address: N/A (Mobile App)

===========================
Automatically generated from Spy-da Recordings contact form.
""";
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _contactForm.businessName = '';
      _contactForm.contactName = '';
      _contactForm.email = '';
      _contactForm.phone = '';
      _contactForm.businessType = '';
      _contactForm.locations = 1;
      _contactForm.interestedPlan = '';
      _contactForm.message = '';
      _contactForm.requestCallback = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Get in Touch',
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Fill out the form below and our team will contact you within 24 hours.',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 32.h),

          // Form
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Business Name
                _buildFormField(
                  label: 'Business Name *',
                  hint: 'Enter your business name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your business name';
                    }
                    return null;
                  },
                  onSaved: (value) => _contactForm.businessName = value ?? '',
                ),
                SizedBox(height: 16.h),

                // Contact Name
                _buildFormField(
                  label: 'Contact Name *',
                  hint: 'Enter your name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => _contactForm.contactName = value ?? '',
                ),
                SizedBox(height: 16.h),

                // Email
                _buildFormField(
                  label: 'Email Address *',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!Validators.isValidEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => _contactForm.email = value ?? '',
                ),
                SizedBox(height: 16.h),

                // Phone
                _buildFormField(
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!Validators.isValidPhone(value)) {
                        return 'Please enter a valid phone number';
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => _contactForm.phone = value ?? '',
                ),
                SizedBox(height: 16.h),

                // Business Type Dropdown
                _buildDropdown(
                  label: 'Business Type *',
                  value: _contactForm.businessType,
                  items: _businessTypes,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your business type';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _contactForm.businessType = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16.h),

                // Number of Locations
                _buildNumberField(
                  label: 'Number of Locations',
                  value: _contactForm.locations,
                  onChanged: (value) {
                    setState(() {
                      _contactForm.locations = value ?? 1;
                    });
                  },
                ),
                SizedBox(height: 16.h),

                // Interested Plan dropdown
                _buildDropdown(
                  label: 'Interested Plan *',
                  value: _contactForm.interestedPlan,
                  items: _planOptions,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 'Select a plan') {
                      return 'Please select a plan';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _contactForm.interestedPlan = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16.h),

                // Message field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Message (Optional)',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Tell us about your needs or ask any questions...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) => _contactForm.message = value ?? '',
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Request Callback Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _contactForm.requestCallback,
                      onChanged: (value) {
                        setState(() {
                          _contactForm.requestCallback = value ?? false;
                        });
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        'Request a callback from our sales team',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _sendEmailViaSMTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      'Submit Enquiry',
                      style: AppTextStyles.button,
                    ),
                  ),
                ),

                // Success/Error Message - MOVED BELOW SUBMIT BUTTON
                SizedBox(height: 16.h),
                if (_submitMessage != null)
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: _isSuccess
                          ? AppColors.successColor.withOpacity(0.1)
                          : AppColors.errorColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: _isSuccess
                            ? AppColors.successColor.withOpacity(0.3)
                            : AppColors.errorColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isSuccess ? Icons.check_circle : Icons.error,
                          color: _isSuccess
                              ? AppColors.successColor
                              : AppColors.errorColor,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            _submitMessage!,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: _isSuccess
                                  ? AppColors.successColor
                                  : AppColors.errorColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 16.h),

                // Note
                Text(
                  '* Required fields',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 32.h),

                // Contact Info
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prefer to contact us directly?',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: AppColors.accentColor,
                          ),
                          title: Text(
                            'Email',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text('info@spy-darecordings.com'),
                          onTap: () => _launchSimpleEmail('info@spy-damusic.com'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: AppColors.accentColor,
                          ),
                          title: Text(
                            'Phone',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text('+44 (0) 207 101 4363'),
                          onTap: () => _launchUrl('tel:+4402071014363'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          keyboardType: keyboardType,
          validator: validator,
          onSaved: onSaved,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        DropdownButtonFormField<String>(
          value: value.isNotEmpty ? value : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            hintText: 'Select $label',
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item == 'Select a plan' ? '' : item,
              child: Text(
                item,
                style: TextStyle(
                  color: item == 'Select a plan' ? AppColors.textSecondary : null,
                ),
              ),
            );
          }).toList(),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildNumberField({
    required String label,
    required int value,
    void Function(int?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        TextFormField(
          initialValue: value.toString(),
          decoration: InputDecoration(
            hintText: 'Enter number of locations',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final num = int.tryParse(value);
            onChanged?.call(num);
          },
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      // Silently fail
    }
  }

  Future<void> _launchSimpleEmail(String recipient) async {
    try {
      final uri = Uri(
        scheme: 'mailto',
        path: recipient,
      ).toString();

      if (await canLaunchUrl(Uri.parse(uri))) {
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      // Silently fail
    }
  }
}