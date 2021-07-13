pragma solidity ^0.4.10;

contract IDMoney {
    address owner;
    mapping (address => uint256) balances;  // 记录每个打币者存入的资产情况

    event withdrawLog(address, uint256);
    
    function IDMoney() { owner = msg.sender; }
    function deposit() payable { 
        balances[msg.sender] += msg.value; 
    }
    function withdraw(address to, uint256 amount) {
        require(balances[msg.sender] > amount);
        require(this.balance > amount);

        withdrawLog(to, amount);  // 打印日志，方便观察 reentrancy
        
        to.call.value(amount)();  // 使用call.value()() 进行ether转币时，默认会发所有的Gas给外部
        balances[msg.sender] -= amount;
    }
    function balanceOf() returns (uint256) { 
        return balances[msg.sender]; 
    }
    function balanceOf(address addr) returns (uint256) { 
        return balances[addr]; 
    }
}