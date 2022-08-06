import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        title: const Text("약나와"),
        centerTitle: true,
        actions: const [
          IconButton(icon: Icon(Icons.camera), onPressed: null),
          IconButton(icon: Icon(Icons.search), onPressed: null),
        ],
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            title: Text("Favorites"),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            title: Text("List"),
            icon: Icon(Icons.list),
          ),
        ],
      ),
      body: Column(
        children: [
          // 제품 이미지 프레임
          Container(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),

          // 제품명, 회사명, 인증현황
          Container(
            color: Colors.blue[400],
            child: Column(
              children: [
                // 제품명
                const Text('고려은단 비타민C 1000 + 비타민D'),
                // 회사명
                const Text('고려은단 헬스케어(주)'),
                // 인증현황
                const Text('인증현황'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.account_balance_outlined),
                    const Icon(Icons.ac_unit),
                  ],
                )
              ],
            ),
          ),

          // 기능성
          Container(
            color: Colors.pink[50],
            child: Column(
              children: [
                const Text('기능성'),
                const Text('1. 결합조직 형성과 기능유지에 필요'),
                const Text('2. 철의 흡수에 필요'),
                const Text('3. 유해산소로부터 세포를 보호하는데 필요'),
              ],
            ),
          ),

          // 함량 정보
          Container(
            color: Colors.yellow[50],
            child: Column(
              children: [
                const Text('함량 정보'),
                const Text('탄수화물 1g'),
                const Text('비타민C 1,000mg'),
              ],
            ),
          ),

          // 타 제품 추천
          Container(
            color: Colors.yellow[50],
            child: Column(
              children: [
                const Text('이런 제품은 어떤가요?'),
                Row(
                  children: [
                    const Text('(대웅제약) 대웅 비타C'),
                    const Text('erom 이롬 착한비타민 C'),
                  ],
                )
              ],
            ),
          ),

          // 구매하기 버튼
          ElevatedButton(onPressed: null, child: const Text("구매하러 가기"))
        ],
      ),
    ));
  }

  final List _widgetOptions = [
    const Text("Favorites",
        style: TextStyle(
          fontSize: 30,
          fontFamily: "DoHyeonRegular",
        )),
    const Text("List",
        style: TextStyle(
          fontSize: 30,
          fontFamily: "DoHyeonRegular",
        )),
  ];
}
