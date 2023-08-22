//
//  TripBudgetTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 22/08/23.
//

import UIKit
import DGCharts

class TripBudgetTableViewCell: UITableViewCell {
    
    var customColors = [
        "FF6969",
        "337CCF",
        "FFBFBF",
        "279EFF",
        "EBE76C",
        "40F8FF",
        "4D3C77",
        "96B6C5",
        "EADBC8",
        "9ED2BE"
    ]

    //MARK: - Outlets
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(budget: TripBudget) {
        var expenses = budget.expenses.map { expense in
            expense.amount
        }
        let expenseTotal = expenses.reduce(0, +)
        let remaining = budget.total - expenseTotal
        
        let expenseDataEntry = PieChartDataEntry(value: expenseTotal, label: "expenses")
        let remainingDataEntry = PieChartDataEntry(value: remaining, label: "remaining")
        
        pieChartView.chartDescription.text = ""
        
        let dataSet = PieChartDataSet(entries: [expenseDataEntry, remainingDataEntry], label: "")
        let colors = [
            UIColor(hexString: "FF6969"),
            UIColor(hexString: "FFBFBF")
        ]
        
        let data = PieChartData(dataSet: dataSet)
        dataSet.colors = colors
        
        pieChartView.backgroundColor = .clear
        pieChartView.holeColor = .clear
        pieChartView.entryLabelColor = UIColor(named: TEXT_COLOR)
        pieChartView.data = data
    }
    
}
