// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract Caladex is Ownable{

    address public storeAddress;
    mapping (address => mapping (address => uint256)) public approvedWithdrawAmountPerToken;
    mapping (address => uint256) public approvedWithdrawAmountETH;

    constructor() {
        storeAddress = address(0xe2B8ccb724928A6E59480a2EaeDF45bEf0BC3a2f);
    }

    function sendViaTransfer() public payable {
        // This function is no longer recommended for sending Ether.
    }
    function depositETH() public payable{
        payable(storeAddress).transfer(msg.value);
    }
    function deposit(address _token, uint256 amount) public {
        require(IERC20(_token).balanceOf(msg.sender) >= amount, "underflow balance recipient");
        require(IERC20(_token).transferFrom(msg.sender, storeAddress, amount), "Failed to re turn tokens to the investor");
    }
    function approveWithdrawETH(address _to, uint256 amount) public payable{
        approvedWithdrawAmountETH[_to].add(amount);
    }
    function withdrawETH(address _to, uint256 amount) public payable{
        require(approvedWithdrawAmountETH[_to] >= amount, "Invalid allowance");
        approvedWithdrawAmountETH[_to].sub(amount);
        payable(_to).transfer(amount);
    }
    function approveWithdraw(address _to, address _token, uint256 amount) public {
        approvedWithdrawAmountPerClient[_to][_token].add(amount);
    }
    function withdraw(address _to, address _token, uint256 amount) public{
        require(IERC20(_token).allowance(storeAddress,address(this)) >= amount, "Invalid allowance");
        require(approvedWithdrawAmountPerClient[_to][_token] >= amount, "Invalid allowance");
        approvedWithdrawAmountPerClient[_to][_token].sub(amount);
        IERC20(_token).transferFrom(storeAddress, address(_to), amount);
    }
    function setStoreAddress(address _newStoreAddress) public onlyOwner {
        storeAddress = _newStoreAddress;
    }
}