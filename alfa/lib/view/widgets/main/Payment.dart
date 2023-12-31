import 'Bootpay/bootpay.dart';
import 'Bootpay/config/bootpay_config.dart';
import 'Bootpay/model/browser_open_type.dart';
import 'Bootpay/model/extra.dart';
import 'Bootpay/model/item.dart';
import 'Bootpay/model/payload.dart';
import 'Bootpay/model/stat_item.dart';
import 'Bootpay/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../deprecated/api_provider.dart';
import 'package:alfa/provider/shared.dart';
import 'package:alfa/server/dio.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<Payment> {
  Payload payload = Payload();
  Payload payload2 = Payload();

  String webApplicationId = '653b6e9700c78a001c21b705';
  String androidApplicationId = '5b8f6a4d396fa665fdc2b5e8';
  String iosApplicationId = '5b8f6a4d396fa665fdc2b5e9';

  String get applicationId {
    return Bootpay().applicationId(
        webApplicationId, androidApplicationId, iosApplicationId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bootpayAnalyticsUserTrace(); //통계용 함수 호출
    bootpayAnalyticsPageTrace(); //통계용 함수 호출
    bootpayReqeustDataInit(); //결제용 데이터 init
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Container(
              width: 400.0,
              height: 380.0,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(
                          color: const Color.fromRGBO(217, 217, 217, 100)))),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/image/AdobeStock_618436697.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '-\t라이센스 결제는 일정 기간 동안 무제한 액세스 또는 사용 권한을 제공할 수 있습니다.\n\n-\t장기적인 라이센스로 중요한 비즈니스 프로젝트에 적합합니다.\n\n-\t업데이트 및 지원을 포함한 추가 혜택을 받을 수 있습니다.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 30,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => goBootpay2(context),
                      child: Text(
                        '라이센스 결제',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          elevation: 0,
                          backgroundColor: Colors.white.withOpacity(0),
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(182, 24, 24, 1),
                                  width: 1),
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 400.0,
              height: 380.0,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide(
                          color: const Color.fromRGBO(217, 217, 217, 100)))),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/image/macro-1452987_1280.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            '-\t1회용 결제는 한 번에 사용 가능한 기간 또는 서비스에 제한이 있을 수 있습니다\n\n-\t프로젝트 기간에 맞게 유연하게 선택할 수 있습니다.',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 30,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => goBootpay1(context),
                      child: Text(
                        '1회 결제',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          elevation: 0,
                          backgroundColor: Colors.white.withOpacity(0),
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(62, 68, 102, 1),
                                  width: 1),
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ApiProvider _provider = ApiProvider();

  //해당 기능은 혼동을 줄 수 있으므로 bio_password 사용을 대체, 그러므로 삭제
  // @deprecated
  // goBootpayPassword(BuildContext context) async {
  //   String userToken = await getUserToken(context);
  //   bootpayPasswordTest(context, userToken, generateUser());
  // }

  void bootpayPasswordTest(BuildContext context, String userToken, User user) {
    payload.userToken = userToken;
    if (kIsWeb) {
      //flutter web은 cors 이슈를 설정으로 먼저 해결해주어야 한다.
      payload.extra?.openType = 'iframe';
    }

    Bootpay().requestPassword(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel: $data');
      },
      onError: (String data) {
        print('------- onCancel: $data');
      },
      onClose: () {
        print('------- onClose');
        Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        //TODO - 원하시는 라우터로 페이지 이동
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        /**
            1. 바로 승인하고자 할 때
            return true;
         **/
        /***
            2. 비동기 승인 하고자 할 때
            checkQtyFromServer(data);
            return false;
         ***/
        /***
            3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
            return false; 후에 서버에서 결제승인 수행
         */
        // checkQtyFromServer(data);
        // return true;
        return false;
      },
      onDone: (String data) {
        print('------- onDone: $data');
      },
    );
  }

  Future<String> getUserToken(BuildContext context) async {
    String restApplicationId = "5b8f6a4d396fa665fdc2b5ea";
    String pk = "rm6EYECr6aroQVG2ntW0A6LpWnkTgP4uQ3H18sDDUYw=";
    var res = await _provider.getRestToken(restApplicationId, pk);

    res = await _provider.getEasyPayUserToken(
        res.body['access_token'], generateUser());
    print("res: ${res.body}");
    // bootpayTest(context, res.body["user_token"], user);
    return res.body["user_token"];
  }

  User generateUser() {
    var user = User();
    user.id = '123411aaaaaaaaaaaabd4ss11';
    user.gender = 1;
    user.email = 'test1234@gmail.com';
    user.phone = '01012345678';
    user.birth = '19880610';
    user.username = '홍길동';
    user.area = '서울';
    return user;
  }

  //통계용 함수
  bootpayAnalyticsUserTrace() async {
    await Bootpay().userTrace(
        id: 'user_1234',
        email: 'user1234@gmail.com',
        gender: -1,
        birth: '19941014',
        area: '서울',
        applicationId: applicationId);
  }

  //통계용 함수
  bootpayAnalyticsPageTrace() async {
    StatItem item1 = StatItem();
    item1.itemName = "1회용"; // 주문정보에 담길 상품명
    item1.unique = "ITEM_CODE_ONCE"; // 해당 상품의 고유 키
    item1.price = 150000; // 상품의 가격
    // item1.cat1 = '컴퓨터';
    // item1.cat2 = '주변기기';

    // StatItem item2 = StatItem();
    // item2.itemName = "키보드"; // 주문정보에 담길 상품명
    // item2.unique = "ITEM_CODE_KEYBOARD"; // 해당 상품의 고유 키
    // item2.price = 500; // 상품의 가격
    // item2.cat1 = '컴퓨터';
    // item2.cat2 = '주변기기';

    List<StatItem> items = [item1];

    await Bootpay().pageTrace(
        url: 'main_1234',
        pageType: 'sub_page_1234',
        applicationId: applicationId,
        userId: 'user_1234',
        items: items);
  }

  //결제용 데이터 init
  bootpayReqeustDataInit() {
    Item item1 = Item();
    item1.name = "1회용"; // 주문정보에 담길 상품명
    item1.qty = 1; // 해당 상품의 주문 수량
    item1.id = "ITEM_CODE_ONCE"; // 해당 상품의 고유 키
    item1.price = 150000; // 상품의 가격

    Item item2 = Item();
    item2.name = "라이센스"; // 주문정보에 담길 상품명
    item2.qty = 1; // 해당 상품의 주문 수량
    item2.id = "ITEM_CODE_license"; // 해당 상품의 고유 키
    item2.price = 3000000; // 상품의 가격
    List<Item> itemList1 = [item1];
    List<Item> itemList2 = [item2];

    payload.webApplicationId = webApplicationId; // web application id
    payload2.webApplicationId = webApplicationId; // web application id
    payload.androidApplicationId =
        androidApplicationId; // android application id
    payload.iosApplicationId = iosApplicationId; // ios application id

    // payload.pg = '다날';
    // payload.method = '카드';
    // payload.method = '네이버페이';
    // payload.methods = ['카드', '휴대폰', '가상계좌', '계좌이체', '카카오페이'];
    payload.orderName = "1회용 결제"; //결제할 상품명
    payload.price = 150000; //정기결제시 0 혹은 주석
    payload2.orderName = "라이센스 결제"; //결제할 상품명
    payload2.price = 3000000; //정기결제시 0 혹은 주석

    payload.orderId = DateTime.now()
        // .millisecondsSinceEpoch
        .toString(); //주문번호, 개발사에서 고유값으로 지정해야함
    payload2.orderId = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); //주문번호, 개발사에서 고유값으로 지정해야함

    payload.metadata = {
      "callbackParam1": "value12",
      "callbackParam2": "value34",
      "callbackParam3": "value56",
      "callbackParam4": "value78",
    }; // 전달할 파라미터, 결제 후 되돌려 주는 값
    payload.items = itemList1; // 상품정보 배열

    payload2.metadata = {
      "callbackParam1": "value12",
      "callbackParam2": "value34",
      "callbackParam3": "value56",
      "callbackParam4": "value78",
    }; // 전달할 파라미터, 결제 후 되돌려 주는 값
    payload2.items = itemList2; // 상품정보 배열

    // User user = User(); // 구매자 정보
    // user.id = "12341234";
    // user.username = "사용자 이름";
    // user.email = "user1234@gmail.com";
    // user.area = "서울";
    // user.phone = "010-0000-0000";
    // user.addr = 'null';

    Extra extra = Extra(); // 결제 옵션
    extra.appScheme = 'bootpayFlutter';

    if (BootpayConfig.ENV == -1) {
      payload.extra?.redirectUrl = 'https://dev-api.bootpay.co.kr/v2';
    } else if (BootpayConfig.ENV == -2) {
      payload.extra?.redirectUrl = 'https://stage-api.bootpay.co.kr/v2';
    } else {
      payload.extra?.redirectUrl = 'https://api.bootpay.co.kr/v2';
    }

    if (BootpayConfig.ENV == -1) {
      payload2.extra?.redirectUrl = 'https://dev-api.bootpay.co.kr/v2';
    } else if (BootpayConfig.ENV == -2) {
      payload2.extra?.redirectUrl = 'https://stage-api.bootpay.co.kr/v2';
    } else {
      payload2.extra?.redirectUrl = 'https://api.bootpay.co.kr/v2';
    }

    // extra.cardQuota = '3';
    // extra.openType = 'popup';

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

    // payload.user = user;
    payload.items = itemList1;
    payload.extra = extra;
    payload2.items = itemList2;
    payload2.extra = extra;
    // payload.extra?.openType = "iframe";
  }

  //버튼클릭시 부트페이 결제요청 실행
  void goBootpay1(BuildContext context) {
    if (kIsWeb) {
      //flutter web은 cors 이슈를 설정으로 먼저 해결해주어야 한다.
      payload.extra?.openType = 'iframe';
    }
    payload.extra?.browserOpenType = [
      BrowserOpenType.fromJson({"browser": "naver", "open_type": 'popup'}),
    ];

    // print('popup');
    // payload.extra?.openType = 'popup';

    payload.pg = '나이스페이';
    payload.method = "";

    payload.extra?.displayCashReceipt = false;
    // payload.extra?.escrow = true;
    // payload.extra?.locale = 'en'; //app locale
    // Bootpay().setLocale('en'); //web locale

    // payload.extra?.depositExpiration = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().add(const Duration(days: 7)));

    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel 1 : $data');
      },
      onError: (String data) {
        print('------- onError: $data');
      },
      onClose: () {
        print('------- onClose');
        Future.delayed(Duration(seconds: 0)).then((value) {
          if (mounted) {
            print('Bootpay().dismiss');
            Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
          }
        });

        // Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        //TODO - 원하시는 라우터로 페이지 이동
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        // checkQtyFromServer(data, context).then((value) => print(1243));
        // await check

        print('------- onConfirm: $data');
        print('------- Datatime: ${payload.orderId!}');

        String pay_date = payload.orderId!;
        var pay_price = payload.price!.toInt();
        print('1라이센스 pay_price : $pay_price');

        String user_id = '';
        Future<void> pay() async {
          await DataManager.saveData('payDate', pay_date);
          await DataManager.saveData2('payPrice', pay_price);
          print('2라이센스 pay_price : $pay_price');

          await DataManager.loadData('id').then((value) {
            user_id = value;
          });
        }

        pay();
        Bootpay().dismiss(context);
        return false;
      },

      onDone: (String data) {
        print('------- onDone: $data');
      },
    );
  }

  void goBootpay2(BuildContext context) {
    if (kIsWeb) {
      //flutter web은 cors 이슈를 설정으로 먼저 해결해주어야 한다.
      payload2.extra?.openType = 'iframe';
    }
    payload2.extra?.browserOpenType = [
      BrowserOpenType.fromJson({"browser": "naver", "open_type": 'popup'}),
    ];

    // print('popup');
    // payload.extra?.openType = 'popup';

    payload2.pg = '나이스페이';
    payload2.method = "";

    payload2.extra?.displayCashReceipt = false;
    // payload.extra?.escrow = true;
    // payload.extra?.locale = 'en'; //app locale
    // Bootpay().setLocale('en'); //web locale

    // payload.extra?.depositExpiration = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().add(const Duration(days: 7)));

    Bootpay().requestPayment(
      context: context,
      payload: payload2,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel 2 : $data');
      },
      onError: (String data) {
        print('------- onError: $data');
      },
      onClose: () {
        print('------- onClose');
        Future.delayed(Duration(seconds: 0)).then((value) {
          if (mounted) {
            print('Bootpay().dismiss');
            Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
          }
        });

        // Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        //TODO - 원하시는 라우터로 페이지 이동
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        print('------- onConfirm: $data');
        print('------- Datatime: ${payload.orderId!}');

        String pay_date = payload.orderId!;
        var pay_price = payload2.price!.toInt();
        print('1라이센스 pay_price : $pay_price');

        String user_id = '';
        String type = '2';
        DataManager.saveData('type', type);
        Future<void> pay() async {
          await DataManager.saveData('payDate', pay_date);
          await DataManager.saveData2('payPrice', pay_price);
          print('2라이센스 pay_price : $pay_price');

          await DataManager.loadData('id').then((value) {
            user_id = value;
          });
          await server.payDate2(user_id, type);
        }

        pay();

        Bootpay().dismiss(context);
        return false;
      },
      onDone: (String data) {
        print('------- onDone: $data');
      },
    );
  }
}
