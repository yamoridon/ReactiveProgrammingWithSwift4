
import UIKit

struct Developer {
    
    let developerName: String
    let gitHubID: String
    var developerImage: UIImage?
    
    init(name: String, gitHubID: String) {
        self.developerName = name
        self.gitHubID = gitHubID
        developerImage = UIImage(named: gitHubID)
    }
}

extension Developer: CustomStringConvertible {
    
    var description: String {
        return "\(developerName): github.com/\(gitHubID)"
    }
}
