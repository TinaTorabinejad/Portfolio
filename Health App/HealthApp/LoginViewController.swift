

import UIKit



class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //creating outlets:
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passField: UITextField!
    @IBOutlet var rememberSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define placeholder for text fields
        let nameFieldPlaceholder = NSLocalizedString("Please provide your first and last name", comment: "place where user put his/her first and last name")
        let emailFieldPlaceholder = NSLocalizedString("Please provide a valid email address", comment: "Place where user enter his/her email address")
        self.nameField.placeholder = nameFieldPlaceholder
        self.emailField.placeholder = emailFieldPlaceholder
        
    }
    
    var loginButton: UIButton!
    
    
    override func loadView() {
        
        super.loadView()
        
        //creating the login button
        self.loginButton = UIButton(type: .system)
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        let loginTitle = NSLocalizedString("Login", comment: "Login button")
        self.loginButton.setTitle(loginTitle, for: UIControl.State.normal)
        self.loginButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.loginButton.backgroundColor = UIColor.systemOrange
        self.loginButton.tintColor = UIColor.black
        self.loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.loginButton.addTarget(self, action: #selector(logInButtonClicked(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(self.loginButton)
        
        //constraint the login button
        
        let logTrailing = self.loginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 50)
        let logTop = self.loginButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 370) //650)
        let height = self.loginButton.widthAnchor.constraint(equalToConstant: 90)
        let width = self.loginButton.heightAnchor.constraint(equalToConstant: 30)
        
        
        
        logTrailing.isActive = true
        logTop.isActive = true
        height.isActive = true
        width.isActive = true
        
    }
    
    //creating callback function for the login button
    
    @objc func logInButtonClicked(_ b: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = story.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
            self.present(tabBarController, animated: true, completion: nil)
            
        } else {
            print("Failed to instantiate TabBarController.")
        }
        print("Login Button was Clicked!")
    }

    
    //creating action function for tap gesture recognizer
    @IBAction func backgroundTapped (_ sender: UITapGestureRecognizer) {
        
        self.nameField.resignFirstResponder()
        self.emailField.resignFirstResponder()
        self.passField.resignFirstResponder()
        print("Background was tapped!")
    }
    
    //add the delegate method
    
    func textField(_ textFeild: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var acceptChanges = true
        
        let text_original = textFeild.text ?? ""
        var text_new = String(text_original)
        guard let sRange = Range(range, in: text_original)
        else {return false}
        text_new.replaceSubrange(sRange, with: string)
        
        print("Original text: \(text_original)")
        print("Changing to: \(text_new)")
        
        switch( textFeild.textContentType) 
        {
        case UITextContentType.emailAddress:
            print("Checking email change")
            if PatternChecker().checkEmailString(text_new) {
                print("Email is valid!")
            }
            else 
            {
                print("Email change rejected!")
                acceptChanges = false
            }
        case UITextContentType.name:
            print("Checking phone number change")
            if PatternChecker().checkNameString(text_new) {
                print("Name is valid!")
            }
            else {
                print("Name change rejected!")
                acceptChanges = false
            }
        default:
            print("Default content type: Won't check against pattern.")
        }
        return acceptChanges
    }
    
    //create an action function for remember switch
    @IBAction func switchTaggled(_ sw: UISwitch) {
        if (sw.isOn)
        {
            print("User wants to save the informtion!")
        }
        else {
            print("User is not interested in saving the information!")
        }
    }


}

