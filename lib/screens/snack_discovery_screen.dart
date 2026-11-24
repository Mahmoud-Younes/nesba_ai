import 'dart:async';

import 'package:flutter/material.dart';

class SnackDiscoveryScreen extends StatefulWidget {
  const SnackDiscoveryScreen({
    this.preferenceContext = const [],
    this.isSamplePreview = false,
    super.key,
  });

  final List<String> preferenceContext;
  final bool isSamplePreview;

  @override
  State<SnackDiscoveryScreen> createState() => _SnackDiscoveryScreenState();
}

enum _DiscoveryState { input, loading, result }

class _SnackDiscoveryScreenState extends State<SnackDiscoveryScreen> {
  static const _loadingDuration = Duration(milliseconds: 700);
  static const _sampleAlternative = 'Roasted chickpeas';
  static const _sampleIngredients = <String>[
    'Chickpeas',
    'Olive oil',
    'Paprika',
  ];
  static const _samplePreparation =
      'Season the chickpeas and roast until crisp.';

  final _cravingController = TextEditingController();
  final _cravingFocusNode = FocusNode();
  Timer? _loadingTimer;
  _DiscoveryState _discoveryState = _DiscoveryState.input;
  String? _submittedCraving;

  List<String> get _availablePreferences => widget.preferenceContext
      .where((preference) => preference.trim().isNotEmpty)
      .toList(growable: false);

  bool get _canDiscover =>
      _cravingController.text.trim().isNotEmpty &&
      _discoveryState != _DiscoveryState.loading;

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _cravingController.dispose();
    _cravingFocusNode.dispose();
    super.dispose();
  }

  void _onCravingChanged(String value) {
    setState(() {
      if (_discoveryState == _DiscoveryState.result) {
        _discoveryState = _DiscoveryState.input;
        _submittedCraving = null;
      }
    });
  }

  void _discoverAlternatives() {
    if (!_canDiscover) return;

    _cravingFocusNode.unfocus();
    _loadingTimer?.cancel();
    setState(() {
      _submittedCraving = _cravingController.text;
      _discoveryState = _DiscoveryState.loading;
    });
    _loadingTimer = Timer(_loadingDuration, () {
      if (mounted) setState(() => _discoveryState = _DiscoveryState.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          key: const ValueKey('snack-discovery-scroll-view'),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'What snack are you craving?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Describe it in your own words to explore another snack idea.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCravingCard(theme),
                  if (_availablePreferences.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildPreferenceContext(theme),
                  ],
                  if (widget.isSamplePreview) ...[
                    const SizedBox(height: 12),
                    _buildSampleContextNotice(theme),
                  ],
                  const SizedBox(height: 20),
                  _buildDiscoverButton(),
                  if (_discoveryState == _DiscoveryState.loading) ...[
                    const SizedBox(height: 12),
                    _buildLoadingStatus(theme),
                  ],
                  if (_discoveryState == _DiscoveryState.result) ...[
                    const SizedBox(height: 24),
                    _buildComparison(theme),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCravingCard(ThemeData theme) {
    final colors = theme.colorScheme;

    return Material(
      key: const ValueKey('craving-input-card'),
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your craving',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const ValueKey('craving-input'),
              controller: _cravingController,
              focusNode: _cravingFocusNode,
              enabled: _discoveryState != _DiscoveryState.loading,
              minLines: 2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'For example: a chocolate bar',
                alignLabelWithHint: true,
              ),
              onChanged: _onCravingChanged,
              onSubmitted: (_) => _cravingFocusNode.unfocus(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceContext(ThemeData theme) {
    final colors = theme.colorScheme;

    return Semantics(
      key: const ValueKey('preference-context-section'),
      container: true,
      explicitChildNodes: true,
      label: 'Read-only preference context supplied to this request',
      child: Material(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Preference context',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              for (final preference in _availablePreferences)
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 4),
                  child: Text(
                    preference,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSampleContextNotice(ThemeData theme) {
    final colors = theme.colorScheme;

    return Semantics(
      container: true,
      label: 'Sample preference context shown only for this preview',
      child: Material(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Preference context is sample preview data only.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverButton() {
    final isLoading = _discoveryState == _DiscoveryState.loading;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: FilledButton(
        key: const ValueKey('discover-alternatives-button'),
        onPressed: _canDiscover ? _discoverAlternatives : null,
        child: isLoading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 12),
                  const Flexible(
                    child: Text(
                      'Preparing preview…',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : const Text('Discover alternatives'),
      ),
    );
  }

  Widget _buildLoadingStatus(ThemeData theme) {
    return Semantics(
      key: const ValueKey('discovery-loading-status'),
      container: true,
      liveRegion: true,
      label: 'Preparing an illustrative snack preview. No AI service used.',
      child: Text(
        'This is a simulated preview; no discovery service is used.',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildComparison(ThemeData theme) {
    return Semantics(
      key: const ValueKey('snack-alternative-comparison'),
      container: true,
      liveRegion: true,
      explicitChildNodes: true,
      label:
          'Illustrative snack preview. Sample content only; not AI-generated or personalized.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCravingResultCard(theme),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
            child: ExcludeSemantics(
              child: Icon(
                Icons.south,
                color: theme.colorScheme.secondary,
                size: 24,
              ),
            ),
          ),
          _buildAlternativeCard(theme),
        ],
      ),
    );
  }

  Widget _buildCravingResultCard(ThemeData theme) {
    final colors = theme.colorScheme;

    return Material(
      key: const ValueKey('your-craving-card'),
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                'Your craving',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(_submittedCraving ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativeCard(ThemeData theme) {
    final colors = theme.colorScheme;

    return Material(
      key: const ValueKey('alternative-idea-card'),
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                'Alternative idea',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Illustrative sample only',
              style: theme.textTheme.titleSmall?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Not AI-generated or personalized.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _sampleAlternative,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Example ingredients',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            for (final ingredient in _sampleIngredients)
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 4),
                child: Text('• $ingredient', style: theme.textTheme.bodyMedium),
              ),
            const SizedBox(height: 10),
            Text(
              'Example preparation',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(_samplePreparation, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
