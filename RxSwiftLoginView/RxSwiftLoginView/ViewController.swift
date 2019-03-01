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

        _ = usernameTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.username)
        _ = passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.password)
    }
}
