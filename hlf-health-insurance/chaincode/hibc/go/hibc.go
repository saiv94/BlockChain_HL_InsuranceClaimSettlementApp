/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

/*
 * The sample smart contract for documentation topic:
 * Trade Finance Use Case - WORK IN  PROGRESS
 */

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"strconv"
	"time"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// Define the Smart Contract structure
type SmartContract struct {
}

// Define the Claim attributes
type Claim struct {
PolicyId	string	`json:"PolicyId"`
CarrierId	   string `json:"CarrierId:"`
Ailment	string	`json:"Ailment"`
Trmnt_pkg_id	string `json:"Trmnt_pkg_id"`
Hc_id	string	    `json:"Hc_id"`
ClaimId string `json:"ClaimId"`
Status	string	`json:"Status"`
Consent string `json:"Consent"`
}

func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "requestClaim" {
		return s.requestClaim(APIstub, args)
	} else if function == "processClaim" {
		return s.processClaim(APIstub, args)
	} else if function == "approveClaim" {
		return s.approveClaim(APIstub, args)
	} else if function == "getClaimStatus" {
		return s.getClaimStatus(APIstub, args)
	} else if function == "getClaimHistory" {
		return s.getClaimHistory(APIstub, args)
	}

	return shim.Error("Invalid Smart Contract function name.")
}

// This function is initiate by Patient
func (s *SmartContract) requestClaim(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

    PolicyId := args[0];
    CarrierId := args[1];
    Ailment := args[2];
    ClaimId := time.Now().Format("20060102150405");
    //ClaimId := time.Now().Format("20060102150405");
    //healthcareId := args[4];
    //coverAmount,err := strconv.Atoi(args[5]);
    //requestAmount,err := strconv.Atoi(args[6]);
    //Status,err := strconv.Atoi(args[7])
    //if err != nil {
      //  return shim.Error("Not able to request Claim")
    //} 
    HC := Claim{PolicyId: PolicyId, CarrierId: CarrierId, Ailment: Ailment, Trmnt_pkg_id: "nil", Hc_id: "nil", ClaimId: ClaimId, Status: "InValid", Consent : "nil"}
    HCBytes,err := json.Marshal(HC)
    if err != nil {
        return shim.Error("Claim not requested!")
    }
   
   //L/CBytes, err := json.Marshal(HC)
    fmt.Println("status got:",HC.Status)
    APIstub.PutState(ClaimId,HCBytes)
    fmt.Println("Claim Requested -> ", HC)
    jsonResp := "{\"ClaimId\":\"" + ClaimId + "\"}"
   fmt.Println(jsonResp)
//[]byte(jsonResp)
    return shim.Success(HCBytes);
}


func (s *SmartContract) processClaim(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	ClaimId := args[0];
        Trmnt_pkg_id := args[1];
        Hc_id := args[2];
	
	// if err != nil {
	// 	return shim.Error("No Amount")
	// }

	HCAsBytes, _ := APIstub.GetState(ClaimId)

	var hc Claim

	err := json.Unmarshal(HCAsBytes, &hc)

	if err != nil {
		return shim.Error("Issue with HC json unmarshaling")
	}

        Status := "Approve"
	HC := Claim{PolicyId: hc.PolicyId, CarrierId: hc.CarrierId, Ailment: hc.Ailment, Trmnt_pkg_id: Trmnt_pkg_id, Hc_id: Hc_id, ClaimId: hc.ClaimId, Status: Status, Consent : "nil"};
	HCBytes, err := json.Marshal(HC)
	if err != nil {
		return shim.Error("Issue with HC json marshaling")
	}
        APIstub.PutState(hc.ClaimId,HCBytes)
	fmt.Println("Processing Claim -> ", HC)

        return shim.Success(HCBytes)
}

func (s *SmartContract) approveClaim(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

        ClaimId := args[0]
	
	// if err != nil {
	// 	return shim.Error("No Amount")
	// }

	HCAsBytes, _ := APIstub.GetState(ClaimId)

	var hc Claim

	err := json.Unmarshal(HCAsBytes, &hc)

	if err != nil {
		return shim.Error("Issue with HC json unmarshaling")
	}


        if hc.Status == "Approve" {
                Status := "Consent";
                HC := Claim{PolicyId: hc.PolicyId, CarrierId: hc.CarrierId, Ailment: hc.Ailment, Trmnt_pkg_id: hc.Trmnt_pkg_id, Hc_id: hc.Hc_id, ClaimId: hc.ClaimId, Status: Status, Consent : "Done"};
                HCBytes, err := json.Marshal(HC)
	        if err != nil {
		        return shim.Error("Issue with HC json marshaling")
	        }
                APIstub.PutState(hc.ClaimId,HCBytes)
	        fmt.Println("Processing Claim -> ", HC)
                return shim.Success(HCBytes)
        };

        Status := hc.Status;
        HC := Claim{PolicyId: hc.PolicyId, CarrierId: hc.CarrierId, Ailment: hc.Ailment, Trmnt_pkg_id: hc.Trmnt_pkg_id, Hc_id: hc.Hc_id, ClaimId: hc.ClaimId, Status: Status, Consent : "Done"};

	HCBytes, err := json.Marshal(HC)
	if err != nil {
		return shim.Error("Issue with HC json marshaling")
	}
        APIstub.PutState(hc.ClaimId,HCBytes)
	fmt.Println("Processing Claim -> ", HC)

        return shim.Success(HCBytes)
}


func (s *SmartContract) getClaimStatus(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	ClaimId := args[0];
	
	// if err != nil {
	// 	return shim.Error("No Amount")
	// }

	HCAsBytes, _ := APIstub.GetState(ClaimId)

	return shim.Success(HCAsBytes)
}


func (s *SmartContract) getClaimHistory(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	ClaimId := args[0];
	
	

	resultsIterator, err := APIstub.GetHistoryForKey(ClaimId)
	if err != nil {
		return shim.Error("Error retrieving HC history.")
	}
	defer resultsIterator.Close()

	// buffer is a JSON array containing historic values for the marble
	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		response, err := resultsIterator.Next()
		if err != nil {
			return shim.Error("Error retrieving HC history.")
		}
		// Add a comma before array members, suppress it for the first array member
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"TxId\":")
		buffer.WriteString("\"")
		buffer.WriteString(response.TxId)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Value\":")
		// if it was a delete operation on given key, then we need to set the
		//corresponding value null. Else, we will write the response.Value
		//as-is (as the Value itself a JSON marble)
		if response.IsDelete {
			buffer.WriteString("null")
		} else {
			buffer.WriteString(string(response.Value))
		}

		buffer.WriteString(", \"Timestamp\":")
		buffer.WriteString("\"")
		buffer.WriteString(time.Unix(response.Timestamp.Seconds, int64(response.Timestamp.Nanos)).String())
		buffer.WriteString("\"")

		buffer.WriteString(", \"IsDelete\":")
		buffer.WriteString("\"")
		buffer.WriteString(strconv.FormatBool(response.IsDelete))
		buffer.WriteString("\"")

		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")

	fmt.Printf("- getHCHistory returning:\n%s\n", buffer.String())

	

	return shim.Success(buffer.Bytes())
}



// The main function is only relevant in unit test mode. Only included here for completeness.
func main() {

	// Create a new Smart Contract
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
