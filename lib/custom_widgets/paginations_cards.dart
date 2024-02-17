import 'package:flutter/material.dart';

class PaginationCards extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  // final Function(int) onPageChange;
  final double cardSize;
  final double cardSpacing;
  // final Color activeColor; // Optional color for the active page card

  const PaginationCards({
    Key? key,
    required this.totalPages,
    required this.currentPage,
    // required this.onPageChange,
    this.cardSize = 40.0,
    this.cardSpacing = 5.0,
    // this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate start and end page numbers
    const startPage = 0;
    final endPage = totalPages;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: totalPages,
      itemBuilder: (context, index) {
        final pageNumber = startPage + index;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: cardSpacing),
          child: ElevatedButton(
            onPressed: () {}, //=> onPageChange(pageNumber),
            style: ElevatedButton.styleFrom(
              // backgroundColor: pageNumber == currentPage
              //     ? seconderyColor ?? Theme.of(context).primaryColor
              //     : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: Size(cardSize, cardSize),
            ),
            child: Text(
              pageNumber.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
