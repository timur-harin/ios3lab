import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var universityLabel: UITextView!
    @IBOutlet weak var cityLabel: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)
        
        
        
        avatarImageView.layer.cornerRadius = view.frame.width / 4
        avatarImageView.clipsToBounds = true
        
        nameLabel.text = "Timur Harin"
        universityLabel.text = "Innopolis University"
        cityLabel.text = "Innopolis"
        
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor =  UIColor.gray.cgColor
        
        borderLayer.frame = CGRect(origin: CGPoint(x:0.0, y: nameLabel.frame.size.height-1), size: CGSize(width: nameLabel.frame.size.width, height: 1.0))
        
        
        
        nameLabel.layer.addSublayer(borderLayer)
        
        if nameLabel.text != nil {
            let initials = getInitials(name: nameLabel.text)
            let avatarImage = imageWithInitials(initials: initials)
            avatarImageView.image = avatarImage
        }
        
        nameLabel.delegate=self
    }
    
    
    func getInitials(name: String?) -> String{
        let initials = name?.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first ?? "A")") + "\($1.first ?? "A")" } ?? "AA"
        return initials
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameLabel.endEditing(true)
        return false
    }
    
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        nameLabel.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameLabel {
            if let newName = textField.text {
                nameLabel.text = newName
                
                
                let initials = getInitials(name: nameLabel.text)
                let avatarImage = imageWithInitials(initials: initials)
                avatarImageView.image = avatarImage
            }
        }
    }
    
    @IBAction func universityButtonTapped(_ sender: UIButton) {
        showInputDialog(title: "Enter University", message: nil, placeholder: "Your University") { newUniversity in
            self.universityLabel.text = newUniversity
        }
    }
    
    @IBAction func cityButtonTapped(_ sender: UIButton) {
        showInputDialog(title: "Enter City", message: nil, placeholder: "Your City") { newCity in
            self.cityLabel.text = newCity
        }
    }
    
    private func imageWithInitials(initials: String) -> UIImage? {
        let size = avatarImageView.frame.size
        let frame = CGRect(origin: .zero, size: size)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.text = initials
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil
    }
    
    private func showInputDialog(title: String, message: String?, placeholder: String, completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let text = alertController.textFields?.first?.text
            completion(text)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}
