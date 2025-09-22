
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/common/widgets/s_app_bar.dart';
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/extensions/failure_ext.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/chatbot/data/entities/chatbot_question_model.dart';
import 'package:tc_sa/features/chatbot/presentation/view_models/chatbot_view_model.dart';
import 'package:tc_sa/features/chatbot/presentation/widgets/chatbot_widgets.dart';

class ChatbotView extends StatefulWidget {
  const ChatbotView({super.key});

  @override
  State<ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<ChatbotView> {
  final ChatbotViewModel vm = ChatbotViewModel();
  final TextEditingController _inputController = TextEditingController();
  final List<ChatbotQuestion> _selected = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => vm.loadQuestions());
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _toggleSelect(ChatbotQuestion q) {
    setState(() {
      final alreadySelected = _selected.any((e) => e.id == q.id);
      if (alreadySelected) {
        _selected.removeWhere((e) => e.id == q.id);
      } else {
        _selected.removeWhere((e) => e.field == q.field);
        _selected.add(q);
      }
      _inputController.text =
          _selected.isEmpty ? '' : _selected.map((e) => e.question).join(' + ');
    });
  }

  Future<void> _onSend(BuildContext context) async {
    if (_selected.isEmpty) {
      final txt = _inputController.text.trim();
      if (txt.isNotEmpty) {
        final found = vm.questions.firstWhere(
          (qq) => qq.question.toLowerCase() == txt.toLowerCase(),
          orElse: () => ChatbotQuestion(id: 0, question: '', field: '', value: ''),
        );
        if (found.id != 0) {
          _selected.removeWhere((e) => e.field == found.field);
          _selected.add(found);
        }
      }
    }

    if (_selected.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one predefined question.'),
        ),
      );
      return;
    }

    Failure? failure;
    if (_selected.length == 1) {
      failure = await vm.applyFilters(questionId: _selected.first.id);
    } else {
      final Map<String, dynamic> filters = {};
      for (final q in _selected) {
        filters[q.field] = q.value;
      }
      failure = await vm.applyFilters(filters: filters);
    }
    
    if (failure != null) {
      if (!mounted) return;
      failure.showError(context);
    }
    
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Map<String, List<ChatbotQuestion>> _groupByField(List<ChatbotQuestion> items) {
    final map = <String, List<ChatbotQuestion>>{};
    for (final q in items) {
      map.putIfAbsent(q.field, () => <ChatbotQuestion>[]).add(q);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<ChatbotViewModel>(
        builder: (context, vm, _) {
          final isPageLoading = vm.viewState == ViewState.busy;
          final grouped = _groupByField(vm.questions);
          final sections = <_SectionDef>[
            _SectionDef(title: 'Schools with fee range:', field: 'feeRange', icon: Icons.payments_outlined),
            _SectionDef(title: 'Schools with board:', field: 'board', icon: Icons.menu_book_outlined),
            _SectionDef(title: 'Schools with type:', field: 'schoolMode', icon: Icons.school_outlined),
            _SectionDef(title: 'Schools with gender:', field: 'genderType', icon: Icons.people_outline),
            _SectionDef(title: 'Schools with transport:', field: 'transportAvailable', icon: Icons.directions_bus_outlined),
             _SectionDef(title: 'Schools in my area inly', field: 'area', icon: Icons.location_city),
              _SectionDef(title: 'Schools in my city only', field: 'city', icon: Icons.location_city),
            _SectionDef(title: 'Schools with rank:', field: 'rank', icon: Icons.emoji_events_outlined),
          ];

          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: SAppBar(
              title: 'Chatbot',
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            body: Column(
              children: [
                ChatbotWidgets.headerHint(
                  isLoading: isPageLoading,
                  selectedCount: _selected.length,
                  onClearAll: () {
                    setState(() {
                      _selected.clear();
                      _inputController.clear();
                      vm.clear();
                    });
                  },
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    children: [
                      if (isPageLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SLoadingIndicator(size: 24),
                          ),
                        )
                      else if (vm.questions.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'No suggestions available.',
                            style: STextStyles.s12W400.copyWith(color: Colors.black45),
                          ),
                        )
                      else ...[
                        for (final sec in sections)
                          if ((grouped[sec.field] ?? const []).isNotEmpty) ...[
                            ChatbotWidgets.sectionTitle(
                              icon: sec.icon,
                              title: sec.title,
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  (grouped[sec.field]!).map((q) => ChatbotWidgets.questionChip(
                                      q: q,
                                      selected: _selected.any((e) => e.id == q.id),
                                      onTap: () => _toggleSelect(q),
                                    )).toList(),
                            ),
                            const SizedBox(height: 16),
                          ],
                        const Divider(height: 24),

                        // AI Response Section
                        if (vm.recommendedSchoolNames.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline,
                                    color: SColor.primaryColor,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'AI Recommendations',
                                    style: STextStyles.s20W600.copyWith(color: SColor.secTextColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: SColor.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: vm.recommendedSchoolNames.map((line) => Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("• ", style: TextStyle(fontSize: 18)),
                                      Expanded(
                                        child: Text(
                                          line,
                                          style: STextStyles.s14W600.copyWith(color: Colors.blue),
                                          
                                        ),
                                      ),
                                    ],
                                  )).toList(),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),

                        // Database Filtered Results Section
                        if (vm.resolvedSchools.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Filtered Schools (${vm.resolvedSchools.length})',
                                style: STextStyles.s16W600.copyWith(color: SColor.secTextColor),
                              ),
                              const SizedBox(height: 12),
                              ListView.separated(
                                itemBuilder: (context, index) {
                                  final school = vm.resolvedSchools[index];
                                  return SchoolCard(school: school);
                                },
                                separatorBuilder: (context, index) => const SizedBox(height: 16),
                                itemCount: vm.resolvedSchools.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ],
                          ),

                        // Empty State
                        if (vm.resolvedSchools.isEmpty && vm.recommendedSchoolNames.isEmpty && !isPageLoading)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32.0),
                            child: Center(
                              child: Text(
                                'No results to show.\nSelect questions and press Send.',
                                textAlign: TextAlign.center,
                                style: STextStyles.s14W400.copyWith(color: Colors.black54),
                              ),
                            ),
                          ),
                        const SizedBox(height: 90),
                      ],
                    ],
                  ),
                ),
                ChatbotWidgets.bottomBar(
                  child: ChatbotWidgets.inputBar(
                    controller: _inputController,
                    placeholder: _selected.isEmpty
                        ? 'Select one or more predefined questions…'
                        : _selected.map((e) => e.question).join(' + '),
                    showClear: _selected.isNotEmpty,
                    onClearSelected: () {
                      setState(() {
                        _selected.clear();
                        _inputController.clear();
                        vm.clear();
                      });
                    },
                    onSend: () => _onSend(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionDef {
  final String title;
  final String field;
  final IconData icon;
  _SectionDef({required this.title, required this.field, required this.icon});
}