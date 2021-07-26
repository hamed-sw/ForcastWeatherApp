//
//  DailyWeatherTableViewCell.swift
//  ForcastWeatherApp
//
//  Created by Hamed Amiry on 18.12.2020.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var lowTemLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {return ""}
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // name of the weak like monday ..... so on.
        return formatter.string(from: inputDate)
    }
}
