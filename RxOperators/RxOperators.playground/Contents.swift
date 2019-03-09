import Foundation
import RxSwift
import RxCocoa

executeProcedure(for: "map") {
    Observable
        .of(10, 20, 30)
        .map { $0 * $0 }
        .subscribe(onNext: { print($0) })
        .dispose()
}

executeProcedure(for: "flatMap and flatMapLatest") {
    struct GamePlayer {
        let playerScore: BehaviorRelay<Int>
    }

    let disposeBag = DisposeBag()

    let alex = GamePlayer(playerScore: BehaviorRelay(value: 70))
    let gemma = GamePlayer(playerScore: BehaviorRelay(value: 85))

    let currentPlayer = BehaviorRelay(value: alex)

    currentPlayer
        .asObservable()
        .flatMapLatest { $0.playerScore.asObservable() }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

    alex.playerScore.accept(90)
    alex.playerScore.accept(95)

    currentPlayer.accept(gemma)

    alex.playerScore.accept(96)
}

executeProcedure(for: "scan and buffer") {
    let disposeBag = DisposeBag()
    let gameScore = PublishSubject<Int>()

    gameScore
        .buffer(timeSpan: 0.0, count: 3, scheduler: MainScheduler.instance)
        .map {
            print($0, "--> ", terminator: "")
            return $0.reduce(0, +)
        }
        .scan(501, accumulator: -)
        .map { max($0, 0) }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)

    gameScore.onNext(60)
    gameScore.onNext(13)
    gameScore.onNext(50)
}

executeProcedure(for: "filter") {
    let disposeBag = DisposeBag()
    let integers = Observable
        .generate(initialState: 1, condition: { $0 < 101 }, iterate: { $0 + 1 })

    integers
        .filter { $0.isPrimse() }
        .toArray()
        .subscribe { print($0) }
        .disposed(by: disposeBag)
}

executeProcedure(for: "distinctUntilChanged") {
    let disposeBag = DisposeBag()
    let stringToSearch = BehaviorRelay(value: "")

    stringToSearch
        .asObservable()
        .map { $0.lowercased() }
        .distinctUntilChanged()
        .subscribe { print($0) }
        .disposed(by: disposeBag)

    stringToSearch.accept("TINTIN")
    stringToSearch.accept("tintin")
    stringToSearch.accept("noDDy")
    stringToSearch.accept("TINTIN")
}

executeProcedure(for: "takeWhile") {
    let disposeBag = DisposeBag()
    let integers = Observable.of(10, 20, 30, 40, 30, 20, 10)

    integers
        .takeWhile { $0 < 40 }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
