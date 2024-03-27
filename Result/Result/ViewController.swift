//
//  ViewController.swift
//  Result2
//
//  Created by YB on 3/27/24.
//

import UIKit

class ViewController : UIViewController {
    var followers: [Follower]?
    var label: UILabel = UILabel()
    var followerLabel: UILabel = UILabel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.followers = nil
        self.label = UILabel(frame: CGRect(x: 150, y: 200, width: 200, height: 20))
        self.followerLabel = UILabel(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        label.text = "Hello World!"
        label.textColor = .black
        
        followerLabel.text = "Follower Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        followerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.addSubview(followerLabel)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        networkManager.getFollowers(for: "yanichik", page: 1) { result in
            switch result {
            case .success(let followers):
                self.followers = followers
                print("set follower success: \(String(describing: self.followers))")
                DispatchQueue.main.async {
                    if let myfollowers = self.followers {
                        self.followerLabel.text = myfollowers[1].login
                        print("myfollowers[1].login: \(myfollowers[1].login)")
                        NSLayoutConstraint.activate([
                            self.followerLabel.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 15),
                            self.followerLabel.centerXAnchor.constraint(equalTo: self.label.centerXAnchor)
                        ])
                        self.view.addSubview(self.followerLabel)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    init (){}
    
    func getFollowers(for username: String, page: Int, complete: @escaping (Result<[Follower], GFError>) -> Void){
        guard let url = URL(string: "https://api.github.com/users/\(username)/followers?per_page=100&page=\(page)") else {
            complete(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let _ = error else {
                guard let data = data else {
                    complete(.failure(.invalidData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let received = try decoder.decode([Follower].self, from: data)
                    complete(.success(received))
                } catch {
                    complete(.failure(.invalidData))
                }
                return
            }
            complete(.failure(.unableToComplete))
        }
        task.resume()
    }
}

struct Follower: Codable {
    var login: String
    var avatarUrl: String
}

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid URL. Please try again."
    case unableToComplete = "Unable to complete your request. Please try again."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "Received blank data. Please try again."
}
