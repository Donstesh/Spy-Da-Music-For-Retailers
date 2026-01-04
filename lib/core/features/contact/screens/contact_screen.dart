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

  final List<String> _planOptions = [
    'Select a plan',
    'Retail - Basic £149.99/Year',
    'Retail - Premium £179.99/Year',
    'Retail - Elite £199.99/Year',
    'Custom Quote',
  ];

  static const String _smtpUsername = 'app-enquiry@spy-darecordings.com';
  static const String _smtpPassword = 'Sales@123!#';
  static const String _smtpHost = 'mail.spy-darecordings.com';
  static const int _smtpPort = 465;

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
      final smtpServer = SmtpServer(
        _smtpHost,
        username: _smtpUsername,
        password: _smtpPassword,
        port: _smtpPort,
        ssl: true,
        allowInsecure: false,
      );

      final htmlMessage = _createHtmlEmail();
      final textMessage = _createTextEmail();

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

      final sendReport = await send(message, smtpServer)
          .timeout(Duration(seconds: 30));

      if (sendReport != null) {
        setState(() {
          _isSubmitting = false;
          _isSuccess = true;
          _submitMessage = 'Thank you! Your message has been sent successfully. Our team will contact you within 24 hours.';
        });
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
    <title>Spy-da Music Prouction</title>
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: constraints.maxHeight * 0.2,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: EdgeInsets.only(bottom: 16.h),
                  title: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'CONTACT US',
                      style: AppTextStyles.headlineLarge.copyWith(
                        color: Colors.white,
                        fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.contact_mail,
                        size: 80.sp,
                        color: AppColors.pureRed,
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600 ? 32.w : 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Get in Touch',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: constraints.maxWidth > 600 ? 28.sp : 24.sp,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Fill out the form below and our team will contact you within 24 hours',
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.pureRed,
                          fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.all(14.r),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(18.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildFormField(
                            constraints: constraints,
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

                          _buildFormField(
                            constraints: constraints,
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

                          _buildFormField(
                            constraints: constraints,
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

                          _buildFormField(
                            constraints: constraints,
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

                          _buildDropdown(
                            constraints: constraints,
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

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Number of Locations',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: Colors.grey[400]!),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove, color: Colors.black),
                                      onPressed: () {
                                        setState(() {
                                          if (_contactForm.locations > 1) {
                                            _contactForm.locations--;
                                          }
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        _contactForm.locations.toString(),
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.titleMedium.copyWith(
                                          color: Colors.black,
                                          fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add, color: Colors.black),
                                      onPressed: () {
                                        setState(() {
                                          _contactForm.locations++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          _buildDropdown(
                            constraints: constraints,
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

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Message (Optional)',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: Colors.grey[400]!),
                                ),
                                child: TextFormField(
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Tell us about your needs or ask any questions...',
                                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.black54,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(14.r),
                                  ),
                                  maxLines: 4,
                                  keyboardType: TextInputType.multiline,
                                  onSaved: (value) => _contactForm.message = value ?? '',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.white30),
                            ),
                            padding: EdgeInsets.all(12.r),
                            child: Row(
                              children: [
                                Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                      color: _contactForm.requestCallback
                                          ? AppColors.pureRed
                                          : Colors.white60,
                                      width: 2,
                                    ),
                                    color: _contactForm.requestCallback
                                        ? AppColors.pureRed
                                        : Colors.transparent,
                                  ),
                                  child: Checkbox(
                                    value: _contactForm.requestCallback,
                                    onChanged: (value) {
                                      setState(() {
                                        _contactForm.requestCallback = value ?? false;
                                      });
                                    },
                                    activeColor: AppColors.pureRed,
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                        return Colors.transparent;
                                      },
                                    ),
                                    side: BorderSide.none,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    'Request a callback from our sales team',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32.h),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _sendEmailViaSMTP,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.pureRed,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.r),
                                ),
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
                                style: AppTextStyles.button.copyWith(
                                  color: Colors.white,
                                  fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16.h),
                          if (_submitMessage != null)
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: _isSuccess
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(
                                  color: _isSuccess
                                      ? Colors.green.withOpacity(0.3)
                                      : Colors.red.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _isSuccess ? Icons.check_circle : Icons.error,
                                    color: _isSuccess ? Colors.green : Colors.red,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      _submitMessage!,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: _isSuccess ? Colors.green : Colors.red,
                                        fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          SizedBox(height: 16.h),
                          Text(
                            '* Required fields',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white70,
                              fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(14.r),
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey[900]!,
                        Colors.black,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Prefer to contact us directly?',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontSize: constraints.maxWidth > 600 ? 22.sp : 20.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 14.h),

                      if (constraints.maxWidth > 600)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: _buildContactOption(
                                constraints: constraints,
                                icon: Icons.email,
                                title: 'Email',
                                subtitle: 'info@spy-darecordings.com',
                                onTap: () => _launchSimpleEmail('info@spy-damusic.com'),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: _buildContactOption(
                                constraints: constraints,
                                icon: Icons.phone,
                                title: 'Phone',
                                subtitle: '+44 (0) 207 101 4363',
                                onTap: () => _launchUrl('tel:+4402071014363'),
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            _buildContactOption(
                              constraints: constraints,
                              icon: Icons.email,
                              title: 'Email',
                              subtitle: 'info@spy-damusic.com',
                              onTap: () => _launchSimpleEmail('info@spy-damusic.com'),
                            ),
                            SizedBox(height: 16.h),
                            _buildContactOption(
                              constraints: constraints,
                              icon: Icons.phone,
                              title: 'Phone',
                              subtitle: '+44 (0) 207 101 4363',
                              onTap: () => _launchUrl('tel:+4402071014363'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(18.r),
                  color: Colors.black,
                  child: Column(
                    children: [
                      Icon(
                        Icons.music_note,
                        size: 28.sp,
                        color: AppColors.pureRed,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'SPY-DA RECORDINGS',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: constraints.maxWidth > 600 ? 20.sp : 18.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Professional Music Solutions',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                          fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        '© ${DateTime.now().year} Spy-da Recordings. All rights reserved.',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white30,
                          fontSize: constraints.maxWidth > 600 ? 14.sp : 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFormField({
    required BoxConstraints constraints,
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
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: TextFormField(
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: Colors.black54,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14.r),
            ),
            keyboardType: keyboardType,
            validator: validator,
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required BoxConstraints constraints,
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
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: DropdownButtonFormField<String>(
            value: value.isNotEmpty ? value : null,
            dropdownColor: Colors.white,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 14.w),
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item == 'Select a plan' ? '' : item,
                child: Text(
                  item,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: item == 'Select a plan' ? Colors.black54 : Colors.black,
                  ),
                ),
              );
            }).toList(),
            validator: validator,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildContactOption({
    required BoxConstraints constraints,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white30),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColors.pureRed.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.pureRed,
                size: constraints.maxWidth > 600 ? 28.sp : 24.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontSize: constraints.maxWidth > 600 ? 18.sp : 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
                fontSize: constraints.maxWidth > 600 ? 16.sp : 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      print('Error launching URL: $e');
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
      print('Error launching email: $e');
    }
  }
}