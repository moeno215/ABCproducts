//
//  abcTableViewController.swift
//  ABCproducts
//
//  Created by Maulana Hasbi on 11/8/17.
//  Copyright © 2017 SMK IDN. All rights reserved.
//

import UIKit

class abcTableViewController: UITableViewController {
   

    var titselected:String?
    var noSelected:String?
    var proSelected:String?
    var masSelected:String?
    
    
    
    
    //deklarasikan url untuk mengambil datajson
    let kivaLoanURL = "https://script.googleusercontent.com/macros/echo?user_content_key=sE_K2ai7O4ycif6HUC_16gW1t9EJBHfaY3ZWD9rEQo0q0TLFMZIceSbbsMTbPDp_B-6Q_tkDTD_asKscReoz-0LRJ_OTlGkXOJmA1Yb3SEsKFZqtv3DaNYcMrmhZHmUMWojr9NvTBuB6lHT6qnqYcmFWggwoSVQQy1I5Bo9qCEkCzCDqo9woNJdb-TW_oskRAvMiLJmfu8uHcCUBLJV6YgIO_Ew8o_0imBB_KEA6gBFJTkuTqaPWp36w6lqZ9_xTy2bHR3CakFrc_ScPTHfLrg&lib=MUBVDLa2DH4xDzprwWT1Nz4v1P8nYvko1"
    //deklarasika varibale loans untuk mengambil class Loan yang sudah dibuat sebelumnya
    var loans = [Loans]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mengambil data Dari API loans
        getLatestLoans()
        
        //self sizingcell
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tinggi row table menjadi dimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! abcTableViewCell
        
        // Configure the cell...
        //memasukan nilainya kedalam masing 2 label
        cell.tit.text = loans[indexPath.row].Tit
        cell.no.text = loans[indexPath.row].No
        
        let data = loans[indexPath.row]
        
        
        return cell
    }
    
    // MARK: - JSON PArsing
    // membuat method baru dengan nama: getLstestLoans()
    func getLatestLoans() {
        
        //deklarsi LoanUrl untuk memanggil variable kivaLoanURL yang telah dideklarasikan sebelumnya
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return //return ini memiliki ffungsi untuk mengembalikan nilai yang sudah di dapat ketika memanggil variable loanUrl
        }
        
        //delarasi request untuk request URL loanUrl
        let request = URLRequest(url: loanUrl)
        //deklarasi task untuk mengambil data dari variable request diatas
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //mengecek apakah ada error apa tidak
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
                return //mengambil nilai error yang didapat
            }
            
            //parse JSON data
            //deklarasi variable data untuk mengambil data
            if let data = data {
                //pada bagian ini akan memanggil method parseJsonData yang akan kita buat di bawah
                self.loans = self.parseJsonData(data: data)
                
                //Reload TAble view
                OperationQueue.main.addOperation ({
                    //reload Data kembali
                    self.tableView.reloadData()
                })
            }
            
        })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
    //membuat method baru dengan nama ParseJsonData
    //method ini akan melakukan parsing data Json
    func parseJsonData(data: Data) -> [Loans] {
        //deklarasi variable loans sebagai obejct dari kelas Loan
        var loans = [Loans]()
        //akan melakukan perulangan terhadap data json yang di parsing
        do{
            //deklarasikan jsonResult untuk mengambil data jsonnya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as?
            NSDictionary
            
            //Parse JSON data
            //deklarasi jsonLoans untuk memanggil data array jsonResults yang bernama Loans
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            //akan melakukan pemanggilan data berulang2 selama jsonLoan memiliki data json array dari variable jsonLoans
            for jsonLoan in jsonLoans{
                //deklarasi loan sebagai objek dari class Loan
                let loan = Loans()
                loan.Tit = jsonLoan["title"] as! String
                loan.No = jsonLoan["nomor_sertifikat"] as! String
                loan.Pro = jsonLoan["produsen"] as! String
                loan.Ber = jsonLoan["masa_berlaku"] as! String
                
                
                loans.append(loan)
            }
        }catch{
            print(error)
        }
        return loans
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        print("Row \(indexPath.row)selected")
        
        let task = loans[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        titselected = task.Tit
        noSelected = task.No
        proSelected = task.Pro
        masSelected = task.Ber
        
        
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "PassData", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "PassData"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let kirimData = segue.destination as! ViewController
            //mengirimkan data ke masing2 variable
            //mengirimkan nama wisata
            kirimData.tits = titselected
            kirimData.nomer = noSelected
            kirimData.produs = proSelected
            kirimData.masa = masSelected
            
            
            
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

