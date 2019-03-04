import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var validationsLabel: UILabel!

    var loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.isEnabled = false
        loginButton.backgroundColor = .lightGray

        _ = usernameTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.username)
        _ = passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.password)

        _ = loginViewModel.isValid.bind(to: loginButton.rx.isEnabled)

        _ = loginViewModel.isValid.subscribe(onNext: { [unowned self] isValid in
            self.validationsLabel.text = isValid ? "Enabled" : "Disabled"
            self.validationsLabel.textColor = isValid ? .green : .red

            // Log the values with each key in event
            print(isValid)

            // Making changes to the login button
            self.loginButton.isEnabled = isValid
            self.loginButton.backgroundColor = isValid ? .orange : .lightGray
        })
    }
}
