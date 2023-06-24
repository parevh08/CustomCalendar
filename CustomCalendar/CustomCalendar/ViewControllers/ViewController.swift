//
//  ViewController.swift
//  CustomCalendar
//
//  Created by Евгений Пархомчук on 15.06.2023.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!

    var selectedDate  = Date()
    var totalSquares  = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewController()
    }
}



//MARK: - @IBAction
extension ViewController {

    @IBAction func previosMonth() {
        selectedDate = CalendarManager().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth() {
        selectedDate = CalendarManager().plusMonth(date: selectedDate)
        setMonthView()
    }
}


//MARK: - Open Functions
extension ViewController {
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarManager().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarManager().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarManager().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42) {
            
            if(count <= startingSpaces || count - startingSpaces > daysInMonth) {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        dateLabel.text = CalendarManager().monthString(date: selectedDate) + " " + CalendarManager().yearString(date: selectedDate)
        collectionView.reloadData()
    }
}

//MARK: - CollectionViewDataSource, CollectionViewDelegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
        let day = totalSquares[indexPath.row]
        cell.loadCell(day: day)
        return cell
    }
}

//MARK: - ViewDidLoad
extension ViewController {
    
    private func loadViewController() {
             
        setCellsView()
        setMonthView()
        
        let cellNib = UINib(nibName: "CalendarCollectionViewCell", bundle: nil)
                
        collectionView.backgroundColor = .clear
        collectionView.register(cellNib, forCellWithReuseIdentifier: "CalendarCollectionViewCell")
        
    }
}


