import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recommendations_page_model.dart';
export 'recommendations_page_model.dart';

class RecommendationsPageWidget extends StatefulWidget {
  const RecommendationsPageWidget({super.key});

  static String routeName = 'RecommendationsPage';
  static String routePath = '/recommendationsPage';

  @override
  State<RecommendationsPageWidget> createState() =>
      _RecommendationsPageWidgetState();
}

class _RecommendationsPageWidgetState extends State<RecommendationsPageWidget> {
  late RecommendationsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RecommendationsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DailyScoresRecord>>(
      stream: queryDailyScoresRecord(
        queryBuilder: (dailyScoresRecord) => dailyScoresRecord
            .where(
              'uid',
              isEqualTo: currentUserUid,
            )
            .orderBy('date', descending: true),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF0B0F1A),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<DailyScoresRecord> recommendationsPageDailyScoresRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final recommendationsPageDailyScoresRecord =
            recommendationsPageDailyScoresRecordList.isNotEmpty
                ? recommendationsPageDailyScoresRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFF0B0F1A),
            appBar: AppBar(
              backgroundColor: Color(0xFF0B0F1A),
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 54.0,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0x8DFFFFFF),
                  size: 24.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              actions: [],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 56.0, 16.0, 0.0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 30.0),
                          child: Text(
                            'Чему уделить внимание',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 40.0),
                          child: Text(
                            'Мы выделили показатели, которые сильнее всего связаны с вашим состоянием сегодня.\n\nНиже вы найдете рекомендации по каждому из показателей.',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                        ),
                        if ((recommendationsPageDailyScoresRecord
                                    ?.factor1Title ==
                                'Сон') ||
                            (recommendationsPageDailyScoresRecord
                                    ?.factor2Title ==
                                'Сон'))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 50.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (_model.expandedRecommendation == 'Сон') {
                                  _model.expandedRecommendation = '';
                                  safeSetState(() {});
                                } else {
                                  _model.expandedRecommendation = 'Сон';
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1A26),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x41000000),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x39FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 30.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/icon-sleep.png',
                                                  width: 70.0,
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Сон',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 20.0, 0.0),
                                                child: Stack(
                                                  children: [
                                                    if (_model
                                                            .expandedRecommendation !=
                                                        'Сон')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 20.0,
                                                      ),
                                                    if (_model
                                                            .expandedRecommendation ==
                                                        'Сон')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 24.0,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (_model.expandedRecommendation ==
                                          'Сон')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 20.0),
                                          child: Text(
                                            'ДНЁМ\n\n☀️ — Старайтесь выходить на дневной свет хотя бы на 20–30 минут, лучше в первой половине дня.\n\n☕ — Избегайте кофеина во второй половине дня, если замечаете, что он мешает Вам засыпать.\n\n💊 — Если Вы принимаете лекарства на постоянной основе, обсудите с врачом, могут ли они влиять на сон.\n\n😴 — Если спите днём, старайтесь делать это недолго и не слишком поздно.\n\n🏃 — Завершайте интенсивные тренировки за 2–3 часа до сна.\n\n🍽️ — Не стоит плотно ужинать и пить много жидкости прямо перед сном.\n\n\nОТДЫХ ПЕРЕД СНОМ\n\n🌙 — Создайте спокойный вечерний ритуал: книга, музыка, дневник или тёплый душ.\n\n💡 — Приглушайте освещение вечером. Это помогает организму настроиться на сон.\n\n📱 — По возможности убирайте телефон и другие экраны за 30–60 минут до сна.\n\n🛁 — Тёплая ванна или душ могут помочь расслабиться перед сном.\n\n🍷 — Алкоголь может ухудшать качество сна, даже если помогает быстрее заснуть.\n\n\nОТХОД КО СНУ\n\n🛏️ — Старайтесь ложиться и вставать примерно в одно и то же время.\n\n🌡️ — В спальне должно быть темно, тихо и прохладно.\n\n🔇 — Используйте беруши, маску для сна или белый шум, если Вам мешают свет и звуки.\n\n🕰️ — Если не получается уснуть больше 20 минут, встаньте и займитесь чем-то спокойным, пока снова не почувствуете сонливость.',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0x8DFFFFFF),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if ((recommendationsPageDailyScoresRecord
                                    ?.factor1Title ==
                                'Активность') ||
                            (recommendationsPageDailyScoresRecord
                                    ?.factor2Title ==
                                'Активность'))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 4.0, 50.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (_model.expandedRecommendation ==
                                    'Активность') {
                                  _model.expandedRecommendation = '';
                                  safeSetState(() {});
                                } else {
                                  _model.expandedRecommendation = 'Активность';
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1A26),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x41000000),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x39FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 30.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/icon-steps.png',
                                                  width: 70.0,
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Активность',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 20.0, 0.0),
                                                child: Stack(
                                                  children: [
                                                    if (_model
                                                            .expandedRecommendation !=
                                                        'Активность')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 20.0,
                                                      ),
                                                    if (_model
                                                            .expandedRecommendation ==
                                                        'Активность')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 24.0,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (_model.expandedRecommendation ==
                                          'Активность')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 20.0),
                                          child: Text(
                                            'В ТЕЧЕНИЕ ДНЯ\n\n🚶 — Добавьте короткие прогулки в течение дня, даже если это 5–10 минут.\n\n🌿 — Если есть возможность, выходите на улицу: дневной свет и движение помогают восстановить ресурс.\n\n🪜 — Используйте лестницу, короткий путь пешком или остановку чуть раньше, если это комфортно.\n\n📞 — Попробуйте ходить во время звонков или коротких разговоров.\n\n🧭 — Не стремитесь сразу к большой цели. Начните с небольшого увеличения привычного количества шагов.\n\n\nКОГДА МАЛО СИЛ\n\n🐢 — Выберите самый мягкий вариант: пройтись по комнате, выйти к подъезду или сделать короткий круг рядом с домом.\n\n🧍 — Если прогулка кажется слишком сложной, начните с того, чтобы просто встать и немного подвигаться.\n\n🫶 — Не оценивайте день только по числу шагов. Даже небольшое движение лучше, чем полное отсутствие активности.',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0x8DFFFFFF),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if ((recommendationsPageDailyScoresRecord
                                    ?.factor1Title ==
                                'Стресс') ||
                            (recommendationsPageDailyScoresRecord
                                    ?.factor2Title ==
                                'Стресс'))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 4.0, 50.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (_model.expandedRecommendation == 'Стресс') {
                                  _model.expandedRecommendation = '';
                                  safeSetState(() {});
                                } else {
                                  _model.expandedRecommendation = 'Стресс';
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1A26),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x41000000),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x39FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 30.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/icon-stress.png',
                                                  width: 70.0,
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Стресс',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 20.0, 0.0),
                                                child: Stack(
                                                  children: [
                                                    if (_model
                                                            .expandedRecommendation !=
                                                        'Стресс')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 20.0,
                                                      ),
                                                    if (_model
                                                            .expandedRecommendation ==
                                                        'Стресс')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 24.0,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (_model.expandedRecommendation ==
                                          'Стресс')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 20.0),
                                          child: Text(
                                            'БЫСТРОЕ СНИЖЕНИЕ НАПРЯЖЕНИЯ\n\n🫁 — Сделайте несколько медленных вдохов и выдохов, стараясь удлинить выдох.\n\n🧍 — Переключите внимание на тело: почувствуйте стопы, опору, положение плеч и челюсти.\n\n💧 — Выпейте воды и сделайте короткую паузу перед следующим действием.\n\n🌿 — Если возможно, выйдите на улицу или хотя бы подойдите к окну на несколько минут.\n\n📝 — Запишите, что именно сейчас вызывает напряжение. Это помогает отделить факты от тревожных мыслей.\n\n\nВ ТЕЧЕНИЕ ДНЯ\n\n📦 — Разделите большую задачу на один маленький следующий шаг.\n\n🔕 — Уберите лишние уведомления хотя бы на короткий период.\n\n⏱️ — Сделайте паузу между делами, особенно после сложных разговоров или задач.\n\n🧭 — Проверьте, что сейчас действительно срочно, а что можно перенести.\n\n🤝 — Если напряжение связано с работой или учёбой, попробуйте уточнить ожидания и приоритеты.\n\n\nВЕЧЕРОМ\n\n🌙 — Дайте нервной системе сигнал, что день заканчивается: приглушите свет, снизьте темп, уберите лишние стимулы.\n\n📓 — Запишите незавершённые дела на завтра, чтобы не удерживать их в голове.\n\n🛁 — Используйте простой ритуал восстановления: душ, спокойная музыка, тёплый напиток без кофеина.',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0x8DFFFFFF),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if ((recommendationsPageDailyScoresRecord
                                    ?.factor1Title ==
                                'Энергия') ||
                            (recommendationsPageDailyScoresRecord
                                    ?.factor2Title ==
                                'Энергия'))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 4.0, 50.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (_model.expandedRecommendation ==
                                    'Энергия') {
                                  _model.expandedRecommendation = '';
                                  safeSetState(() {});
                                } else {
                                  _model.expandedRecommendation = 'Энергия';
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1A26),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x41000000),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x39FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 30.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/icon-energy.png',
                                                  width: 70.0,
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Энергия',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 20.0, 0.0),
                                                child: Stack(
                                                  children: [
                                                    if (_model
                                                            .expandedRecommendation !=
                                                        'Энергия')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 20.0,
                                                      ),
                                                    if (_model
                                                            .expandedRecommendation ==
                                                        'Энергия')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 24.0,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (_model.expandedRecommendation ==
                                          'Энергия')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 20.0),
                                          child: Text(
                                            'ПОДДЕРЖАТЬ ЭНЕРГИЮ\n\n☀️ — Постарайтесь получить дневной свет в первой половине дня.\n\n💧 — Проверьте базовые вещи: вода, еда, сон и паузы в течение дня.\n\n🚶 — Лёгкая прогулка или разминка могут помочь мягко повысить уровень энергии.\n\n🍽️ — Не пропускайте еду, если замечаете, что из-за этого становитесь вялыми или раздражительными.\n\n🎧 — Включите музыку или другой приятный стимул, который помогает Вам собраться.\n\n\nКОГДА ЭНЕРГИИ МАЛО\n\n🐢 — Снизьте планку. Выберите одно небольшое действие вместо попытки сделать всё сразу.\n\n📌 — Определите главный минимум на день: что действительно важно сделать сегодня.\n\n🛋️ — Если тело просит отдыха, дайте себе короткую паузу без чувства вины.\n\n🫁 — Сделайте несколько спокойных вдохов и выдохов, прежде чем возвращаться к делам.\n\n🤝 — Если возможно, попросите помощи или перенесите часть задач.\n\n\nВОССТАНОВЛЕНИЕ РЕСУРСА\n\n😴 — Обратите внимание на сон: низкая энергия часто связана с недостаточным восстановлением.\n\n🌿 — Добавьте контакт с природой или спокойной средой, если есть такая возможность.\n\n🧩 — Чередуйте сложные задачи с более простыми, чтобы не расходовать ресурс слишком быстро.',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0x8DFFFFFF),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if ((recommendationsPageDailyScoresRecord
                                    ?.factor1Title ==
                                'Истощение') ||
                            (recommendationsPageDailyScoresRecord
                                    ?.factor2Title ==
                                'Истощение'))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 4.0, 50.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (_model.expandedRecommendation ==
                                    'Истощение') {
                                  _model.expandedRecommendation = '';
                                  safeSetState(() {});
                                } else {
                                  _model.expandedRecommendation = 'Истощение';
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1A26),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x41000000),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x39FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 30.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/icon-exhaust.png',
                                                  width: 70.0,
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Истощение',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 20.0, 0.0),
                                                child: Stack(
                                                  children: [
                                                    if (_model
                                                            .expandedRecommendation !=
                                                        'Истощение')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 20.0,
                                                      ),
                                                    if (_model
                                                            .expandedRecommendation ==
                                                        'Истощение')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 24.0,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (_model.expandedRecommendation ==
                                          'Истощение')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 20.0),
                                          child: Text(
                                            'СНИЗИТЬ НАГРУЗКУ\n\n🛑 — Сделайте паузу и проверьте, не пытаетесь ли Вы продолжать на пределе.\n\n📉 — Сократите список дел до самого необходимого.\n\n🧺 — Перенесите то, что не требует срочного выполнения.\n\n🤝 — Попросите о помощи, если нагрузка стала слишком высокой.\n\n🔕 — Уберите часть внешних стимулов: уведомления, лишние задачи, фоновый шум.\n\n\nВОССТАНОВЛЕНИЕ\n\n🛋️ — Запланируйте настоящий отдых, а не только смену одной задачи на другую.\n\n😴 — Дайте сну приоритет, если чувствуете длительную усталость.\n\n🌿 — Выберите спокойную активность: прогулку, растяжку, тёплый душ или тихое время без экрана.\n\n🍽️ — Поддержите тело базовыми вещами: еда, вода, сон, движение в комфортном объёме.\n\n🫶 — Не требуйте от себя максимальной продуктивности, если организм уже сигналит о перегрузке.\n\n\nЕСЛИ ИСТОЩЕНИЕ ДЕРЖИТСЯ\n\n📓 — Отследите, что чаще всего забирает силы: задачи, люди, режим, неопределённость или отсутствие отдыха.\n\n🧭 — Подумайте, какие обязательства можно пересмотреть или упростить.\n\n💬 — Если истощение сохраняется долго, стоит обсудить состояние со специалистом или врачом.',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0x8DFFFFFF),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if ((recommendationsPageDailyScoresRecord
                                    ?.factor1Title ==
                                'Связь с людьми') ||
                            (recommendationsPageDailyScoresRecord
                                    ?.factor2Title ==
                                'Связь с людьми'))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 4.0, 50.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (_model.expandedRecommendation ==
                                    'Связь с людьми') {
                                  _model.expandedRecommendation = '';
                                  safeSetState(() {});
                                } else {
                                  _model.expandedRecommendation =
                                      'Связь с людьми';
                                  safeSetState(() {});
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1A26),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x41000000),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x39FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 0.0, 30.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/icon-soc.png',
                                                  width: 70.0,
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Связь с людьми',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 20.0, 0.0),
                                                child: Stack(
                                                  children: [
                                                    if (_model
                                                            .expandedRecommendation !=
                                                        'Связь с людьми')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 20.0,
                                                      ),
                                                    if (_model
                                                            .expandedRecommendation ==
                                                        'Связь с людьми')
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            Color(0x8DFFFFFF),
                                                        size: 24.0,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (_model.expandedRecommendation ==
                                          'Связь с людьми')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 20.0),
                                          child: Text(
                                            'ПОДДЕРЖИВАТЬ КОНТАКТ\n\n💬 — Напишите человеку, с которым Вам спокойно и безопасно общаться.\n\n☕ — Договоритесь о короткой встрече, звонке или прогулке без сложной повестки.\n\n🤝 — Если есть силы, попросите поддержки прямо: «Мне сейчас важно просто поговорить».\n\n🌿 — Выбирайте не только переписки, но и живой контакт, если он Вам доступен и комфортен.\n\n📅 — Запланируйте небольшой социальный контакт заранее, чтобы не ждать подходящего момента.\n\n\nЕСЛИ ХОЧЕТСЯ ОТДАЛИТЬСЯ\n\n🫶 — Не заставляйте себя быть активной в общении, если ресурс низкий.\n\n🌙 — Выберите мягкий формат: короткое сообщение, реакция, голосовое или 10 минут разговора.\n\n🚪 — Можно оставаться на связи небольшими шагами, не включаясь в долгие разговоры.\n\n🧘 — Проверьте, Вы хотите побыть одной для восстановления или изолируетесь из-за усталости и напряжения.\n\n\nКАЧЕСТВО ОБЩЕНИЯ\n\n👂 — Выбирайте людей, после общения с которыми становится спокойнее, а не тяжелее.\n\n💛 — Делитесь не только проблемами, но и маленькими хорошими событиями дня.\n\n🧩 — Если контакт утомляет, ограничьте время общения заранее.\n\n🤍 — Связь с людьми не означает постоянную доступность. Достаточно поддерживать те контакты, которые дают ощущение опоры.',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0x8DFFFFFF),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
