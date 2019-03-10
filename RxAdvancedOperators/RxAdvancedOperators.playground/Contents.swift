import Foundation
import RxCocoa
import RxSwift

executeProceduer(for: "startwith") {
    let disposeBag = DisposeBag()
    Observable
        .of("String 2", "String 3", "String 4")
        .startWith("String 0", "String 1")
        .startWith("String -1")
        .startWith("String -2")
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}

executeProceduer(for: "merge") {
    let disposeBag = DisposeBag()

    let pubSubject1 = PublishSubject<String>()
    let pubSubject2 = PublishSubject<String>()
    let pubSubject3 = PublishSubject<String>()

    Observable
        .of(pubSubject1, pubSubject2, pubSubject3)
        .merge()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

    pubSubject1.onNext("First Element from Subject 1")
    pubSubject2.onNext("First Element from Subject 2")
    pubSubject3.onNext("First Element from Subject 3")
    pubSubject1.onNext("Second Element from Subject 1")
    pubSubject2.onNext("Second Element from Subject 2")
    pubSubject3.onNext("Second Element from Subject 3")
}

executeProceduer(for: "zip") {
    let disposeBag = DisposeBag()

    let intPubSubject1 = PublishSubject<Int>()
    let stringPubSubject1 = PublishSubject<String>()
    let intPubSubject2 = PublishSubject<Int>()
    let stringPubSubject2 = PublishSubject<String>()

    Observable
        .zip(intPubSubject1, stringPubSubject1, intPubSubject2, stringPubSubject2) { intSub1, strSub1, intSub2, stringSub2 in
            "\(intSub1) : \(strSub1) AND \(intSub2) : \(stringSub2)"
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

    stringPubSubject1.onNext("is the first String element on stringPubSubject1")
    stringPubSubject1.onNext("is the second String element on stringPubSubject1")
    stringPubSubject2.onNext("is the first String element on stringPubSubject2")
    stringPubSubject2.onNext("is the second String element on stringPubSubject2")
    intPubSubject1.onNext(1)
    intPubSubject1.onNext(2)
    intPubSubject2.onNext(3)
    intPubSubject2.onNext(4)
    intPubSubject1.onNext(5)
    stringPubSubject1.onNext("is the third String element on stringPubSubject1")
    intPubSubject2.onNext(3)
    stringPubSubject2.onNext("is the third String element on stringPubSubject2")
}

executeProceduer(for: "do(on...)") {
    let disposeBag = DisposeBag()
    let temperatureInFahrenheit = PublishSubject<Int>()
    temperatureInFahrenheit
        .do(onNext: { $0 * $0 })
        .do(onNext: { print("\($0)℉ = ", terminator: "")})
        .map { Double($0 - 32) * 5.0 / 9.0 }
        .do(
            onError: { print($0) },
            onCompleted: { print("Completed the sequence") },
            onSubscribe: { print("Subscribed to sequence") },
            onDispose: { print("Sequence Disposed") }
        )
        .subscribe(onNext: { print(String(format: "%.1f℃", $0)) })
        .disposed(by: disposeBag)

    temperatureInFahrenheit.onNext(-40)
    temperatureInFahrenheit.onNext(0)
    temperatureInFahrenheit.onNext(37)
}
