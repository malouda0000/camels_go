import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PrivcyPolicyScreen extends StatefulWidget {
  const PrivcyPolicyScreen({super.key});

  @override
  State<PrivcyPolicyScreen> createState() => _PrivcyPolicyScreenState();
}

class _PrivcyPolicyScreenState extends State<PrivcyPolicyScreen> {
  late PdfControllerPinch pdfControllerPinch;

  int totalPageCount = 0, currentPage = 1;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset("assets/pdf/sld_privecy.pdf"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.privacy_policy,
        ),
        // backgroundColor: AppColors.mainColor,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Total Pages: ${totalPageCount}"),
              IconButton(
                onPressed: () {
                  pdfControllerPinch.previousPage(
                    duration: Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.linear,
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
              Text("Current Page: ${currentPage}"),
              IconButton(
                onPressed: () {
                  pdfControllerPinch.nextPage(
                    duration: Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.linear,
                  );
                },
                icon: Icon(
                  Icons.arrow_forward,
                ),
              ),
            ],
          ),
          _pdfView(),
        ],
      ),
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        scrollDirection: Axis.vertical,
        controller: pdfControllerPinch,
        onDocumentLoaded: (doc) {
          setState(() {
            totalPageCount = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}
