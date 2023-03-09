import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_model.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_modal_model.dart';
export 'payment_modal_model.dart';

class PaymentModalWidget extends StatefulWidget {
  const PaymentModalWidget({
    Key? key,
    this.paymentRef,
  }) : super(key: key);

  final double? paymentRef;

  @override
  _PaymentModalWidgetState createState() => _PaymentModalWidgetState();
}

class _PaymentModalWidgetState extends State<PaymentModalWidget> {
  late PaymentModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentModalModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).customColor1,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Pay Early',
                      style: FlutterFlowTheme.of(context).title2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Fill out your information in order to pay early.',
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text(
                  'Your Payment',
                  style: FlutterFlowTheme.of(context).bodyText2,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Text(
                  formatNumber(
                    43343,
                    formatType: FormatType.decimal,
                    decimalType: DecimalType.automatic,
                    currency: '\$',
                  ),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Lexend Deca',
                    color: FlutterFlowTheme.of(context).dark400,
                    fontWeight: FontWeight.w100,
                    fontSize: 56,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 24),
                child: Text(
                  'Due Sep 1, 2021',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).grayDark,
                      ),
                ),
              ),
              Divider(
                height: 4,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
              //   child: FlutterFlowCreditCardForm(
              //     formKey: _model.creditCardFormKey,
              //     creditCardModel: _model.creditCardInfo,
              //     obscureNumber: true,
              //     obscureCvv: false,
              //     spacing: 10,
              //     textStyle: FlutterFlowTheme.of(context).bodyText1,
              //     inputDecoration: InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: FlutterFlowTheme.of(context).grayLighter,
              //           width: 2,
              //         ),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: FlutterFlowTheme.of(context).grayLighter,
              //           width: 2,
              //         ),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 40),
                child: FFButtonWidget(
                  onPressed: () async {
                    // final paymentsCreateData = createPaymentsRecordData(
                    //   paymentUser: currentUserReference,
                    //   paymentProduct: currentUserDocument!.product,
                    //   paymentDate: getCurrentTimestamp,
                    //   paymentStatus: 'Complete',
                    //   paymentAmount: widget.paymentRef,
                    // );
                    // await PaymentsRecord.collection
                    //     .doc()
                    //     .set(paymentsCreateData);
                    // await Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     type: PageTransitionType.bottomToTop,
                    //     duration: Duration(milliseconds: 250),
                    //     reverseDuration: Duration(milliseconds: 250),
                    //     child: PaymentCompleteWidget(),
                    //   ),
                    // );
                  },
                  text: 'Pay Now',
                  options: FFButtonOptions(
                    width: 300,
                    height: 50,
                    color: FlutterFlowTheme.of(context).secondaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
