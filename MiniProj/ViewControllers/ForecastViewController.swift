//
//  ForecastViewController.swift
//  MiniProj
//
//  Created by jhshin on 9/15/24.
//

import UIKit

class ForecastViewController: UIViewController {
    let APIKey = Bundle.main.infoDictionary?["APIKey"] as! String
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTemp: UILabel!
    
    var strGU: String = ""
    var coordinate: String = ""
    var timeBasedData: [String: [String: Any]] = [:]
    var sortedTimes: [String] = []
    
    let dateFormatter = DateFormatter()
    let nowDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "서울시 \(strGU)의 날씨"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 125
        search()
    }
    
    func currentTemp() {
        dateFormatter.dateFormat = "HH00"
        //let currentTime = dateFormatter.string(from: nowDate)
        let currentTime = "1100"
        let currentData = timeBasedData[currentTime]
        if let temp = currentData?["TMP"] {
            lblTemp.text = "\(temp)" + "°C"
        } else {lblTemp.text = "현재 기온 정보 없음."}
    }
    
    func search() {
        dateFormatter.dateFormat = "yyyyMMdd"
        //let convertNowStr = dateFormatter.string(from: nowDate)
        let convertNowStr = "20240915"
        let nx = coordinate.split(separator: "/")[0]
        let ny = coordinate.split(separator: "/")[1]
        
        guard let url = URL(string: "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=\(APIKey)&numOfRows=100&pageNo=1&dataType=JSON&base_date=\(convertNowStr)&base_time=0800&nx=\(nx)&ny=\(ny)") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error {
                print("task error: \(error)")
                return
            }
            guard let data else {return}
            do {
                guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { print("root 오류"); return }
                guard let resp = root["response"] as? [String : Any] else {print("resp 오류");return}
                guard let body = resp["body"] as? [String: Any] else { print("body 오류");return }
                guard let itemsContainer = body["items"] as? [String: Any] else { print("itemsContainer 오류");return }
                guard let items = itemsContainer["item"] as? [[String: Any]] else { print("items 오류");return }
                
                let categoriesToFilter = ["TMP", "SKY", "POP", "PTY", "REH"]
                for item in items {
                    guard let category = item["category"] as? String,
                          let fcstTime = item["fcstTime"] as? String,
                          let fcstValue = item["fcstValue"] as? String else {print("baseDate, fcstTime 또는 fcstValue 중 하나가 없음");return}
                    if categoriesToFilter.contains(category) {
                        if self.timeBasedData[fcstTime] == nil {
                            self.timeBasedData[fcstTime] = [:]
                        }
                        
                        self.timeBasedData[fcstTime]?[category] = fcstValue
                    }
                }
                self.sortedTimes = self.timeBasedData.keys.sorted()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.currentTemp()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //var config = cell.defaultContentConfiguration()

        let time = sortedTimes[indexPath.row]
        let data = timeBasedData[time] ?? [:]

        // TMP - 현재 기온
        let temperature = data["TMP"] as? String ?? "N/A"
        
        let imageView = cell.viewWithTag(5) as? UIImageView
        var sysImageName = ""
        // SKY - 하늘 상태
        let skyCode = data["SKY"] as? String
        let skyDescription: String
        switch skyCode {
        case "1":
            skyDescription = "맑음"
            sysImageName = "sun.max.fill"
            imageView?.tintColor = .yellow
        case "3":
            skyDescription = "구름많음"
            sysImageName = "smoke.fill"
            imageView?.tintColor = .gray
        case "4":
            skyDescription = "흐림"
            sysImageName = "cloud.fill"
            imageView?.tintColor = .gray
        default:
            skyDescription = "N/A"

        }
        
        // POP - 강수확률
        let precipitationProbability = data["POP"] as? String ?? "N/A"
        
        // PTY - 강수형태
        let ptyCode = data["PTY"] as? String
        let precipitationType: String
        if ptyCode == "1" || ptyCode == "5" {
            precipitationType = "비"
        } else {
            precipitationType = "없음"
        }
        
        // REH (습도)
        let humidity = data["REH"] as? String ?? "N/A"
        // 셀에 시간대 및 각 데이터를 표시
        //config.text = "\(time.prefix(2))"
        let timeLbl = cell.viewWithTag(1) as? UILabel
        timeLbl?.text = "\(time.prefix(2)):00"
        let skyLbl = cell.viewWithTag(2) as? UILabel
        skyLbl?.text = "하늘 : \(skyDescription)"
        let tmpLbl = cell.viewWithTag(3) as? UILabel
        tmpLbl?.text = "기온 : \(temperature)°C"
        let proLbl = cell.viewWithTag(4) as? UILabel
        proLbl?.text = "강수확률 : \(precipitationProbability)%"
        imageView?.image = UIImage(systemName: sysImageName)
        return cell
    }
}
