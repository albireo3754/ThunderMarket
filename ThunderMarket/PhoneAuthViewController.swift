//
//  PhoneAuthViewController.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/07/25.
//

import UIKit

class PhoneAuthViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var getAuthMessageButton: UIButton!
    @IBOutlet weak var matchAuthNumButton: UIButton!
    @IBOutlet weak var tempAuthNumbLabel: UILabel!
    var authNumber: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tempAuthNumbLabel.text = authNumber
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(textField.text!)
//        print(range.location)
//        print(range.length)
//        print(string)
//        return true
//    }
    
    
    @IBAction func phoneEditing(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        let MAX_LENGTH = 13
        if text.count > MAX_LENGTH {
            sender.deleteBackward()
        }
        if text.count == 4 || text.count == 9 {
            if self.getLastWord(from: text) == " " {
                sender.text?.removeLast()
            } else {
                sender.text = String(text[text.startIndex..<text.index(before: text.endIndex)]) + " " + self.getLastWord(from: text)
                print(sender.text)
            }
            if sender.text!.count <= 8 {
                self.getAuthMessageButton.isEnabled = false
            }
            else {
                self.getAuthMessageButton.isEnabled = true
            }
        }
    }
    
    func getLastWord(from string: String) -> String {
        return String(string[string.index(before: string.endIndex)..<string.endIndex])
    }
    
    // TODO: - 실제 인증 문자가 오고, 결과와 매칭되도록 해야함
    @IBAction func getAuthMessage(_ sender: UIButton) {
        self.authNumber = "1234"
        tempAuthNumbLabel?.text = authNumber
    }
    
    @IBAction func authNumEditing(_ sender: UITextField) {
        if sender.text?.count == 0 {
            
        }
    }
    @IBAction func inputAuthNum(_ sender: UIButton) {
        
    }
}
