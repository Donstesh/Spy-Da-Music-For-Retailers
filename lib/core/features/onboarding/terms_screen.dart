import 'package:flutter/material.dart';
import '../splash/splash_screen.dart'; // Correct relative path

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
    // This should be imported from your AppPreferences
    // For now, I'll create a placeholder
    _setTermsAccepted();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()), // Remove const
    );
  }

  // Placeholder function - replace with your actual AppPreferences.setTermsAccepted()
  void _setTermsAccepted() {
    // TODO: Implement actual terms acceptance logic
    print('Terms accepted');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive font sizes
    final largeFontSize = screenWidth * 0.05;
    final mediumFontSize = screenWidth * 0.04;
    final smallFontSize = screenWidth * 0.035;
    final verySmallFontSize = screenWidth * 0.03;
    final buttonFontSize = screenWidth * 0.045; // Added missing variable

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.05,
              screenHeight * 0.02,
              screenWidth * 0.05,
              screenHeight * 0.12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SPY-DA MUSIC GROUP LTD MUSIC ENTERTAINMENT APPLICATION / WEBSITE AND ONLINE SERVICES TERMS AND CONDITIONS',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: largeFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '(Contains legal information, including the Terms and Conditions and Code of Conduct applicable to this application and content. PLEASE READ THIS CAREFULLY!)',
                  style: TextStyle(color: Colors.white70, fontSize: verySmallFontSize),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'This Application & the content is the property of Spy-da Music Group Ltd / Spy-da Productions Limited / Spy-da Recordings Ltd & Spy-da Music Publishing Ltd. References to SMG, SMG Online Services, or this application shall also be deemed to be references to SMG.',
                  style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'SMG PROVIDES ACCESS TO THIS APPLICATION AND ANY RELATED SERVICES PROVIDED HEREON (THE SMG ONLINE SERVICES) SUBJECT TO YOUR COMPLIANCE WITH THE FOLLOWING TERMS AND CONDITIONS. THESE TERMS AND CONDITIONS CONSTITUTE AN AGREEMENT BETWEEN YOU AND SMG AGREEMENT THAT GOVERNS THE RELATIONSHIP BETWEEN YOU AND SMG WITH RESPECT TO YOUR USE OF THIS WEBSITE AND THE SMG ONLINE SERVICES. THUS, IT IS IMPORTANT THAT YOU READ CAREFULLY AND UNDERSTAND THESE TERMS AND CONDITIONS.',
                  style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'TRADEMARK AND COPYRIGHT INFORMATION:',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: largeFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'All material on this website, including, but not limited to, text, data, graphics, logos, button icons, images, audio clips, video clips, links, digital downloads, data compilations, and software is owned, controlled by, or licensed to SMG and is protected by copyright, trademark, and other intellectual property rights. Material on this website is made available solely for your personal, non-commercial use and may not be copied, reproduced, republished, modified, uploaded, posted, transmitted, or distributed in any way, including by e-mail or other electronic means, without the express prior written consent of SMG in each instance. You may download material intentionally made available for downloading from this website for your personal, non-commercial use only, provided that you keep intact any and all copyright and other proprietary notices that may appear on such materials.',
                  style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'CODE OF CONDUCT:',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: largeFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'The following rules, policies, and disclaimers shall govern and/or apply to your use of the SMG Online Services on this website (including, without limitation, any bulletin boards, chat rooms, or other online services provided on this website). We do not review every message, nor do we confirm the accuracy or validity of information posted. We do not actively monitor the contents of the postings, nor are we responsible for the content of any postings. We do not vouch for, nor do we warrant the validity, accuracy, completeness, or usefulness of any message or information posted. The contents of the postings do not represent the views of SMG, its labels, or any person or property associated with SMG, the SMG Online Services, this website, or any other website in the SMG family of websites. If you feel that any posting is objectionable, we encourage you to contact us by email. We will make every effort to remove objectionable content if we deem removal to be warranted. Please understand that removal or editing of any posting is a manual process and might not occur immediately. You agree, by using this website and/or the SMG Online Services, that:',
                  style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '(1) you will not use this website or any of the SMG Online Services to post any material that is knowingly false and/or defamatory, inaccurate, abusive, vulgar, obscene, profane, hateful, harassing, sexually oriented, threatening, invasive of one\'s privacy, or otherwise in violation of any law.',
                        style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '(2) you will not restrict or inhibit any other user from using and enjoying this website or any of the SMG Online Services provided hereon (for example, by means of hacking or defacement).',
                        style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '(3) you will not post any copyrighted material on this website or any of the SMG Online Services provided hereon unless you own the copyright in and to such material',
                        style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '(4) you will not post or transmit any information or software that contains a virus, worm, timebomb, cancel bot, trojan horse or other harmful, disruptive, or deleterious component.',
                        style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '(5) you will not post or transmit materials in violation of another party\'s copyright or other intellectual property rights.',
                        style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '(6) you will not utilize any robot, spider, site search/retrieval application, or any other manual or automated technique to scrape, index, data mine, etc., or in any way reproduce or circumvent the navigational structure or presentation of this website, the SMG Online Services, or the contents of such website or services; and',
                        style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '(7) you will not impersonate any other individual or entity in connection with your use of this website or any of the SMG Online Services.',
                        style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Although we cannot and do not review all posted messages, we reserve the right to remove (or not) any message for any (or no) reason whatsoever. You remain solely responsible for the content of your messages, and you agree to indemnify and hold harmless SMG and their agents with respect to any claim based upon the transmission of your message(s) and/or posting(s).',
                  style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'We reserve the right to reveal your identity (including whatever information we know about you in the event of a complaint or legal action arising from any message posted by you.',
                  style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Posting of advertisements, chain letters, pyramid schemes, solicitations, and the like, are inappropriate and forbidden on the SMG websites and any related SMG Online Services (including bulletin boards and chat rooms).',
                  style: TextStyle(color: Colors.white, fontSize: mediumFontSize),
                ),
                // Add more terms content as needed...
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: Text(
                    'All rights reserved. Copyright © 2022 Spy-da Music Group Ltd',
                    style: TextStyle(color: Colors.white70, fontSize: verySmallFontSize),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
          if (!_hasScrolledToBottom)
            Positioned(
              bottom: screenHeight * 0.14,
              right: screenWidth * 0.05,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Icon(Icons.arrow_downward, color: Colors.white, size: screenWidth * 0.06),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: screenWidth * 0.03,
                    spreadRadius: screenWidth * 0.01,
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
                          style: TextStyle(color: Colors.white, fontSize: smallFontSize),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _acceptedTerms ? Colors.red : Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.1),
                        ),
                      ),
                      onPressed: _acceptedTerms ? _completeTerms : null,
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: buttonFontSize,
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