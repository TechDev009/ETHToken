//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;
//
// EIP-20: ERC-20 Token Standard Sample Implementation
//
interface ERC20Interface {
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function transfer(address to, uint tokens) external returns (bool success);
    
    function allowance(address tokenOwner, address payer) external view returns (uint remaining);
    function approve(address payer, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);
    
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed payer, uint tokens);
}


contract TestERC20Token is ERC20Interface{
    string public name = "TestERC20Token";
    string public symbol = "TE2T";
    uint public decimals = 18; 
    uint public override totalSupply;
    
    address public founder;
    mapping(address => uint) public balances;
    
    mapping(address => mapping(address => uint)) allowed;
    
    
    constructor(){
        totalSupply = 21000000;
        founder = msg.sender;
        balances[founder] = totalSupply;
    }
    
    
    function balanceOf(address tokenOwner) public view override returns (uint balance){
        return balances[tokenOwner];
    }
    
    
    function transfer(address to, uint tokens) public override returns(bool success){
        require(balances[msg.sender] >= tokens);
        
        balances[to] += tokens;
        balances[msg.sender] -= tokens;
        emit Transfer(msg.sender, to, tokens);
        
        return true;
    }
    
    
    function allowance(address tokenOwner, address payer) view public override returns(uint){
        return allowed[tokenOwner][payer];
    }
    
    
    function approve(address payer, uint tokens) public override returns (bool success){
        require(balances[msg.sender] >= tokens);
        require(tokens > 0);
        
        allowed[msg.sender][payer] = tokens;
        
        emit Approval(msg.sender, payer, tokens);
        return true;
    }
    
    
    function transferFrom(address from, address to, uint tokens) public override returns (bool success){
         require(allowed[from][msg.sender] >= tokens);
         require(balances[from] >= tokens);
         
         balances[from] -= tokens;
         allowed[from][msg.sender] -= tokens;
         balances[to] += tokens;
 
         emit Transfer(from, to, tokens);
         
         return true;
     }
}
