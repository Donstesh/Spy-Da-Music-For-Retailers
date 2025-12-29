import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_preferences.dart';
import '../splash/splash_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;
  bool _acceptedTerms = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() => _hasScrolledToBottom = true);
    }
  }

  void _completeTerms() async {
    await AppPreferences.setTermsAccepted();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SPY-DA MUSIC GROUP LTD MUSIC ENTERTAINMENT APPLICATION / WEBSITE AND ONLINE SERVICES TERMS AND CONDITIONS',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  '(Contains legal information, including the Terms and Conditions and Code of Conduct applicable to this application and content. PLEASE READ THIS CAREFULLY!)',
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                ),
                SizedBox(height: 24.h),
                Text(
                  'This Application & the content is the property of Spy-da Music Group Ltd / Spy-da Productions Limited / Spy-da Recordings Ltd & Spy-da Music Publishing Ltd. References to SMG, SMG Online Services, or this application shall also be deemed to be references to SMG.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                Text(
                  'SMG PROVIDES ACCESS TO THIS APPLICATION AND ANY RELATED SERVICES PROVIDED HEREON (THE SMG ONLINE SERVICES) SUBJECT TO YOUR COMPLIANCE WITH THE FOLLOWING TERMS AND CONDITIONS. THESE TERMS AND CONDITIONS CONSTITUTE AN AGREEMENT BETWEEN YOU AND SMG AGREEMENT THAT GOVERNS THE RELATIONSHIP BETWEEN YOU AND SMG WITH RESPECT TO YOUR USE OF THIS WEBSITE AND THE SMG ONLINE SERVICES. THUS, IT IS IMPORTANT THAT YOU READ CAREFULLY AND UNDERSTAND THESE TERMS AND CONDITIONS.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                Text(
                  'TRADEMARK AND COPYRIGHT INFORMATION:',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'All material on this website, including, but not limited to, text, data, graphics, logos, button icons, images, audio clips, video clips, links, digital downloads, data compilations, and software is owned, controlled by, or licensed to SMG and is protected by copyright, trademark, and other intellectual property rights. Material on this website is made available solely for your personal, non-commercial use and may not be copied, reproduced, republished, modified, uploaded, posted, transmitted, or distributed in any way, including by e-mail or other electronic means, without the express prior written consent of SMG in each instance. You may download material intentionally made available for downloading from this website for your personal, non-commercial use only, provided that you keep intact any and all copyright and other proprietary notices that may appear on such materials.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                Text(
                  'CODE OF CONDUCT:',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'The following rules, policies, and disclaimers shall govern and/or apply to your use of the SMG Online Services on this website (including, without limitation, any bulletin boards, chat rooms, or other online services provided on this website). We do not review every message, nor do we confirm the accuracy or validity of information posted. We do not actively monitor the contents of the postings, nor are we responsible for the content of any postings. We do not vouch for, nor do we warrant the validity, accuracy, completeness, or usefulness of any message or information posted. The contents of the postings do not represent the views of SMG, its labels, or any person or property associated with SMG, the SMG Online Services, this website, or any other website in the SMG family of websites. If you feel that any posting is objectionable, we encourage you to contact us by email. We will make every effort to remove objectionable content if we deem removal to be warranted. Please understand that removal or editing of any posting is a manual process and might not occur immediately. You agree, by using this website and/or the SMG Online Services, that:',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '(1) you will not use this website or any of the SMG Online Services to post any material that is knowingly false and/or defamatory, inaccurate, abusive, vulgar, obscene, profane, hateful, harassing, sexually oriented, threatening, invasive of one\'s privacy, or otherwise in violation of any law.',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '(2) you will not restrict or inhibit any other user from using and enjoying this website or any of the SMG Online Services provided hereon (for example, by means of hacking or defacement).',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '(3) you will not post any copyrighted material on this website or any of the SMG Online Services provided hereon unless you own the copyright in and to such material',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '(4) you will not post or transmit any information or software that contains a virus, worm, timebomb, cancel bot, trojan horse or other harmful, disruptive, or deleterious component.',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '(5) you will not post or transmit materials in violation of another party\'s copyright or other intellectual property rights.',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '(6) you will not utilize any robot, spider, site search/retrieval application, or any other manual or automated technique to scrape, index, data mine, etc., or in any way reproduce or circumvent the navigational structure or presentation of this website, the SMG Online Services, or the contents of such website or services; and',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '(7) you will not impersonate any other individual or entity in connection with your use of this website or any of the SMG Online Services.',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Although we cannot and do not review all posted messages, we reserve the right to remove (or not) any message for any (or no) reason whatsoever. You remain solely responsible for the content of your messages, and you agree to indentify and hold harmless SMG and their agents with respect to any claim based upon the transmission of your message(s) and/or posting(s).',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                Text(
                  'We reserve the right to reveal your identity (including whatever information we know about you in the event of a complaint or legal action arising from any message posted by you.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Posting of advertisements, chain letters, pyramid schemes, solicitations, and the like, are inappropriate and forbidden on the SMG websites and any related SMG Online Services (including bulletin boards and chat rooms).',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                Text(
                  'VOID WHERE PROHIBITED',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Although this website is accessible worldwide, not all products or services discussed or referenced on this website are available to all persons or in all geographic locations. SMG reserves the right to limit, in its sole discretion, the provision and quantity of any product or service to any person or geographic area it so desires. Any offer for any product or service made in this website is void where prohibited.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                Text(
                  'LICENSE TO Spy-da Recordings',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'By posting messages, uploading files, inputting data, or engaging in any other form of communication through this website, you are granting SMG a royalty-free, perpetual, non-exclusive, unrestricted, worldwide license to:',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '(1) Use, copy, sublicense, adapt, transmit, publicly perform, or display any such communication; and',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '(2) Sublicense to third parties the unrestricted right to exercise any of the foregoing rights granted with respect to the communication. The foregoing grants shall include the right to exploit any proprietary rights in such communication, including but not limited to rights under copyright, trademark, service mark, or patent laws under any relevant jurisdiction.',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'MAKING PURCHASES',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'If you wish to purchase products or services described on this website, you may be asked to supply certain information including credit card or other payment information. You agree that all information that you provide will be accurate, complete, and current. You agree to pay all charges, including shipping and handling charges, incurred by users of your credit card or other payment mechanism at the prices in effect when such charges are incurred. You will also be responsible for paying any applicable taxes relating to your purchases.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                Text(
                  'INDEMNIFICATION',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'You agree to indemnify, defend, and hold harmless SMG and its affiliated companies, officers, directors, employees, agents, licensors, and suppliers from and against all losses, expenses damages, and costs, including reasonable attorneys\' fees, resulting from any violation by you of these Terms and Conditions. SMG reserves the right to assume the exclusive defence and control of any matter subject to indemnification by you.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                Text(
                  'LITIGATION ISSUES.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'This Agreement is entered into in England & Wales and shall be governed by, and construed in accordance with, the laws of England & Wales, exclusive of its choice of law rules. Each party to this Agreement submits to the exclusive jurisdiction of England & Wales Courts sitting in the Boroughs of England & Wales, and waives any jurisdictional, venue, or inconvenient forum objections to such courts. Each party to this Agreement further agrees as follows: (i) any claim brought to enforce this Agreement must be commenced within two (2) years of the cause of action accruing; (ii) no recovery may be sought or received for damages other than out-of-pocket expenses, except that the prevailing party will be entitled to costs and attorneys\' fees; (iii) any claim must be brought individually and not consolidated as part of a group or class action complaint.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                Text(
                  'MISCELLANEOUS',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'In the event that any of the provisions of this Agreement are held by a court or other tribunal of competent jurisdiction to be unenforceable, such provisions shall be limited or eliminated to the minimum extent necessary so that this Agreement shall otherwise remain in full force and effect.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  'This Agreement constitutes the entire agreement between the parties hereto pertaining to the subject matter hereof, and all written or oral agreements heretofore existing between the parties hereto with respect to the subject matter of this Agreement are expressly cancelled. SMG may modify the terms of this Agreement by posting notice of modification on the page of this website entitled Legal Notices or Legal Information (or similar title) before the modification takes effect.',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    'All rights reserved. Copyright © 2022 Spy-da Music Group Ltd',
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
          if (!_hasScrolledToBottom)
            Positioned(
              bottom: 120.h,
              right: 20.w,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Icon(Icons.arrow_downward, color: Colors.white, size: 24.w),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptedTerms,
                        onChanged: (value) {
                          setState(() => _acceptedTerms = value ?? false);
                        },
                        activeColor: Colors.red,
                        checkColor: Colors.white,
                      ),
                      Expanded(
                        child: Text(
                          'I have read and agree to the Terms and Conditions',
                          style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _acceptedTerms ? Colors.red : Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      onPressed: _acceptedTerms ? _completeTerms : null,
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}