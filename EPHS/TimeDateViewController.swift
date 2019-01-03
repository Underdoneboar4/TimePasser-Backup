//
//  TimeDateViewController.swift
//  EPHS
//
//  Created by Jennifer Nelson on 12/19/18.
//  Copyright © 2018 EPHS. All rights reserved.
//

import UIKit

class TimeDateViewController: UIViewController {
    
    
    //DATABASE GOALS:
    //1. have imputs from database indicating Normal, CORE, ZeroHr
    //2. make the code look nice
    //3. have a database form allowing a custom schedule (forms are not in databse yet)
    
    var buttonCornerRadius: CGFloat = 25
    var buttonBorderWidth: CGFloat = 1
    
    var todaysScheduleType = 0; //0 = no imput/error retrieving, 1 = weekend, 2 = normalDay, 3 = ZeroHr, 4 = CORE, 5 = other

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    @IBOutlet weak var LeftButton: UIButton!
    @IBOutlet weak var MiddleButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    
    var now = Date()
    var weekday = Calendar.current.component(.weekday, from: Date()) //Wed = 4, starts at Sun
    let calendar = Calendar.current
    
    //TimeBlocks are the events that happen that day. The first event to happen, no matter the schedule, is the day starting. For example, on a normal day, the secondTimeBlock corresponds to 1st hour starting, while on a Zero Hr day it corresponds to Zero Hr ending.
    
    var startDay: Date = Date()
    var secondTimeBlock: Date = Date()
    var thirdTimeBlock: Date = Date()
    var fourthTimeBlock: Date = Date()
    var fifthTimeBlock: Date = Date()
    var sixthTimeBlock: Date = Date()
    var seventhTimeBlock: Date = Date()
    var endDayRegular: Date = Date()
    var ninthTimeBlock: Date = Date()
    var endDayCORE: Date = Date()
    var eleventhTimeBlock: Date = Date()
    var endDayZeroHr: Date = Date()
    var timer = Timer()
    var secondsUntilNextBlock = 0.0
    
    override func viewDidLoad() {
        LeftButton.layer.cornerRadius = buttonCornerRadius
        RightButton.layer.cornerRadius = buttonCornerRadius
        MiddleButton.layer.cornerRadius = buttonCornerRadius
        
        LeftButton.layer.borderColor = UIColor.white.cgColor
        LeftButton.layer.borderWidth = buttonBorderWidth
        
        RightButton.layer.borderColor = UIColor.white.cgColor
        RightButton.layer.borderWidth = buttonBorderWidth
        
        MiddleButton.layer.borderColor = UIColor.white.cgColor
        MiddleButton.layer.borderWidth = buttonBorderWidth
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "timeDateBackgroundImage.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.view.insertSubview(backgroundImage, at: 0)
        super.viewDidLoad()
        
        todaysScheduleType = grabTodaysScheduleType()
        
        if (todaysScheduleType == 0){ //if database has trouble returning today's schedule, uses current weekday
            print("NO DATABASE VALUE")
            if (weekday == 1 || weekday == 7){
                bottomLabel.text = "It's the weekend, relax!"
            } else if (weekday % 2 == 0){ //even weekdays are Mon, Wed, Fri
                setClocksToNormal()
            } else if (weekday == 3){ //Tuesday
                setClocksToZeroHr()
            } else if (weekday == 5){ //Thursday
                setClocksToCORE()
            }
        } else if (todaysScheduleType == 1){
            bottomLabel.text = "It's the weekend, relax!"
        } else if (todaysScheduleType == 2){
            setClocksToNormal()
        } else if (todaysScheduleType == 3){
            setClocksToZeroHr()
        } else if (todaysScheduleType == 4){
            setClocksToCORE()
        } else if (todaysScheduleType == 5){
            bottomLabel.text = "sorry, I can't do custom schedules yet"
        }
        
        
    }
    
    //Each of the updateLabels____Day functions runs every second
    //Cool potential update: check if new TimeBlock only if new minute is reached
    
    @objc func updateLabelsNormalDay(){ //uses obj-C so #selector can grab the function
        now = Date()
        topLabel.text = DateFormatter.localizedString(from: now, dateStyle: .none, timeStyle: .long)
        if now <= startDay {
            updateBottomLabel(date: startDay, s: "1st Hour begins\n (Normal day)", inSession: true)
        } else if now <= secondTimeBlock {
            updateBottomLabel(date: secondTimeBlock, s: "1st Hour ends\n (Normal day)", inSession: true)
        } else if now <= thirdTimeBlock {
            updateBottomLabel(date: thirdTimeBlock, s: "2nd Hour begins\n (Normal day)", inSession: true)
        } else if now <= fourthTimeBlock {
            updateBottomLabel(date: fourthTimeBlock, s: "2nd Hour ends\n (Normal day)", inSession: true)
        } else if now <= fifthTimeBlock {
            updateBottomLabel(date: fifthTimeBlock, s: "3rd Hour begins\n (Normal day)", inSession: true)
        } else if now <= sixthTimeBlock {
            updateBottomLabel(date: sixthTimeBlock, s: "3rd Hour ends\n (Normal day)", inSession: true)
        } else if now <= seventhTimeBlock {
            updateBottomLabel(date: seventhTimeBlock, s: "4th Hour begins\n (Normal day)", inSession: true)
        } else if now <= endDayRegular {
            updateBottomLabel(date: endDayRegular, s: "school ends", inSession: true)
        } else {
            updateBottomLabel(date: Date(), s: "", inSession: false)
        }
    }
    @objc func updateLabelsZeroHrDay(){ //uses obj-C so #selector can grab the function
        now = Date()
        topLabel.text = DateFormatter.localizedString(from: now, dateStyle: .none, timeStyle: .long)
        if now <= startDay {
            updateBottomLabel(date: startDay, s: "Zero Hour begins", inSession: true)
        } else if now <= secondTimeBlock {
            updateBottomLabel(date: secondTimeBlock, s: "Zero Hour ends", inSession: true)
        } else if now <= thirdTimeBlock {
            updateBottomLabel(date: thirdTimeBlock, s: "1st Hour begins\n(Zero Hour day)", inSession: true)
        } else if now <= fourthTimeBlock {
            updateBottomLabel(date: fourthTimeBlock, s: "1st Hour ends\n(Zero Hour day)", inSession: true)
        } else if now <= fifthTimeBlock {
            updateBottomLabel(date: fifthTimeBlock, s: "Connections begins", inSession: true)
        } else if now <= sixthTimeBlock {
            updateBottomLabel(date: sixthTimeBlock, s: "Connections ends", inSession: true)
        } else if now <= seventhTimeBlock {
            updateBottomLabel(date: seventhTimeBlock, s: "2nd Hour begins\n(Zero Hour day)", inSession: true)
        } else if now <= endDayRegular {
            updateBottomLabel(date: endDayRegular, s: "2nd Hour ends\n(Zero Hour day)", inSession: true)
        } else if now <= ninthTimeBlock {
            updateBottomLabel(date: ninthTimeBlock, s: "3rd Hour begins\n(Zero Hour day)", inSession: true)
        } else if now <= endDayCORE {
            updateBottomLabel(date: endDayCORE, s: "3rd Hour ends\n(Zero Hour day)", inSession: true)
        } else if now <= eleventhTimeBlock {
            updateBottomLabel(date: eleventhTimeBlock, s: "4th Hour begins\n(Zero Hour day)", inSession: true)
        } else if now <= endDayZeroHr {
            updateBottomLabel(date: endDayZeroHr, s: "school ends", inSession: true)
        } else {
            updateBottomLabel(date: Date(), s: "", inSession: false)
        }
    }
    
    @objc func updateLabelsCOREDay(){ //uses obj-C so #selector can grab the function
        now = Date()
        topLabel.text = DateFormatter.localizedString(from: now, dateStyle: .none, timeStyle: .long)
        if now <= startDay {
            updateBottomLabel(date: startDay, s: "1st Hour begins\n(CORE day)", inSession: true)
        } else if now <= secondTimeBlock {
            updateBottomLabel(date: secondTimeBlock, s: "1st Hour ends\n(CORE day)", inSession: true)
        } else if now <= thirdTimeBlock {
            updateBottomLabel(date: thirdTimeBlock, s: "CORE begins", inSession: true)
        } else if now <= fourthTimeBlock {
            updateBottomLabel(date: fourthTimeBlock, s: "CORE ends", inSession: true)
        } else if now <= fifthTimeBlock {
            updateBottomLabel(date: fifthTimeBlock, s: "2nd Hour begins\n(CORE day)", inSession: true)
        } else if now <= sixthTimeBlock {
            updateBottomLabel(date: sixthTimeBlock, s: "2nd Hour ends\n(CORE day)", inSession: true)
        } else if now <= seventhTimeBlock {
            updateBottomLabel(date: seventhTimeBlock, s: "3rd Hour begins\n(CORE day)", inSession: true)
        } else if now <= endDayRegular {
            updateBottomLabel(date: endDayRegular, s: "3rd Hour ends\n(CORE day)", inSession: true)
        } else if now <= ninthTimeBlock {
            updateBottomLabel(date: ninthTimeBlock, s: "4th Hour begins\n(CORE day)", inSession: true)
        } else if now <= endDayCORE {
            updateBottomLabel(date: endDayCORE, s: "school ends", inSession: true)
        }  else {
            updateBottomLabel(date: Date(), s: "", inSession: false)
        }
    }
    
    func updateBottomLabel(date: Date, s: String, inSession: Bool){
        if (inSession){
            secondsUntilNextBlock = date.timeIntervalSinceNow
            bottomLabel.text = String(Int(secondsUntilNextBlock/60)+1) + " minutes until \n" + s
        } else {
            bottomLabel.text = "school has ended for today"
        }
    }
    
    func setClocksToNormal(){
        startDay = calendar.date(
            bySettingHour: 7, minute: 50, second: 0, of: now)!
        secondTimeBlock = calendar.date(bySettingHour: 9, minute: 17, second: 0, of: now)!
        thirdTimeBlock = calendar.date(bySettingHour: 9, minute: 25, second: 0, of: now)!
        fourthTimeBlock = calendar.date(bySettingHour: 10, minute: 52, second: 0, of: now)!
        fifthTimeBlock = calendar.date(bySettingHour: 11, minute: 0, second: 0, of: now)!
        sixthTimeBlock = calendar.date(bySettingHour: 13, minute: 0, second: 0, of: now)!
        seventhTimeBlock = calendar.date(bySettingHour: 13, minute: 08, second: 0, of: now)!
        endDayRegular = calendar.date( bySettingHour: 14, minute: 35, second: 0, of: now)!
        updateLabelsNormalDay()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.updateLabelsNormalDay) , userInfo: nil, repeats: true)
    }
    
    func setClocksToZeroHr(){
        startDay = calendar.date(bySettingHour: 7, minute: 15, second: 0, of: now)!
        secondTimeBlock = calendar.date(bySettingHour: 8, minute: 15, second: 0, of: now)!
        thirdTimeBlock = calendar.date(bySettingHour: 8, minute: 20, second: 0, of: now)!
        fourthTimeBlock = calendar.date(bySettingHour: 9, minute: 30, second: 0, of: now)!
        fifthTimeBlock = calendar.date(bySettingHour: 9, minute: 37, second: 0, of: now)!
        sixthTimeBlock = calendar.date(bySettingHour: 9, minute: 57, second: 0, of: now)!
        seventhTimeBlock = calendar.date(bySettingHour: 10, minute: 04, second: 0, of: now)!
        endDayRegular = calendar.date(bySettingHour: 11, minute: 14, second: 0, of: now)!
        ninthTimeBlock = calendar.date(bySettingHour: 11, minute: 21, second: 0, of: now)!
        endDayCORE = calendar.date(bySettingHour: 13, minute: 18, second: 0, of: now)!
        eleventhTimeBlock = calendar.date(bySettingHour: 13, minute: 25, second: 0, of: now)!
        endDayZeroHr = calendar.date(bySettingHour: 14, minute: 35, second: 0, of: now)!
        updateLabelsZeroHrDay()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.updateLabelsZeroHrDay) , userInfo: nil, repeats: true)
    }
    
    func setClocksToCORE(){
        startDay = calendar.date( bySettingHour: 7, minute: 50, second: 0, of: now)!
        secondTimeBlock = calendar.date(bySettingHour: 9, minute: 05, second: 0, of: now)!
        thirdTimeBlock = calendar.date(bySettingHour: 9, minute: 12, second: 0, of: now)!
        fourthTimeBlock = calendar.date(bySettingHour: 9, minute: 57, second: 0, of: now)!
        fifthTimeBlock = calendar.date(bySettingHour: 10, minute: 04, second: 0, of: now)!
        sixthTimeBlock = calendar.date(bySettingHour: 11, minute: 14, second: 0, of: now)!
        seventhTimeBlock = calendar.date( bySettingHour: 11, minute: 21, second: 0, of: now)!
        endDayRegular = calendar.date(bySettingHour: 13, minute: 18, second: 0, of: now)!
        ninthTimeBlock = calendar.date(bySettingHour: 13, minute: 25, second: 0, of: now)!
        endDayCORE = calendar.date(bySettingHour: 14, minute: 35, second: 0, of: now)!
        updateLabelsCOREDay()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.updateLabelsCOREDay) , userInfo: nil, repeats: true)
    }
    @IBAction func leftButtonPressed(_ sender: Any) {
        LeftButton.backgroundColor = UIColor.darkGray
        RightButton.backgroundColor = UIColor.clear
        MiddleButton.backgroundColor = UIColor.clear
        timer.invalidate()
        setClocksToCORE()
    }
    @IBAction func rightButtonPressed(_ sender: Any) {
        LeftButton.backgroundColor = UIColor.clear
        RightButton.backgroundColor = UIColor.darkGray
        MiddleButton.backgroundColor = UIColor.clear
        timer.invalidate()
        setClocksToZeroHr()
    }
    @IBAction func middleButtonPressed(_ sender: Any) {
        LeftButton.backgroundColor = UIColor.clear
        RightButton.backgroundColor = UIColor.clear
        MiddleButton.backgroundColor = UIColor.darkGray
        timer.invalidate()
        setClocksToNormal()
    }
    func grabTodaysScheduleType() -> Int {
        if(false){
            //get database value corresponding to the day of the week, no idea how
        } else {
            return 0
        }
    }
    
}
