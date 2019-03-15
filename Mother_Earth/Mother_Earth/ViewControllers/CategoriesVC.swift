import RxCocoa
import RxSwift
import UIKit

class CategoriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var cetegoriesTableView: UITableView!

    let categories = BehaviorRelay<[Category]>(value: [])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        categories
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                // Trasitional way of doing things..
                // We weill learn schedulers later in the book
                DispatchQueue.main.async {
                    self?.cetegoriesTableView?.reloadData()
                }
            })
            .disposed(by: disposeBag)

        startDownload()
    }

    func startDownload() {
        let localCategories = EONETRequestRouter.categories
        let downloadedEvents = EONETRequestRouter.events(forLast: 100)
        let updatedCategories = Observable
            .combineLatest(localCategories, downloadedEvents) { categories, events -> [Category] in
                return categories.map { category in
                    var cat = category
                    cat.events = events.filter {
                        $0.categories.contains(category.id)
                    }
                    return cat
                }
            }
        localCategories
            .concat(updatedCategories)
            .bind(to: categories)
            .disposed(by: disposeBag)
    }

    // MARK: UITablewViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")!
        let category = categories.value[indexPath.row]
        cell.textLabel?.text = "\(category.name) (\(category.events.count))"

        cell.accessoryType = category.events.isEmpty ? .none : .disclosureIndicator
        return cell
    }
}
