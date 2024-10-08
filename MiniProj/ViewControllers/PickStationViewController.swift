//
//  PickStationViewController.swift
//  MiniProj
//
//  Created by jhshin on 9/15/24.
//

import UIKit

class PickStationViewController: UIViewController {
    let lines = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선", "9호선", "GTX-A", "경의중앙선", "공항철도", "경춘선", "수인분당선", "신분당선", "경강선", "우이신설선", "서해선", "신림선" ]
    let stationsForLines = [
        "1호선": ["소요산", "동두천", "보산", "동두천중앙", "지행", "덕정", "덕계", "양주", "녹양", "가능", "의정부", "회룡", "망월사", "도봉산", "도봉", "방학", "창동", "녹천", "월계", "광운대", "석계", "신이문", "외대앞", "회기", "청량리", "제기동", "신설동", "동묘앞", "동대문", "종로5가", "종로3가", "종각", "시청", "서울", "남영", "용산", "노량진", "대방", "신길", "영등포", "신도림", "구로", "구일", "개봉", "오류동", "온수", "역곡", "소사", "부천", "중동", "송내", "부개", "부평", "백운", "동암", "간석", "주안", "도화", "제물포", "도원", "동인천", "인천", "청산", "전곡", "연천", "광명", "가산디지털단지", "독산", "금천구청", "석수", "관악", "안양", "명학", "금정", "군포", "당정", "의왕", "성균관대", "화서", "수원", "세류", "병점", "세마", "오산대", "오산", "진위", "송탄", "서정리", "지제", "평택", "성환", "직산", "두정", "천안", "봉명", "쌍용(나사렛대)", "아산", "탕정", "배방", "온양온천", "신창", "서동탄"],
         "2호선": ["시청", "을지로입구", "을지로3가", "을지로4가", "동대문역사문화공원", "신당", "상왕십리", "왕십리", "한양대", "뚝섬", "성수", "건대입구", "구의", "강변", "잠실나루", "잠실", "잠실새내", "종합운동장", "삼성", "선릉", "역삼", "강남", "교대", "서초", "방배", "사당", "낙성대", "서울대입구", "봉천", "신림", "신대방", "구로디지털단지", "대림", "신도림", "문래", "영등포구청", "당산", "합정", "홍대입구", "신촌", "이대", "아현", "충정로", "용답", "신답", "용두", "신설동", "도림천", "양천구청", "신정네거리", "까치산"],
         "3호선": ["대화", "주엽", "정발산", "마두", "백석", "대곡", "화정", "원당", "원흥", "삼송", "지축", "구파발", "연신내", "불광", "녹번", "홍제", "무악재", "독립문", "경복궁", "안국", "종로3가", "을지로3가", "충무로", "동대입구", "약수", "금호", "옥수", "압구정", "신사", "잠원", "고속터미널", "교대", "남부터미널", "양재", "매봉", "도곡", "대치", "학여울", "대청", "일원", "수서", "가락시장", "경찰병원", "오금"],
         "4호선": ["당고개", "상계", "노원", "창동", "쌍문", "수유", "미아", "미아사거리", "길음", "성신여대입구", "한성대입구", "혜화", "동대문", "동대문역사문화공원", "충무로", "명동", "회현", "서울", "숙대입구", "삼각지", "신용산", "이촌", "동작", "총신대입구(이수)", "사당", "남태령", "선바위", "경마공원", "대공원", "과천", "정부과천청사", "인덕원", "평촌", "범계", "금정", "산본", "수리산", "대야미", "반월", "상록수", "한대앞", "중앙", "고잔", "초지", "안산", "신길온천", "정왕", "오이도"],
        "5호선": ["방화", "개화산", "김포공항", "송정", "마곡", "발산", "우장산", "화곡", "까치산", "신정(은행정)", "목동", "오목교(목동운동장앞)", "양평", "영등포구청", "영등포시장", "신길", "여의도", "여의나루", "마포", "공덕", "애오개", "충정로", "서대문", "광화문", "종로3가", "을지로4가", "동대문역사문화공원", "청구", "신금호", "행당", "왕십리", "마장", "답십리", "장한평", "군자(능동)", "아차산(어린이대공원후문)", "광나루(장신대)", "천호(풍납토성)", "강동", "길동", "굽은다리(강동구민회관앞)", "명일", "고덕", "상일동", "강일", "미사", "하남풍산", "하남시청", "하남검단산", "둔촌동", "올림픽공원(한국체대)", "방이", "오금", "개롱", "거여", "마천"],
        "6호선": ["응암순환(상선)", "역촌", "불광", "독바위", "연신내", "구산", "새절(신사)", "증산(명지대앞)", "디지털미디어시티", "월드컵경기장(성산)", "마포구청", "망원", "합정", "상수", "광흥창", "대흥(서강대앞)", "공덕", "효창공원앞", "삼각지", "녹사평", "이태원", "한강진", "버티고개", "약수", "청구", "신당", "동묘앞", "창신", "보문", "안암(고대병원앞)", "고려대", "월곡(동덕여대)", "상월곡(한국과학기술연구원)", "돌곶이", "석계", "태릉입구", "화랑대(서울여대입구)", "봉화산", "신내"],
        "7호선": ["장암", "도봉산", "수락산", "마들", "노원", "중계", "하계", "공릉(서울산업대입구)", "태릉입구", "먹골", "중화", "상봉", "면목", "사가정", "용마산", "중곡", "군자(능동)", "어린이대공원(세종대)", "건대입구", "뚝섬유원지", "청담", "강남구청", "학동", "논현", "반포", "고속터미널", "내방", "총신대입구(이수)", "남성", "숭실대입구(살피재)", "상도(중앙대앞)", "장승배기", "신대방삼거리", "보라매", "신풍", "대림", "남구로", "가산디지털단지", "철산", "광명사거리", "천왕", "온수", "까치울", "부천종합운동장", "춘의", "신중동", "부천시청", "상동", "삼산체육관", "굴포천", "부평구청", "산곡", "석남"],
        "8호선": ["별내", "다산", "동구릉", "구리", "장자호수공원", "암사역사공원", "암사", "천호(풍납토성)", "강동구청", "몽촌토성(평화의문)", "잠실", "석촌", "송파", "가락시장", "문정", "장지", "복정", "남위례", "산성", "남한산성입구(성남법원,검찰청)", "단대오거리", "신흥", "수진", "모란"],
        "9호선": ["개화", "김포공항", "공항시장", "신방화", "마곡나루", "양천향교", "가양", "증미", "등촌", "염창", "신목동", "선유도", "당산", "국회의사당", "여의도", "샛강", "노량진", "노들", "흑석", "동작", "구반포", "신반포", "고속터미널", "사평", "신논현", "언주", "선정릉", "삼성중앙", "봉은사", "종합운동장", "삼전", "석촌고분", "석촌", "송파나루", "한성백제", "올림픽공원", "둔촌오륜", "중앙보훈병원"],
        "GTX-A": ["수서", "성남", "구성", "동탄"],
        "경의중앙선": ["용산", "이촌", "서빙고", "한남", "옥수", "응봉", "왕십리", "청량리", "회기", "중랑", "상봉", "망우", "양원", "구리", "도농", "양정", "덕소", "도심", "팔당", "운길산", "양수", "신원", "국수", "아신", "오빈", "양평", "원덕", "용문", "지평", "공덕", "서강대", "홍대입구", "가좌", "디지털미디어시티", "수색", "한국항공대", "강매", "행신", "능곡", "대곡", "곡산", "백마", "풍산", "일산", "탄현", "야당", "운정", "금릉", "금촌", "월롱", "파주", "문산", "운천", "임진강", "효창공원앞", "신촌(경의중앙선)", "서울"],
        "공항철도": ["서울", "공덕", "홍대입구", "디지털미디어시티", "김포공항", "계양", "검암", "운서", "공항화물청사", "인천공항1터미널", "인천공항2터미널", "마곡나루", "청라국제도시", "영종"],
        "경춘선": ["청량리", "회기", "중랑", "광운대", "상봉", "망우", "신내", "갈매", "별내", "퇴계원", "사릉", "금곡", "평내호평", "천마산", "마석", "대성리", "청평", "상천", "가평", "굴봉산", "백양리", "강촌", "김유정", "남춘천", "춘천"],
        "수인분당선": ["청량리", "왕십리", "서울숲", "압구정로데오", "강남구청", "선정릉", "선릉", "한티", "도곡", "구룡", "개포동", "대모산입구", "수서", "복정", "가천대", "태평", "모란", "야탑", "이매", "서현", "수내", "정자", "미금", "오리", "죽전", "보정", "구성", "신갈", "기흥", "상갈", "청명", "영통", "망포", "매탄권선", "수원시청", "매교", "수원", "고색", "오목천", "어천", "야목", "사리", "한대앞", "중앙", "고잔", "초지", "안산", "신길온천", "정왕", "오이도", "달월", "월곶", "소래포구", "인천논현", "호구포", "남동인더스파크", "원인재", "연수", "송도", "인하대", "숭의", "신포", "인천"],
        "신분당선": ["신사", "논현", "신논현", "강남", "양재", "양재시민의숲", "청계산입구", "판교", "정자", "미금", "동천", "수지구청", "성복", "상현", "광교중앙", "광교"],
        "경강선": ["판교", "성남", "이매", "삼동", "경기광주", "초월", "곤지암", "신둔도예촌", "이천", "부발", "세종왕릉", "여주"],
        "우이신설선": ["북한산우이", "솔밭공원", "4.19 민주묘지", "가오리", "화계", "삼양", "삼양사거리", "솔샘", "북한산보국문", "정릉", "성신여대입구", "보문", "신설동"],
        "서해선": ["일산", "풍산", "백마", "곡산", "대곡", "능곡", "김포공항", "원종", "부천종합운동장", "소사", "소새울", "시흥대야", "신천", "신현", "시흥시청", "시흥능곡", "달미", "선부", "초지", "시우", "원시"],
        "신림선": ["샛강", "대방", "서울지방병무청", "보라매", "보라매공원", "보라매병원", "당곡", "신림", "서원", "서울대벤처타운", "관악산"]
    ]
    var stations: [String] = []
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        pickerView.delegate = self
        pickerView.dataSource = self
        stations = stationsForLines[lines[0]] ?? []
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC = segue.destination as? SubwayViewController
        guard let newVC = newVC else { return }
        var selectedStation = stations[pickerView.selectedRow(inComponent: 1)]
        
        newVC.strStation = selectedStation
        
    }
    

}
extension PickStationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? lines.count : stations.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return lines[row]
        } else {
            return stations[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            // 0번 컴포넌트의 선택에 따라 1번 컴포넌트의 데이터 업데이트
            let selectedLine = lines[row]
            stations = stationsForLines[selectedLine] ?? []
            
            // 1번 컴포넌트 리로드
            pickerView.reloadComponent(1)
            
            // 1번 컴포넌트의 첫 번째 항목으로 선택을 이동
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        component == 0 ? 150 : 200
    }
}
