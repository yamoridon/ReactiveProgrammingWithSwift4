import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var demoTableView: UITableView!

    let data = [
        Developer(name: "Krunoslav Zaher", gitHubID: "kzaher"),
        Developer(name: "Yury Korolev", gitHubID: "yury"),
        Developer(name: "Serg Dort", gitHubID: "sergdort"),
        Developer(name: "Mo Ramezanpoor", gitHubID: "mohsenr"),
        Developer(name: "Carlos García", gitHubID: "carlosypunto"),
        Developer(name: "Scott Gardner", gitHubID: "scotteg"),
        Developer(name: "Nobuo Saito", gitHubID: "tarunon"),
        Developer(name: "Junior B.", gitHubID: "bontoJR"),
        Developer(name: "Jesse Farless", gitHubID: "solidcell"),
        Developer(name: "Jamie Pinkham", gitHubID: "jamiepinkham")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        demoTableView.dataSource = self
        demoTableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = demoTableView.dequeueReusableCell(withIdentifier: "Cell")
        else {
            return UITableViewCell()
        }

        let developer = data[indexPath.row]
        cell.textLabel?.text = developer.developerName
        cell.detailTextLabel?.text = developer.gitHubID
        cell.imageView?.image = developer.developerImage
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected:", data[indexPath.row])
    }
}
