import 'package:flutter/material.dart';

Widget consent() {
  return Builder(builder: (context) {
    return Container(
      width: 400,
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  iconSize: 18,
                ),
              ],
            ),
            mintext(
                '개인정보보호법에 따라 알파에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.'),
            SizedBox(
              height: 10,
            ),
            mintext(
                '1. 수집하는 개인정보\n이용자는 회원 가입을 해야 알파 서비스를 이용할 수 있습니다. 이용자가 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 알파는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.\n회원가입 시점에 알파가 이용자로부터 수집하는 개인정보는 아래와 같습니다.'),
            SizedBox(
              height: 10,
            ),
            mintext(
                '2. 수집한 개인정보의 이용\n알파 및 알파 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발・제공 및 향상 등 아래의 목적으로만 개인정보를 이용합니다.'),
            SizedBox(
              height: 10,
            ),
            mintext(
                '- 회원 가입 의사의 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.'),
            mintext('- 유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제를 위하여 개인정보를 이용합니다.'),
            mintext(
                '- 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.'),
            mintext(
                '- 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.'),
            SizedBox(
              height: 10,
            ),
            mintext(
                '3. 개인정보의 보관기간\n회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.\n단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.\n이용자에게 개인정보 보관기간에 대해 회원가입 시 또는 서비스 가입 시 동의를 얻은 경우는 아래와 같습니다.'),
            mintext(
                '- 전자상거래 등에서 소비자 보호에 관한 법률\n계약 또는 청약철회 등에 관한 기록: 5년 보관\n대금결제 및 재화 등의 공급에 관한 기록: 5년 보관\n소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관'),
            mintext('- 전자문서 및 전자거래 기본법\n공인전자주소를 통한 전자문서 유통에 관한 기록 : 10년 보관'),
            mintext(
                '- 통신비밀보호법\n로그인 기록: 3개월\n참고로 네이버는 ‘개인정보 유효기간제’에 따라 1년간 서비스를 이용하지 않은 회원의 개인정보를 별도로 분리 보관하여 관리하고 있습니다.'),
            SizedBox(
              height: 10,
            ),
            mintext(
                '4. 개인정보 수집 및 이용 동의를 거부할 권리\n이용자는 개인정보의 수집 및 이용 동의를 거부할 권리가 있습니다. 회원가입 시 수집하는 최소한의 개인정보, 즉, 필수 항목에 대한 수집 및 이용 동의를 거부하실 경우, 회원가입이 어려울 수 있습니다.'),
          ],
        ),
      ),
    );
  });
}

Widget mintext(String tt) {
  return Text(
    tt,
    style: TextStyle(fontSize: 14),
  );
}
