import RxSwift

executeProcedure(for: "map") {
    Observable
        .of(10, 20, 30)
        .map { $0 * $0 }
        .subscribe(onNext: { print($0) })
        .dispose()
}
