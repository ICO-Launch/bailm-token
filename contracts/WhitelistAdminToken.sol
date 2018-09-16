
pragma solidity ^0.4.23;

import "./Controller.sol";
import "./WhitelistedAdmin.sol";

/**
 * @title Whitelist and Admin token
 * @dev ILM token modified with whitelist and Admin list functionalities.
 **/
contract WhitelistAdminToken is Controller, WhitelistedAdmin {

    function transfer(address _to, uint256 _value) public onlyWhitelisted returns(bool) {
      require(isWhitelisted(_to), "Destination not whitelisted.");
      return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
      require(isWhitelisted(_from), "Source not whitelisted.");
      require(isWhitelisted(_to), "Destination not whitelisted.");
      return super.transferFrom(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public onlyWhitelisted returns (bool) {
      require(isWhitelisted(_spender), "Destination not whitelisted.");
      return super.approve(_spender, _value);
    }

}
