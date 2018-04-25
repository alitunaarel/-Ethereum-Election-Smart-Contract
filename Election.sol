pragma solidity ^0.4.0;

contract Election{
    
    struct Candidate {
        string name;
        uint voteCount;
    }
    
    struct Voter {
        bool voted;
        uint voteIndex;
    }
    
    address public owner;
    string public name;
    mapping(address => Voter) public voters;
    Candidate[] public Candidates;
    uint public auctionEnd;
    
    event ElectionResult(string name,uint voteCount);
    
    function Election(string _name, uint durationMinutes,string candidate1, string candidate2){
     owner = msg.sender;
     name = _name;
     auctionEnd = now + (durationMinutes * 1 minutes);
     candidates.push(candidate(candidate1, 0));
     candidates.push(candidate(candidate2, 0)); 
    }
    
    function authorize(address voter) {
        require(msg.sender == owner);
        require(!voters[voter].voted);
        
        voters[voter].weight = 1;
    }
    function vote(uint voteIndex) {
        require(now < auctionEnd);
        require(!voters[msg.sender].voted);
        
        candidates[voteIndex].voteCount += voters[msg.sender].weight;
        
    }
    function end(){
        require(msg.sender == owner);
        require(now >= auctionEnd);
        
        for(uint i=0; i < candidates.length; i++){
            ElectionResult(candidates[i].name, candidates[i].voteCount);
        }
    }
}