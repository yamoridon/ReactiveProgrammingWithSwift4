import Foundation
import RxCocoa
import RxSwift

struct LoginViewModel {
    var username = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")

    var isValid: Observable<Bool> {
        return Observable.combineLatest(
            username.asObservable(),
            password.asObservable()
        ) { usernameString, passwordString in
            usernameString.count >= 4 && passwordString.count >= 4
        }
    }
}
