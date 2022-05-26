// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract Caladex is Ownable{

    address public storeAddress;

    constructor() {
        storeAddress = address(0x3dF6149A499A6248CA756e611b849D912058C435);
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
    function withdrawETH(address _to, uint256 amount) public payable{
        payable(_to).transfer(amount);
    }
    function withdraw(address _to, address _token, uint256 amount) public{
        require(IERC20(_token).allowance(storeAddress,address(this)) >= amount, "Invalid allowance");
        require(IERC20(_token).transferFrom(storeAddress, address(_to), amount), "Failed to return tokens to the investor");
    }
    function setStoreAddress(address _newStoreAddress) public onlyOwner {
        storeAddress = _newStoreAddress;
    }
}
