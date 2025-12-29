import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/constants/api_endpoints.dart';
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
    'Starter',
    'Growth',
    'Premium',
    'Not Sure',
    'Custom Quote',
  ];

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (!_contactForm.validate()) {
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
      final apiService = ApiService();
      final response = await apiService.postForm(
        ApiEndpoints.contact,
        _contactForm.toJson(),
      );

      setState(() {
        _isSubmitting = false;
        _isSuccess = response['ok'] == true;
        _submitMessage = response['message'] ?? response['error'] ?? 'Submission completed';

        if (_isSuccess) {
          // Clear form on success
          _formKey.currentState!.reset();
          _contactForm.businessName = '';
          _contactForm.contactName = '';
          _contactForm.email = '';
          _contactForm.phone = '';
          _contactForm.businessType = '';
          _contactForm.locations = 1;
          _contactForm.interestedPlan = '';
          _contactForm.message = '';
          _contactForm.requestCallback = false;
        }
      });
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _isSuccess = false;
        _submitMessage = 'Failed to submit form. Please try again.';
      });
    }
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

          // Success/Error Message
          if (_submitMessage != null)
            Container(
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(bottom: 16.h),
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

                // Interested Plan
                _buildDropdown(
                  label: 'Interested Plan',
                  value: _contactForm.interestedPlan,
                  items: _planOptions,
                  onChanged: (value) {
                    setState(() {
                      _contactForm.interestedPlan = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16.h),

                // Message
                _buildTextArea(
                  label: 'Message (Optional)',
                  hint: 'Tell us about your music needs or ask any questions...',
                  onSaved: (value) => _contactForm.message = value ?? '',
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
                    onPressed: _isSubmitting ? null : _submitForm,
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
                _buildContactInfo(),
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

  Widget _buildTextArea({
    required String label,
    required String hint,
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
            alignLabelWithHint: true,
          ),
          maxLines: 4,
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
          items: [
            DropdownMenuItem<String>(
              value: '',
              child: Text(
                'Select $label',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ...items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ],
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

  Widget _buildContactInfo() {
    return Card(
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
              subtitle: Text('support@spy-damusic.com'),
              onTap: () => _launchUrl('mailto:support@spy-damusic.com'),
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
              subtitle: Text('+44 XXXXXXXX'),
              onTap: () => _launchUrl('tel:+44XXXXXXXXXX'),
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: AppColors.accentColor,
              ),
              title: Text(
                'Book a Demo',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text('Schedule a personalized demo'),
              onTap: () => _launchUrl(ApiEndpoints.bookDemo),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}