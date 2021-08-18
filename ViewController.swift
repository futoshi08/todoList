import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var todolist : [String] = []
    
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let astored = userDefaults.array(forKey: "todoList") as? [String] {
            todolist.append(contentsOf: astored)
        }
    }

    
    @IBAction func addBtnAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "TODO", message: "todoを追加してください", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {(action:UIAlertAction) in
            
            if let textField = alert.textFields?.first {
                self.todolist.insert(textField.text!, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
                
                self.userDefaults.set(self.todolist, forKey: "todoList")
            }
        }
        alert.addAction(okAction)
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let title = todolist[indexPath.row]
        cell.textLabel?.text = title

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todolist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            
            userDefaults.set(todolist, forKey: "todoList")
        }
    }

}

