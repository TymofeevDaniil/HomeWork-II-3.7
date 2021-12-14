//
//  Task-a-ViewController.swift
//  HomeWork-II-3.7
//
//  Created by Danil Tymofeev on 30.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

class Task_a_ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let db = Task_a_Model()
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable<String?>.combineLatest([loginTextField.rx.text, passwordTextField.rx.text])
            .subscribe(onNext: { [unowned self] events in
                guard let login = events[0],
                let password = events[1] else { return }
                
                if login == "", password == "" {
                    errorLabel.text = ""
                    sendButton.isEnabled = false
                } else {
                    if !db.mailExamples.contains(login) {
                        errorLabel.text = "wrong email"
                        sendButton.isEnabled = false
                    } else if password.count < 6 {
                        errorLabel.text = "wrong password"
                        sendButton.isEnabled = false
                    } else {
                        errorLabel.text = ""
                        sendButton.isEnabled = true
                    }
                }
            }).disposed(by: disposeBag)
    }
    
}
