import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var idTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        if let x = idTextFeild.text, let y = Int(x){
            addData(name: nameTextFeild.text!, id: y)
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        if let x = idTextFeild.text, let y = Int(x){
            deleteData(id: y)
        }
    }
    @IBAction func showButtonAction(_ sender: Any) {
        getData()
    } 
    
    func addData(name: String,id:Int) {
        
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDeleget.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Students", in: manageContext)
        let user = NSManagedObject(entity: userEntity!, insertInto: manageContext)
        user.setValue(name, forKey: "name")
        user.setValue(id, forKey: "id")
        print(user)
    }
    
    func updateData() {
        
    }
    
    func getData() {
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDeleget.persistentContainer.viewContext
        
        let fetchRequest = Students.fetchRequest()
        
        do{
            let result = try manageContext.fetch(fetchRequest)
            for data in result {
                print(data.name as! String,data.id)
            }
        }
        catch {
            print("Could not save.")
        }
    
    }
    
    func deleteData(id:Int) {
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDeleget.persistentContainer.viewContext
        let fatchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        fatchRequest.predicate = NSPredicate(format: "id = %d", id)
        
        do{
            let test = try manageContext.fetch(fatchRequest)
            let objToDelete = test[0] as! NSManagedObject
            manageContext.delete(objToDelete)
            appDeleget.saveContext()
            print("Data delete")
        }
        catch{
            print(error)
        }
        
    }
    
    func navigate() {
       
        let navigation = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        navigationController?.pushViewController(navigation, animated: true)
    }
    
}

