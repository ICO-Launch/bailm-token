
pragma solidity ^0.4.23;

import "./Controller.sol";
import "./WhitelistedAdmin.sol";

/**
 * @title Whitelist and Admin token
 * @dev ILM token modified with whitelist and Admin list functionalities.
 **/
contract WhitelistAdminToken is Controller, WhitelistedAdmin {

    /**
     * @dev Only whitelisted can transfer tokens, and only to whitelisted addresses
     * @param _to The address where tokens will be sent to
     * @param _value The amount of tokens to be sent
     */
    function transfer(address _to, uint256 _value) public onlyWhitelisted returns(bool) {
        //If the destination is not whitelisted, try to add it (only admins modifier)
        if(!isWhitelisted(_to)) addToWhitelist(_to);
        return super.transfer(_to, _value);
    }

    /**
     * @dev Only whitelisted can transfer tokens, and only to whitelisted addresses. Also, the msg.sender will need to be approved to do it
     * @param _from The address where tokens will be sent from
     * @param _to The address where tokens will be sent to
     * @param _value The amount of tokens to be sent
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        //If the source is not whitelisted, try to add it (only admins modifier)
        if(!isWhitelisted(_from)) addToWhitelist(_from);
        //If the destination is not whitelisted, try to add it (only admins modifier)
        if(!isWhitelisted(_to)) addToWhitelist(_to);
        return super.transferFrom(_from, _to, _value);
    }

    /**
     * @dev Allow others to spend tokens from the msg.sender address. The spender should be whitelisted
     * @param _spender The address to be approved
     * @param _value The amount of tokens to be approved
     */
    function approve(address _spender, uint256 _value) public onlyWhitelisted returns (bool) {
        //If the approve spender is not whitelisted, try to add it (only admins modifier)
        if(!isWhitelisted(_spender)) addToWhitelist(_spender);
        return super.approve(_spender, _value);
    }

}
