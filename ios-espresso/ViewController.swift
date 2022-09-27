//
//  ViewController.swift
//  ios-espresso
//
//  Created by Aurelio Figueredo on 2022-09-25.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getArticles()
        getArticlesWithAlamofire()
        getArticlesWithAlamofireOtherWay()
        getFirestoreMembers()
        button.setTitle("ole", for: .normal)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    func getArticles() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0984a24637d8469a96b90b2751eb0b72")!
        let resource = Resource<ArticleList>(url: url)
        
        let articleResource = Article.all
        EspressoService().load(resource: resource) { result in
            switch result {
            case .success(let list):
                print(list)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getArticlesWithAlamofire() {
        let resource = Article.all
        EspressoServiceAlamofire().fetch(resource: resource) { result in
            switch result {
            case .success(let list):
                print(list)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getArticlesWithAlamofireOtherWay() {
        let resource = Article.all
        let url = resource.url
        EspressoServiceAlamofire().fetchOtherWay(url: url, completion: { response in
            switch response {
            case .success(let list):
                print(list)
            case .failure(let error):
                print(error)
            }
            
        })
    }
    
    func getFirestoreMembers() {
        let firestore = Firestore.firestore()
        firestore.collection("MEMBERS").getDocuments { querySnapshot, error in
            if let error = error {
                print(error)
            }
            
            
            if let documents = querySnapshot?.documents {
                let objects = documents.compactMap { document  in
                    return Miembros(photo: document.data()["photo"] as? String, type: document.data()["type"] as? String, id_member: document.data()["id_member"] as? String, name: document.data()["name"] as? String, is_defaulter: document.data()["is_defaulter"] as? Int, surname: document.data()["surname"] as? String, created_by: document.data()["created_by"] as? String)
                }
                print(objects)
            }
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        if sender == button {
            
        }
    }
    
    @IBAction func clickOnButton(_ sender: Any) {
//        performSegue(withIdentifier: "toSecondViewController", sender: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewControllerID") as! SecondViewController
        viewController.titleString = "Hola Roshka Push"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondViewController" {
            if let viewController = segue.destination as? SecondViewController{
                viewController.titleString = "Hola Roshka"
            }
        }
    }
}


