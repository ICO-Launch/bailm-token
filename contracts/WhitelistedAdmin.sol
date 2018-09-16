pragma solidity ^0.4.23;

import './NAdmin.sol';

contract WhitelistedAdmin is NAdmin {
    string constant WLST_ROLE = "whitelist";

    constructor() public {
        addRole(msg.sender,WLST_ROLE);
    }

    modifier onlyWhitelisted() {
        require(hasRole(msg.sender,WLST_ROLE), "Whitelist rights required.");
        _;
    }

    /**
     * @dev Allows admins to add people to the whitelist.
     * @param _toAdd The address to be added to whitelist.
     */
    function addToWhitelist(address _toAdd) onlyRole(ADMIN_ROLE) public {
        require(!isWhitelisted(_toAdd));
        addRole(_toAdd,WLST_ROLE);
    }

    function addToWhitelist(address[] _toAdd) onlyRole(ADMIN_ROLE) public {
        for(uint256 i=0; i<_toAdd.length; i++){
            addToWhitelist(_toAdd[i]);
        }
    }

    function removeFromWhitelist(address _toRemove) onlyRole(ADMIN_ROLE) public {
        require(isWhitelisted(_toRemove));
        removeRole(_toRemove,WLST_ROLE);
    }

    function removeFromWhitelist(address[] _toRemove) onlyRole(ADMIN_ROLE) public {
        for(uint256 i=0; i<_toRemove.length; i++){
            removeFromWhitelist(_toRemove[i]);
        }
    }

    function isWhitelisted(address _address) view public returns(bool) {
        return hasRole(_address,WLST_ROLE);
    }
}
