//
//  CovidDetailTableViewController.swift
//  COVID19
//
//  Created by JunHeeJo on 11/10/21.
//

import UIKit

class CovidDetailTableViewController: UITableViewController {
    // MARK: Properties
    var covidOverview: CovidOverview?
    
    // MARK: @IBOutlet
    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var recoveredCaseCell: UITableViewCell!
    @IBOutlet weak var deathCaseCell: UITableViewCell!
    @IBOutlet weak var percentageCell: UITableViewCell!
    @IBOutlet weak var overseasInflowCaseCell: UITableViewCell!
    @IBOutlet weak var regionalOutbreakCaseCell: UITableViewCell!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurView()
    }
    
    func configurView() {
        guard let covidOverview = self.covidOverview else {
            return
        }
        
        self.title = covidOverview.countryName
        self.newCaseCell.detailTextLabel?.text = "\(covidOverview.newCase)명"
        self.totalCaseCell.detailTextLabel?.text = "\(covidOverview.totalCase)명"
        self.recoveredCaseCell.detailTextLabel?.text = "\(covidOverview.recovered)명"
        self.deathCaseCell.detailTextLabel?.text = "\(covidOverview.death)명"
        self.percentageCell.detailTextLabel?.text = "\(covidOverview.percentage)%"
        self.overseasInflowCaseCell.detailTextLabel?.text = "\(covidOverview.newFcase)명"
        self.regionalOutbreakCaseCell.detailTextLabel?.text = "\(covidOverview.newCcase)명"
    }
}
