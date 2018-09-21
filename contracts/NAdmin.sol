pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/ownership/rbac/RBAC.sol";

contract NAdmin is RBAC{
    string constant ADMIN_ROLE = "admin";

    constructor() public {
        addRole(msg.sender,ADMIN_ROLE);
    }

    modifier onlyAdmins() {
        require(hasRole(msg.sender,ADMIN_ROLE), "Admin rights required.");
        _;
    }

    /**
     * @dev Allows admins to add people to the admin list.
     * @param _toAdd The address to be added to admin list.
     */
    function addToAdmins(address _toAdd) onlyRole(ADMIN_ROLE) public {
        require(!isAdmin(_toAdd));
        addRole(_toAdd,ADMIN_ROLE);
    }

    function addToAdmins(address[] _toAdd) onlyRole(ADMIN_ROLE) public {
        for(uint256 i=0; i<_toAdd.length; i++){
            addToAdmins(_toAdd[i]);
        }
    }

    function removeFromAdmins(address _toRemove) onlyRole(ADMIN_ROLE) public {
        require(isAdmin(_toRemove));
        removeRole(_toRemove,ADMIN_ROLE);
    }

    function removeFromAdmins(address[] _toRemove) onlyRole(ADMIN_ROLE) public {
        for(uint256 i=0; i<_toRemove.length; i++){
            removeFromAdmins(_toRemove[i]);
        }
    }

    function isAdmin(address _address) view public returns(bool) {
        return hasRole(_address,ADMIN_ROLE);
    }
}
