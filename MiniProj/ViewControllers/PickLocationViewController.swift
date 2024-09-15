//
//  PickLocationViewController.swift
//  MiniProj
//
//  Created by jhshin on 9/15/24.
//

import UIKit

class PickLocationViewController: UIViewController {
    let seoulGuList = ["종로구", "중구", "용산구","성동구","광진구","동대문구","중랑구","성북구","강북구","도봉구","노원구","은평구","서대문구","마포구","양천구","강서구","구로구","금천구","영등포구","동작구","관악구","서초구","강남구","송파구","강동구"]
    let coordinate = ["종로구":"60/127", "중구":"60/127", "용산구":"60/126", "성동구":"61/127", "광진구":"62/126", "동대문구":"61/127", "중랑구":"62/128", "성북구":"61/127", "강북구":"61/128", "도봉구":"61/129", "노원구":"61/129", "은평구":"59/127", "서대문구":"59/127", "마포구":"59/127", "양천구":"58/126", "강서구":"58/126", "구로구":"58/125", "금천구":"59/124","영등포구":"58/126","동작구":"59/125","관악구":"59/125","서초구":"61/125","강남구":"61/126","송파구":"62/126","강동구":"62/126"]
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let newVC = segue.destination as? ForecastViewController
        guard let newVC = newVC else { return }
        var selectedGu = seoulGuList[pickerView.selectedRow(inComponent: 1)]
        
        newVC.strGU = selectedGu
        guard let c = coordinate[selectedGu] else {return}
        newVC.coordinate = c
    }
    

}
extension PickLocationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? 1 : seoulGuList.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "서울시"
        } else {
            return seoulGuList[row]
        }
    }
}
