pragma solidity ^0.4.24;

interface IInvokeOracle{
    function requestData(address _caller) external returns (bytes32 requestId);
    function showPrice() external view returns(uint256);
    function showLatestPrice(bytes32 _requestId) external view returns(uint256);
}

contract CustomerContract{
    address CONTRACTADDR = paste_internal_contract_address_here;
    bytes32 public requestId; 
    address private owner;
    constructor() public {
        owner = msg.sender;
    }
    //Fund this contract with sufficient PLI, before you trigger below function. 
    //Note, below function will not trigger if you do not put PLI in above contract address
    function getPriceInfo() external returns(bytes32){
        require(msg.sender==owner,"Only owner can trigger this");
        (requestId) = IInvokeOracle(CONTRACTADDR).requestData({_caller:msg.sender}); 
        return requestId;
    }
    //TODO - you can customize below function as you want, but below function will give you the pricing value
    //This function will give you last stored value in the contract
    function show() external view returns(uint256){
        return IInvokeOracle(CONTRACTADDR).showPrice();
    }

    function showPriceOnRequestId(bytes32 _requestId) external view returns(uint256){
        return IInvokeOracle(CONTRACTADDR).showLatestPrice(_requestId);
    }

}