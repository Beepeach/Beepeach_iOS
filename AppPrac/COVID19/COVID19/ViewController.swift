//
//  ViewController.swift
//  COVID19
//
//  Created by JunHeeJo on 11/10/21.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {
    // MARK: - @IBOutlet
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.startAnimating()
        
        self.fetchCovidOverview(completionHandler: { [weak self] result in
            guard let self = self else { return }
            self.indicatorView.stopAnimating()
            self.labelStackView.isHidden = false
            self.pieChartView.isHidden = false
            switch result {
            case let .success(result):
                debugPrint("success \(result)")
                self.configureStackView(koreaCovidOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configureChartView(covidOverviewList: covidOverviewList)
                
            case let .failure(error):
                debugPrint("error \(error)")
            }
        })
    }
    
    func fetchCovidOverview(completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": covidAPIKey
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: param
        ).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverview.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
                
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func configureStackView(koreaCovidOverview: CovidOverview) {
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase)명"
    }
    
    func makeCovidOverviewList(cityCovidOverview: CityCovidOverview)-> [CovidOverview] {
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeonbuk,
            cityCovidOverview.jeonnam,
            cityCovidOverview.jeju
        ]
    }
    
    func configureChartView(covidOverviewList: [CovidOverview]) {
        self.pieChartView.delegate = self
        
        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return nil }
            return PieChartDataEntry(
                value: self.removeFormatString(str: overview.newCase),
                label: overview.countryName,
                data: overview
            )
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.pastel() +
        ChartColorTemplates.material()
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
    }
    
    func removeFormatString(str: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: str)?.doubleValue ?? 0
    }
}


// MARK: - ChartViewDelegate
extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailVC: CovidDetailTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "CovidDetailTableViewController") as? CovidDetailTableViewController else {
            return
        }
        guard let covidOverview = entry.data as? CovidOverview else {
            return
        }
        
        covidDetailVC.covidOverview = covidOverview
        self.navigationController?.pushViewController(covidDetailVC, animated: true)
    }
}
