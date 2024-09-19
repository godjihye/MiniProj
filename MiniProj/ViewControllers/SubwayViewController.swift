//
//  SubwayViewController.swift
//  MiniProj
//
//  Created by jhshin on 9/15/24.
//

import UIKit

class SubwayViewController: UIViewController {
    let APIKey = Bundle.main.infoDictionary?["APIKey_subway"] as! String
    var strStation = ""
    var trainListUp: [[String:String?]] = [[String:String?]]()
    var trainListDn: [[String:String?]] = [[String:String?]]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblUpdate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(strStation)역의 실시간 도착 정보"
        tableView.dataSource = self
        tableView.delegate = self
        search(station: strStation)
    }
    func search(station: String) {
        trainListUp.removeAll()
        trainListDn.removeAll()
        let dateFormatter = DateFormatter()
        let nowDate = Date()
        dateFormatter.dateFormat = "HH:mm:ss"
        lblUpdate.text = "updated at: \(dateFormatter.string(from: nowDate))"
        guard let url = URL(string: "http://swopenapi.seoul.go.kr/api/subway/\(APIKey)/json/realtimeStationArrival/0/10/\(station)")
        else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error {
                print(error)
                return
            }
            guard let data else {return}
            do {
                guard let root = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { print("root 오류"); return }
                guard let arrivalList = root["realtimeArrivalList"] as? [[String:Any]] else {return}
                for arrival in arrivalList {
                    var trainDict: [String:String] = [:]
                    guard let updnLine = arrival["updnLine"] as? String,
                          let trainLineNm = arrival["trainLineNm"] as? String,
                          let btrainSttus = arrival["btrainSttus"] as? String,
                          let barvlDt = arrival["barvlDt"] as? String,
                          let arvlMsg2 = arrival["arvlMsg2"] as? String,
                          let arvlMsg3 = arrival["arvlMsg3"] as? String
                    else {return}
                    trainDict["상/하행"] = updnLine
                    trainDict["도착지 방면"] = trainLineNm.components(separatedBy: " ").first
                    trainDict["열차 종류(급행, 일반, 특급)"] = btrainSttus
                    trainDict["도착 예정 시간"] = barvlDt
                    trainDict["첫번째도착메세지"] = arvlMsg2.components(separatedBy: ["[", "]"]).joined()
                    trainDict["두번째도착메세지"] = arvlMsg3
                    
                    if updnLine == "상행" || updnLine == "외선"{
                        self.trainListUp.append(trainDict)
                    } else {
                        self.trainListDn.append(trainDict)
                    }
                    
                    
                    
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
    @IBAction func btnReload(_ sender: Any) {
        search(station: strStation)
    }
    
}
extension SubwayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return trainListUp.count
        case 1: return trainListDn.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var train: [String:String?]
        switch indexPath.section {
        case 0: train = trainListUp[indexPath.row]
        case 1: train = trainListDn[indexPath.row]
        default:
            train = [:]
        }
        var config = cell.defaultContentConfiguration()
        config.text = train["도착지 방면"]!
        if indexPath.section == 2 || indexPath.section == 3 {
            let secondaryText: String? = train["첫번째도착메세지"]!! + " (" + train["두번째도착메세지"]!! + ")"
            config.secondaryText = secondaryText
        } else {
            config.secondaryText = train["첫번째도착메세지"]!
        }
        config.secondaryTextProperties.color = .red
        config.secondaryTextProperties.font = .systemFont(ofSize: 16)
        cell.contentConfiguration = config
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "\(strStation) (상행)"
        case 1: return "\(strStation) (하행)"
        default: return ""
        }
    }
    
}
