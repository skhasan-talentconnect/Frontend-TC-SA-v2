import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart'; 
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/features/chatbot/data/entities/chatbot_question_model.dart';

class ChatbotWidgets {

  static Widget headerHint({
    required bool isLoading,
    required int selectedCount,
    required VoidCallback onClearAll,
    
  }) {
    
    return Container(
      color: SColor.backgroundColor,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ask about schools',
                    style: STextStyles.s18W600.copyWith(color: SColor.secTextColor)),
                const SizedBox(height: 4),
                Text(
                  'Pick chips in the sections below. We’ll fetch matching schools.',
                  style: STextStyles.s12W400.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
          if (isLoading) const SLoadingIndicator(size: 20),
          if (!isLoading && selectedCount > 0)
            TextButton(onPressed: onClearAll, child: const Text('Clear all')),
        ],
      ),
    );
  }

  static Widget sectionTitle({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black87),
        const SizedBox(width: 6),
        Text(
          title,
          style: STextStyles.s14W600.copyWith(color: Colors.black87),
        ),
      ],
    );
  }

static Widget questionChip({
  required ChatbotQuestion q,
  required bool selected,
  required VoidCallback onTap,
}) {
  return FilterChip(
    // ⬇️ show only the value (short label), not the full question
    label: Text(
      q.value.isNotEmpty ? q.value : q.question,
      style: STextStyles.s12W600.copyWith(
        color: selected ? Colors.white : Colors.black87,
      ),
    ),
    selected: selected,
    onSelected: (_) => onTap(),
    checkmarkColor: Colors.white,
    backgroundColor: Colors.white,
    selectedColor: SColor.primaryColor,
    shape: StadiumBorder(
      side: BorderSide(
        color: selected ? SColor.primaryColor : SColor.primaryColor.withOpacity(0.35),
      ),
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  );
}
  
  static Widget bottomBar({required Widget child}) {
    return Builder(
      builder: (context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Material(
            elevation: 8,
            color: Colors.white,
            child: SafeArea(top: false, child: child),
          ),
        );
      },
    );
  }


  static Widget inputBar({
    required TextEditingController controller,
    required String placeholder,
    required bool showClear,
    required VoidCallback onClearSelected,
    required VoidCallback onSend,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.black54, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: placeholder,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  if (showClear)
                    IconButton(
                      onPressed: onClearSelected,
                      icon: const Icon(Icons.close, size: 18, color: Colors.black54),
                      tooltip: 'Clear selected',
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: SColor.primaryColor,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: onSend,
              borderRadius: BorderRadius.circular(12),
              child: const SizedBox(
                height: 44,
                width: 52,
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
