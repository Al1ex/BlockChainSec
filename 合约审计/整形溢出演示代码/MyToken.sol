pragma solidity ^0.4.10;

contract MyToken {
    mapping (address => uint) balances;
        
    function balanceOf(address _user) returns (uint) { 
        return balances[_user]; 
        
    }
    function deposit() payable { 
        balances[msg.sender] += msg.value;           // 存在整数溢出
        
    }
    function withdraw(uint _amount) {
        require(balances[msg.sender] - _amount > 0);  // 存在整数溢出
        msg.sender.transfer(_amount);
        balances[msg.sender] -= _amount;
    }
}