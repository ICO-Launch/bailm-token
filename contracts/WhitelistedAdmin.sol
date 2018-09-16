pragma solidity ^0.4.23;

import './NAdmin.sol';

contract WhitelistedAdmin is NAdmin {
    mapping (address => bool) internal whitelist;

    event WhitelistAdd(address indexed addedAddr);
    event WhitelistRemove(address indexed removedAddr);

    modifier onlyWhitelisted() {
        require(isWhitelisted(msg.sender), "You are not whitelisted.");
        _;
    }

    constructor() public {
        whitelist[msg.sender]=true;
    }

    /**
     * @dev Allows owner to add people to the whitelist.
     * @param _toAdd The address to be added to whitelist.
     */
    function addToWhitelist(address _toAdd) onlyAdmins public {
        require(!isWhitelisted(_toAdd));
        emit WhitelistAdd(_toAdd);
        whitelist[_toAdd] = true;
    }

    function addToWhitelist(address[] _toAdd) onlyAdmins public {
        for(uint256 i=0; i<_toAdd.length; i++){
            addToWhitelist(_toAdd[i]);
        }
    }

    function removeFromWhitelist(address _toRemove) onlyAdmins public {
        require(isWhitelisted(_toRemove));
        emit WhitelistRemove(_toRemove);
        whitelist[_toRemove] = false;
    }

    function removeFromWhitelist(address[] _toRemove) onlyAdmins public {
        for(uint256 i=0; i<_toRemove.length; i++){
            removeFromWhitelist(_toRemove[i]);
        }
    }

    function isWhitelisted(address _address) view public returns(bool) {
        return whitelist[_address];
    }
}
