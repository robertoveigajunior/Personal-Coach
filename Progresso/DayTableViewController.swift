//
//  DayTableViewController.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 30/06/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit

class DayTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var lbSelectedTitle: UIButton!
    
    let arrScore = [1,0,-1]
    var pickerScoreHidden = true
    var selectedItem = Int()
    let titleButton = "Selecione aqui"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbSelectedTitle.setTitle(self.titleButton, forState: .Normal)
        self.togglePicker()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrScore.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.arrScore[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerScoreHidden = !self.pickerScoreHidden
        self.lbSelectedTitle.setTitle(String(self.arrScore[row]), forState: .Normal)
        self.selectedItem = self.arrScore[row]
        self.togglePicker()
    }
    
    //TableView
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.pickerScoreHidden && indexPath.row == 2 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    private func togglePicker() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func selectScore(sender: UIButton) {
        self.pickerScoreHidden = false
        self.togglePicker()
    }
    
    @IBAction func save(sender: UIButton) {
        if self.lbSelectedTitle.titleLabel?.text != self.titleButton {
            let num = arc4random_uniform(20) + 100;
            Day().saveDay(self.selectedItem, message: "TesteIOS\(num)")
        }
    }
    
}
