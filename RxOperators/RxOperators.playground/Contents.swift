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
