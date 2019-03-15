import UIKit

class EventsVC: UIViewController, UITableViewDataSource {
    @IBOutlet private weak var sliderView: UISlider!
    @IBOutlet private weak var daysLabel: UILabel!
    @IBOutlet private weak var eventsTV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        eventsTV.rowHeight = UITableView.automaticDimension
        eventsTV.estimatedRowHeight = 60
    }

    @IBAction private func sliderMoved(_ sender: Any) {
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        return cell
    }
}
