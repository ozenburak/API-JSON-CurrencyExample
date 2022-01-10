//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by burak ozen on 6.08.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        //        -----3 adımda url çekme işlemini yapıyoruz------
        //        1) request and session --- sitedeki bilgileri apilerin yani çekilmesi işi--istek yollamak
        //        2) response or data ---- bu isteği almak
        //        3) Parsing or JSON serialization ---- bu datayı işlemek
                
        //       ----- 1) -----
        
        
        // 1.
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=870579b2b71d26836c7663b269257fea")
        //        session açmamız gerekiyo
        let session = URLSession.shared
        //        bu func çağırıyorum ve bu bana bi çıktı veriyo çıktıyı bir closure içinde veriyo
                
        //Closure
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                // normalde error mesajı olarak string girmemiz gerek ama zaten closure içerisinde error hatası vereceği için onu tanımladıgımız error ile "error?.localizedDescription" dediğimizde kayıtlı olan mesajı paylaşıyo.
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                //               ----- 2) ----
                // 2.
                if data != nil {
                    //                    burada değiştirilebilir caontainers ı seçmemiz gerekmekte. bunu do try catch içerisinde yapmaya bizi zorlamakta
                    do {
                        //                        burada castetmemiz gerek çünkü jsonResponse any olarak geliyo oyle gelememsi için öncelikle Dictionary<String, Any> sözlük olarak cast ediyoruz. cunku çekeceğimiz değerler strinten any e gidiyo. yani anahtar kelimeler sting ama karsınıa gelecek degerlerin yapısı ne onları bilmiyoruz o yuzden any diyoruz 2. bolume yani string to any .
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        //                        ASYNC -- arka pland bu inidirenler main threat içerisinde tekrardan guncellenmesi gerekmekte. olay tamamen main threatte yapılması gerektiği ile ilgili
                                                
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                //print(rates)
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                                
                                
                            }
                        }
                        
                        
                    } catch {
                       print("error")
                    }
                    
                }
                
                
            }
        }
        //        resume yapmamız gerkmekte cunku taskı olusturdugumuz gibi calısmaya baslicak task dısında resume etmemiz gerekmekte.
        task.resume()
        
        
    }
    

}

