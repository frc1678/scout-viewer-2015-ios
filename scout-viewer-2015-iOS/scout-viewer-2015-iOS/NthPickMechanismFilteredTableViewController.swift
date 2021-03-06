//
//  NthPickMechanismFilteredTableViewController.swift
//  scout-viewer-2015-iOS
//
//  Created by Citrus Circuits on 2/22/15.
//  Copyright (c) 2015 Citrus Circuits. All rights reserved.
//

import UIKit

class NthPickMechanismFilteredTableViewController: ArrayTableViewController {
    
    var order = 2
    var landfill = false
    
    let orderMap = [1 : "first", 2 : "second", 3 : "third"]
    
    override func configureCell(cell: UITableViewCell!, atIndexPath path: NSIndexPath!, forData data: AnyObject!, inTableView tableView: UITableView!) {
        let team = data as! Team
        
        let mechCell = cell as! MechanismTableViewCell
        mechCell.rankLabel.text = "\(ScoutDataFetcher.rankOfTeam(team, withCharacteristic: getKeyFromOrder()))"
        mechCell.teamLabel.text = "\(team.number)"
        mechCell.easeLabel.text = "Ease: \(team.uploadedData.easeOfMounting)"
        mechCell.programmingLanguageLabel.text = team.uploadedData.programmingLanguage.isEmpty ? "???" : team.uploadedData.programmingLanguage
        mechCell.scoreLabel.text = roundValue(team.valueForKeyPath(getKeyFromOrder())!, toDecimalPlaces: 2)
    }
    
    override func loadDataArray(shouldForce: Bool) -> [AnyObject]! {
        let descriptor = NSSortDescriptor(key: getKeyFromOrder(), ascending: false)
        let returnData = ScoutDataFetcher.fetchAndFilterMechansimTeamsByDescriptor(descriptor)
        
        return returnData
    }
    
    override func cellIdentifier() -> String! {
        return "MechanismTableViewCell"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let
            dest = segue.destinationViewController as? TeamDetailsTableViewController,
            teamNum = (sender as? MechanismTableViewCell)?.teamLabel?.text?.toInt(),
            mechCell = sender as? MechanismTableViewCell
        {
            if let team = ScoutDataFetcher.fetchTeam(teamNum) where team.seed > 0 {
                dest.data = ScoutDataFetcher.fetchTeam(teamNum)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("TeamDetails", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    func getKeyFromOrder() -> String {
        if landfill {
            return "calculatedData.\(orderMap[order]!)PickAbilityLandfill"
        } else {
            return "calculatedData.\(orderMap[order]!)PickAbility"

        }
    }
    
    override func filteredArrayForSearchText(text: String!, inScope scope: Int) -> [AnyObject]! {
        return dataArray.filter(checkIfTeamBeginsWith(text))
    }
    
    func checkIfTeamBeginsWith(string: String)(team: AnyObject) -> Bool {
        return "\(team.number)".rangeOfString(string)?.startIndex == "\(team.number)".rangeOfString("\(team.number)")?.startIndex
    }
}
