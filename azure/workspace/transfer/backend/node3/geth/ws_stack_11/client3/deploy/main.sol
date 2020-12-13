pragma solidity >= 0.4 .21 < 0.6 .0;
pragma experimental ABIEncoderV2;

// Contract to Handle the Permission Level Consensus
//66

contract main {

    uint public maintxsetcounter = 0;
    
    uint public secondtxsetcounter = 0;
    
    uint public thirdtxsetcounter = 0;
   
    mapping (uint => uint) public firstmap;
    
    mapping (uint => uint) public secondmap;
    
    mapping (uint => uint) public thirdmap;
    
    uint public firstmap_firstcounter = 0;
    
    uint public secondmap_firstcounter = 0;
    
    uint public thirdmap_firstcounter = 0;
    



     //***PUBLIC METHOD ***
    function addTest(uint metadata) public returns(uint) {
        maintxsetcounter = maintxsetcounter+1;
        secondtxsetcounter = secondtxsetcounter+1;
        thirdtxsetcounter = thirdtxsetcounter+1;
        return maintxsetcounter;
    }
    
         //***PUBLIC METHOD ***
    function readAdd() public view returns(uint) {
        return maintxsetcounter;
    }
    
     //***PUBLIC METHOD ***
    function firstMapTest(uint first_value) public {
        firstmap[firstmap_firstcounter] = first_value;
        firstmap_firstcounter = firstmap_firstcounter+1;
    }
    
         //***PUBLIC METHOD ***
    function readFirstMap() public view returns(uint) {
        return firstmap[firstmap_firstcounter-1];
    }
    
    //function heavy payload
     //***PUBLIC METHOD ***
    function secondMapTest(uint first_value, uint scnd_value) public {
        firstmap[firstmap_firstcounter] = first_value;
        firstmap_firstcounter = firstmap_firstcounter+1;
        secondmap[secondmap_firstcounter] = scnd_value;
        secondmap_firstcounter = secondmap_firstcounter+1;
        
    }
    
         //***PUBLIC METHOD ***
    function readSecondMap() public view returns(uint) {
        return secondmap[secondmap_firstcounter-1];
    }
    
     //function heavy payload
     //***PUBLIC METHOD ***
    function thirdMapTest(uint first_value, uint scnd_value, uint thrd_value) public {
        firstmap[firstmap_firstcounter] = first_value;
        firstmap_firstcounter = firstmap_firstcounter+1;
        secondmap[secondmap_firstcounter] = scnd_value;
        secondmap_firstcounter = secondmap_firstcounter+1;
        thirdmap[thirdmap_firstcounter] = thrd_value;
        thirdmap_firstcounter = thirdmap_firstcounter+1;
        
    }
    
         //***PUBLIC METHOD ***
    function readThirdMap() public view returns(uint) {
        return thirdmap[thirdmap_firstcounter-1];
    }
    
    function getCounter() public view returns(uint) {
        return firstmap_firstcounter;
    }
 
 



}

