//
//  TripBudgetTableViewCell.swift
//  Trippi
//
//  Created by Aman Raghuvanshi on 22/08/23.
//

import UIKit
import DGCharts

class TripBudgetTableViewCell: UITableViewCell {

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
        let expenses = budget.expenses.map { expense in
            expense.amount
        }
        let expenseTotal = expenses.reduce(0, +)
        let remaining = budget.total - expenseTotal
        
        let expenseDataEntry = PieChartDataEntry(value: expenseTotal, label: "expenses")
        let remainingDataEntry = PieChartDataEntry(value: remaining, label: "remaining")
        
        pieChartView.chartDescription.text = ""
        
        let dataSet = PieChartDataSet(entries: [expenseDataEntry, remainingDataEntry], label: "")
        let colors = [
            UIColor(hexString: "4A55A2"),
            UIColor(hexString: "7895CB")
        ]
        
        let data = PieChartData(dataSet: dataSet)
        dataSet.colors = colors
        
        pieChartView.backgroundColor = .clear
        pieChartView.holeColor = .clear
        pieChartView.entryLabelColor = UIColor(named: TEXT_COLOR)
        pieChartView.data = data
    }
    
}
