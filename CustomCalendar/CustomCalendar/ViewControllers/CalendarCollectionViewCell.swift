//
//  CalendarCollectionViewCell.swift
//  CustomCalendar
//
//  Created by Евгений Пархомчук on 15.06.2023.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayOfMonth: UILabel!
    
    func loadCell(day: String) {
        dayOfMonth.text = day
    }
}
