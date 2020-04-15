//
//  ViewController.swift
//  FirstAppSwiftWorld
//
//  Created by Антон on 08.04.2020.
//  Copyright © 2020 Anton Agafonov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var year = ""

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var sliderPercent: UISlider!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var sliderTerm: UISlider!
    @IBOutlet weak var textFieldSumm: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var cancelOffer: UIButton!
    
    

    @IBAction func tappedButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Договор с Люцефером", message: "Вы хотите подписать договор на продажу собственной души?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Подписать", style: .default) {(alertAction) in self.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)}
        let canselAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(canselAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetMethod(_ sender: UIButton) {
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        percentLabel.text = "0 %"
        termLabel.text = "0 лет"
    }
    
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        button.isEnabled = sender.isOn
        sliderPercent.isEnabled = sender.isOn
        sliderTerm.isEnabled = sender.isOn
        textFieldSumm.isEnabled = sender.isOn
        cancelOffer.isEnabled = sender.isOn
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        percentLabel.text = "\(sender.value.rounded()) %"
        amountLabel.text = changeAmount()
    }
    
    func changeAmount() -> String {
               var amountValue = ""
        let percentValue = sliderPercent.value.rounded()
        let termValue = sliderTerm.value.rounded()
               if let summ = Int(textFieldSumm.text!) {
                    amountValue = "\(Int(Double(summ) * Double(percentValue/1200) * Double(pow(1 + Double(percentValue/1200), Double(termValue*12))) / (Double(pow(1 + Double(percentValue/1200), Double(termValue*12))) - 1))) руб"
               } else {
                   self.amountLabel.text = "0 руб"
               }
               return amountValue
           }
    
    @IBAction func termChanged(_ sender: UISlider) {
        switch Int(sender.value) {
        case  5...20, 25...30:
            year = "лет"
        case 21:
            year = "год"
        default:
            year = "года"
        }
        self.termLabel.text = "\(Int(sender.value))" + " \(year)"
        amountLabel.text = changeAmount()
    }

    
    @IBAction func textChangedSumm(_ sender: UITextField) {
        if let summ = Int(sender.text!) {
            self.amountLabel.text = "\(Int(Double(summ) * Double(sliderPercent.value/1200) * Double(pow(1 + Double(sliderPercent.value/1200), Double(sliderTerm.value*12))) / (Double(pow(1 + Double(sliderPercent.value/1200), Double(sliderTerm.value*12))) - 1))) руб"
        } else {
            self.amountLabel.text = "0 руб"
        }
    }
    
    @IBAction func respondToTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        print(location)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        super.viewDidLoad()
        percentLabel.text = "\(sliderPercent.value.rounded()) %"
        amountLabel.text = "0 руб"
        termLabel.text = "\(Int(sliderTerm.value))" + " лет"
        self.button.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
   }
}

