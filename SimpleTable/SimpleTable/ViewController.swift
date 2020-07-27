//
//  ViewController.swift
//  SimpleTable
//
//  Created by 지현우 on 2020/07/15.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    @IBOutlet weak var tableView : UITableView!
    let cellIdentifier : String = "cell"
    let customCellIdentifier : String = "customCell"
    
    let korean: [String] = ["가","나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"]
    let english: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N" , "O", "P", "Q", "R", "S","T","U","V","W","X","Y","Z"]
    
    var dates: [Date] = []
    
    let dateFormatter : DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    let timeFormatter : DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    @IBAction func touchUpAddButton(_ sender: UIButton){
        dates.append(Date())
        
        self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
        
//        self.tableView.reloadData() // 모든 세션 다 불러옴
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //섹션의 셀 갯수 리턴
        switch section {
               case 0:
                   return korean.count
               case 1:
                   return english.count
                case 2:
                    return dates.count
               default:
                   return 0
               }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀 내에 Text, 내용들 설정
        
       
        if indexPath.section < 2{
            let cell : UITableViewCell =
                       tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
                   
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            
            cell.textLabel?.text = text
            
            return cell
        }
        else{
            let cell: CustomTableViewCell =
                tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as! CustomTableViewCell
            
            cell.leftLabel.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            cell.rightLabel.text = self.timeFormatter.string(from: self.dates[indexPath.row])
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //섹션별로 헤더에 설명 추가
        
        if section < 2 {
            return section == 0 ? "한글" : "영어"
        }
        return nil
    }
    
    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
//        segue.identifier 로 여러 화면 중 1개로 선택 가능
        
        guard let nextViewController : SecondViewController
            = segue.destination as? SecondViewController
            else{
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else{
            return
        }
        
        nextViewController.textToSet = cell.textLabel?.text
        //nextViewController.textLabel.text = cell.textLabel?.text -> 안됨 , nextViewController의 인스턴스는 있지만 뷰는 생성되기 전이라서
        
    }
    
    
}

