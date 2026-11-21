class LangKeys {
  // --- Core keys ---
  static const String appName = 'app_name';
  static const String darkMode = 'dark_mode';
  static const String language = 'language';
  // Fallback copy of the under-build screen.

  // --- Tabs (copy-deck §2.0 / screen-specs §1.4) ---
  static const String tabLog = 'tab_log';
  static const String tabReview = 'tab_review';
  static const String tabSwaps = 'tab_swaps';

  // --- App bar (states §4.3 semantics, screen-specs §2.0 wordmark) ---
  // tabSemantics placeholders: {tab} + {index} — replace manually on use.
  static const String tabSemantics = 'tab_semantics';
  static const String settings = 'settings';

  // --- Owner-approved gaps (CD-06 / G-02) ---
  static const String noGoal = 'no_goal';
  static const String staleKeepAction = 'stale_keep_action';

  // --- Log (copy-deck §2.1) ---
  static const String logComposerPlaceholder = 'log_composer_placeholder';
  static const String logComposerHint = 'log_composer_hint';
  static const String logFirstRunHint = 'log_first_run_hint';
  static const String logAnalyzeCta = 'log_analyze_cta';
  static const String logCtaDisabled = 'log_cta_disabled';
  static const String logOfflineBanner = 'log_offline_banner';
  static const String logLedgerTitle = 'log_ledger_title';
  static const String logLedgerTotal = 'log_ledger_total';
  static const String logLedgerItemHint = 'log_ledger_item_hint';
  static const String logClear = 'log_clear';

  // --- Analysis & result (copy-deck §2.2) ---
  static const String analysisProgress1 = 'analysis_progress_1';
  static const String analysisProgress2 = 'analysis_progress_2';
  static const String analysisProgress3 = 'analysis_progress_3';
  static const String analysisFootnote = 'analysis_footnote';
  static const String analysisCancel = 'analysis_cancel';
  static const String resultEchoLabel = 'result_echo_label';
  static const String resultKcal = 'result_kcal';
  static const String verdict1 = 'verdict_1';
  static const String verdict2 = 'verdict_2';
  static const String verdict3 = 'verdict_3';
  static const String verdictWhy = 'verdict_why';
  static const String estimateChip = 'estimate_chip';
  static const String confidenceHigh = 'confidence_high';
  static const String confidenceMedium = 'confidence_medium';
  static const String confidenceLow = 'confidence_low';
  static const String correctionSectionTitle = 'correction_section_title';
  static const String itemAmountLabel = 'item_amount_label';
  static const String stepperSemantics = 'stepper_semantics';
  static const String unitPiece = 'unit_piece';
  static const String unitCup = 'unit_cup';
  static const String unitGram = 'unit_gram';
  static const String unitSpoon = 'unit_spoon';
  static const String editItem = 'edit_item';
  static const String removeItem = 'remove_item';
  static const String addItem = 'add_item';
  static const String lowConfidenceNote = 'low_confidence_note';
  static const String macrosRow = 'macros_row';
  static const String adviceLabel = 'advice_label';
  static const String lighterSwapCta = 'lighter_swap_cta';
  static const String editDescription = 'edit_description';
  static const String reAnalyze = 're_analyze';
  static const String saveCta = 'save_cta';
  static const String disclaimerInline = 'disclaimer_inline';

  // --- Save (copy-deck §2.3) ---
  static const String saveSnackbar = 'save_snackbar';
  static const String saveUndo = 'save_undo';
  static const String afterUndo = 'after_undo';

  // --- Review (copy-deck §2.4) ---
  static const String reviewTitleDay = 'review_title_day';
  static const String reviewTitleWeek = 'review_title_week';
  static const String segmentDay = 'segment_day';
  static const String segmentWeek = 'segment_week';
  static const String ringLabel = 'ring_label';
  static const String ringGoalSuffix = 'ring_goal_suffix';
  static const String underGoalLabel = 'under_goal_label';
  static const String overGoalLabel = 'over_goal_label';
  static const String macroProtein = 'macro_protein';
  static const String macroCarbs = 'macro_carbs';
  static const String macroFat = 'macro_fat';
  static const String macroValue = 'macro_value';
  static const String chartTitle = 'chart_title';
  static const String chartXAxis = 'chart_x_axis';
  static const String chartA11ySummary = 'chart_a11y_summary';
  static const String mealsHeader = 'meals_header';
  static const String groupYesterday = 'group_yesterday';
  static const String groupDate = 'group_date';
  static const String syncOk = 'sync_ok';
  static const String syncPending = 'sync_pending';
  static const String syncFailed = 'sync_failed';
  static const String mealRowA11y = 'meal_row_a11y';
  static const String mealTypeBreakfast = 'meal_type_breakfast';
  static const String mealTypeLunch = 'meal_type_lunch';
  static const String mealTypeDinner = 'meal_type_dinner';
  static const String mealTypeSnack = 'meal_type_snack';

  // --- Swaps (copy-deck §2.5) ---
  static const String swapsTitle = 'swaps_title';
  static const String swapsSectionHeader = 'swaps_section_header';
  static const String pairOriginal = 'pair_original';
  static const String pairAlternative = 'pair_alternative';
  static const String savingsLine = 'savings_line';
  static const String fitChip = 'fit_chip';
  static const String tryLine = 'try_line';
  static const String swapCta = 'swap_cta';
  static const String bookmarkCta = 'bookmark_cta';
  static const String swapsEstimateChip = 'swaps_estimate_chip';

  // --- Empty states (copy-deck §2.6) ---
  static const String emptyFirstRunTitle = 'empty_first_run_title';
  static const String emptyFirstRunBody = 'empty_first_run_body';
  static const String emptyFirstRunCta = 'empty_first_run_cta';
  static const String emptyNoMealsTitle = 'empty_no_meals_title';
  static const String emptyNoMealsBody = 'empty_no_meals_body';
  static const String emptyNoMealsCta = 'empty_no_meals_cta';
  static const String emptyWeekTitle = 'empty_week_title';
  static const String emptyWeekHint = 'empty_week_hint';
  static const String emptyNoSuggestionsTitle = 'empty_no_suggestions_title';
  static const String emptyNoSuggestionsBody = 'empty_no_suggestions_body';
  static const String emptyNoSuggestionsCta = 'empty_no_suggestions_cta';

  // --- Errors (copy-deck §2.7) ---
  static const String errOfflineBody = 'err_offline_body';
  static const String errOfflineAction = 'err_offline_action';
  static const String errTimeoutTitle = 'err_timeout_title';
  static const String errTimeoutBody = 'err_timeout_body';
  static const String errTimeoutActions = 'err_timeout_actions';
  static const String errRateLimitTitle = 'err_rate_limit_title';
  static const String errRateLimitBody = 'err_rate_limit_body';
  static const String errRateLimitAction = 'err_rate_limit_action';
  static const String errServerTitle = 'err_server_title';
  static const String errServerBody = 'err_server_body';
  static const String errServerActions = 'err_server_actions';
  static const String errUnrecognizableTitle = 'err_unrecognizable_title';
  static const String errUnrecognizableBody = 'err_unrecognizable_body';
  static const String errUnrecognizableAction = 'err_unrecognizable_action';
  static const String errGenericFallback = 'err_generic_fallback';

  // --- Disclaimer (copy-deck §2.8) ---
  static const String disclaimerFull = 'disclaimer_full';
  static const String disclaimerAllergen = 'disclaimer_allergen';

  // --- Copy gaps (provisional wording from states-hardening §5.3 and
  //     screen-specs §6 — pending deck-owner approval; G-03 is unused) ---
  // G-01 slow-analysis explanation (>8s in flight)
  static const String analysisSlowNote = 'analysis_slow_note';
  // G-02 stale-guard notice (text changed after analysis)
  static const String staleGuardNotice = 'stale_guard_notice';
  // G-04 description too long
  static const String logDescriptionTooLong = 'log_description_too_long';
  // G-05 Gemini language-deviation chip
  static const String resultLanguageChip = 'result_language_chip';
  // G-06 offline banner for review + swaps surfaces
  static const String offlineSavedDataBanner = 'offline_saved_data_banner';
  // G-07 "edited" chip on corrected items — placeholder: none
  static const String editedChip = 'edited_chip';
  // G-08 details expander label on collapsed result card
  static const String resultDetailsToggle = 'result_details_toggle';
  // G-09 undo snackbar after item removal — placeholder: {item} / {العنصر}
  static const String itemRemovedSnackbar = 'item_removed_snackbar';
  // G-10 meal-context banner (S09) — placeholder: {meal} / {وصف}
  static const String swapsMealContextBanner = 'swaps_meal_context_banner';
  // G-11 "view all" chip on mini ledger — placeholder: {count}
  static const String ledgerAllChip = 'ledger_all_chip';
  // G-12 quick re-log action (no Gemini call)
  static const String mealRelogCta = 'meal_relog_cta';

  // --- Onboarding ---
  static const String onboardTitle1 = 'onboard_title_1';
  static const String onboardBody1 = 'onboard_body_1';
  static const String onboardTitle2 = 'onboard_title_2';
  static const String onboardBody2 = 'onboard_body_2';
  static const String onboardTitle3 = 'onboard_title_3';
  static const String onboardBody3 = 'onboard_body_3';
  static const String onboardCta = 'onboard_cta';
  static const String onboardSkip = 'onboard_skip';

  // --- Auth ---
  static const String loginTitle = 'login_title';
  static const String emailLabel = 'email_label';
  static const String passwordLabel = 'password_label';
  static const String loginCta = 'login_cta';
  static const String loginNoAccount = 'login_no_account';
  static const String loginCreateAccount = 'login_create_account';
  static const String loginErrorInvalid = 'login_error_invalid';
  static const String nameLabel = 'name_label';
  static const String confirmPasswordLabel = 'confirm_password_label';
  static const String signupTitle = 'signup_title';
  static const String signupCta = 'signup_cta';
  static const String signupHaveAccount = 'signup_have_account';
  static const String signupLoginLink = 'signup_login_link';
  static const String validationEmail = 'validation_email';
  static const String validationPasswordShort = 'validation_password_short';
  static const String validationPasswordMatch = 'validation_password_match';
  static const String validationNameEmpty = 'validation_name_empty';
  static const String authLoading = 'auth_loading';

  // --- Settings ---
  static const String settingsDailyGoal = 'settings_daily_goal';
  static const String settingsGoalSaved = 'settings_goal_saved';
  static const String settingsAbout = 'settings_about';
  static const String settingsAboutBody = 'settings_about_body';

  // --- Review week (S07) ---
  static const String weekChartTitle = 'week_chart_title';
  static const String weekAvgLabel = 'week_avg_label';
  static const String weekTopDay = 'week_top_day';
  static const String weekBottomDay = 'week_bottom_day';
  static const String weekMacrosTitle = 'week_macros_title';
  static const String emptyWeekCtaToday = 'empty_week_cta_today';
  static const String emptyWeekCtaLog = 'empty_week_cta_log';

  // --- Splash & examples (provisional [P]) ---
  static const String splashTagline = 'splash_tagline';
  static const String exampleMeal1 = 'example_meal_1';
  static const String exampleMeal2 = 'example_meal_2';
  static const String exampleMeal3 = 'example_meal_3';
}
