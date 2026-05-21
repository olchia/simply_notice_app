import 'package:health/health.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'apple_health_connect_model.dart';
export 'apple_health_connect_model.dart';

class AppleHealthConnectWidget extends StatefulWidget {
  const AppleHealthConnectWidget({super.key});

  static String routeName = 'AppleHealthConnect';
  static String routePath = '/appleHealthConnect';

  @override
  State<AppleHealthConnectWidget> createState() =>
      _AppleHealthConnectWidgetState();
}

class _AppleHealthConnectWidgetState extends State<AppleHealthConnectWidget> {
  late AppleHealthConnectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppleHealthConnectModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _requestAppleHealthAccess() async {
    final health = Health();

    final types = <HealthDataType>[
      HealthDataType.STEPS,
    ];

    final permissions = <HealthDataAccess>[
      HealthDataAccess.READ,
    ];

    try {
      final granted = await health.requestAuthorization(
        types,
        permissions: permissions,
      );

      if (!mounted) {
        return;
      }

      if (granted) {
        final userInfoRecords = await queryUserInfoRecordOnce(
          queryBuilder: (userInfoRecord) => userInfoRecord.where(
            'uid',
            isEqualTo: currentUserUid,
          ),
          singleRecord: true,
        );

        final userInfoRecord =
            userInfoRecords.isNotEmpty ? userInfoRecords.first : null;

        if (userInfoRecord != null) {
          await userInfoRecord.reference.update(createUserInfoRecordData(
            appleHealthConnected: true,
          ));
        }

        if (!mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Apple Health подключён'),
          ),
        );

        context.pushNamed(MainPageWidget.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Доступ к Apple Health не предоставлен'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не удалось подключить Apple Health: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF0B0F1A),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 100.0,
                  height: 120.0,
                  decoration: BoxDecoration(),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 19.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/pngaaa.com-7762112.png',
                        width: 160.0,
                        fit: BoxFit.cover,
                        alignment: Alignment(0.0, 0.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Text(
                    'Подключите Apple Здоровье',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontStyle,
                          ),
                          color: Color(0xFFF0F1FB),
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 120.0),
                    child: Text(
                      'Чем больше сигналов — тем раньше мы заметим изменения. Ты можешь включить только часть и изменить это в любой момент.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.roboto(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: Color(0xFF6E7C89),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 15.0),
                  child: Container(
                    width: double.infinity,
                    height: 44.0,
                    child: custom_widgets.ConnectButton(
                      width: double.infinity,
                      height: 44.0,
                      label: 'Подключить',
                      successLabel: 'Подключено',
                      loadingDurationMs: 1800,
                      onTap: () async {
                        await _requestAppleHealthAccess();
                      },
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(MainPageWidget.routeName);
                  },
                  child: Text(
                    'Пропустить',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: Color(0xFF6E7C89),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}