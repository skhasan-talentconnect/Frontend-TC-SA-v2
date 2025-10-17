import 'package:flutter/material.dart';

class WriteReviewForm extends StatefulWidget {
  final Function(double rating, String text) onSubmit;

  const WriteReviewForm({super.key, required this.onSubmit});

  @override
  _WriteReviewFormState createState() => _WriteReviewFormState();
}

class _WriteReviewFormState extends State<WriteReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    // --- THEME UPDATE: Define yellow theme color ---
    final Color primaryColor = Colors.amber.shade700;

    return Container(
      // --- THEME UPDATE: Set background to white ---
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Write a Review', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const Text('Your Rating', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () => setState(() => _rating = index + 1.0),
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Share your experience...',
                border: const OutlineInputBorder(),
                // --- THEME UPDATE: Set focused border color ---
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0),
                ),
              ),
              maxLines: 5,
              validator: (value) {
                if (_rating == 0.0) {
                  return 'Please provide a star rating.';
                }
                if (value == null || value.trim().length < 10) {
                  return 'Please enter a review with at least 10 characters.';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                // --- THEME UPDATE: Set button color ---
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit(_rating, _textController.text.trim());
                  }
                },
                child: const Text('Submit Review', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}