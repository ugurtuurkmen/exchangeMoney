//
//  ViewController.swift
//  ExchangeMoney
//
//  Created by UgurTurkmen on 5.03.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var moneyList = [Money]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getMoney()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.salesLabel.text = moneyList[indexPath.row].satis
        cell.buylabel.text = moneyList[indexPath.row].alis
        cell.moneyName.text = moneyList[indexPath.row].name
        cell.differenceLabel.text = moneyList[indexPath.row].degisim
        if moneyList[indexPath.row].degisim.contains("-") {
            cell.differenceLabel.textColor = .red
        }else{
            cell.differenceLabel.textColor = .green
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moneyList.count
    }
    
    func getMoney(){
        
        let url = URL(string: "https://api.genelpara.com/embed/para-birimleri.json")
        
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                self.makeAlert(message: error?.localizedDescription ?? "Error")
            }else{
                
                if data != nil {
                 
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            
                            if let usd = jsonResponse["USD"] as? Dictionary<String,Any>{
                                if let alis = usd["alis"] as? String{
                                    
                                    if let satis = usd["satis"] as? String{
                                        
                                        if let degisim = usd["degisim"] as? String{
                                            let money = Money(name : "USD" , satis: satis, alis: alis, degisim: degisim)
                                            print(money)
                                            self.moneyList.append(money)
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                            if let eur = jsonResponse["EUR"] as? Dictionary<String,Any>{
                                if let alis = eur["alis"] as? String{
                                    
                                    if let satis = eur["satis"] as? String{
                                        
                                        if let degisim = eur["degisim"] as? String{
                                            let money = Money(name : "EUR", satis: satis, alis: alis, degisim: degisim)
                                            print(money)
                                            self.moneyList.append(money)
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                            if let btc = jsonResponse["BTC"] as? Dictionary<String,Any>{
                                if let alis = btc["alis"] as? String{
                                    
                                    if let satis = btc["satis"] as? String{
                                        
                                        if let degisim = btc["degisim"] as? String{
                                            let money = Money(name : "BTC", satis: satis, alis: alis, degisim: degisim)
                                            print(money)
                                            self.moneyList.append(money)
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                            if let eth = jsonResponse["ETH"] as? Dictionary<String,Any>{
                                if let alis = eth["alis"] as? String{
                                    
                                    if let satis = eth["satis"] as? String{
                                        
                                        if let degisim = eth["degisim"] as? String{
                                            let money = Money(name : "ETH", satis: satis, alis: alis, degisim: degisim)
                                            print(money)
                                            self.moneyList.append(money)
                                            self.tableView.reloadData()
                                        }
                                        
                                    }
                                    
                                }
                            }
                            print(self.moneyList.count)
                        }
                    }catch {
                        print("Error")
                    }
                }
            }
        }
        dataTask.resume()
        
        
        
    }

    
    func makeAlert(message : String) {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
        
    }
}

