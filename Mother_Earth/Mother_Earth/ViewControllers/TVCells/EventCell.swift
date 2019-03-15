import UIKit

class EventCell: UITableViewCell {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var details: UILabel!
    @IBOutlet private weak var date: UILabel!

    func configure(event: Event) {
        title.text = event.title
        details.text = event.description

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        if let when = event.closeDate {
            date.text = formatter.string(for: when)
        } else {
            date.text = ""
        }
    }
}
