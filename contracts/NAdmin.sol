pragma solidity ^0.4.23;

contract NAdmin {
    mapping (address => bool) internal admins;

    event AdminAdd(address indexed addedAddr);
    event AdminRemove(address indexed removedAddr);

    constructor() public {
        admins[msg.sender]=true;
    }

    modifier onlyAdmins() {
        require(isAdmin(msg.sender), "Admin rights required.");
        _;
    }

    /**
     * @dev Allows owner to add people to the whitelist.
     * @param _toAdd The address to be added to whitelist.
     */
    function addToAdmins(address _toAdd) onlyAdmins public {
        require(!isAdmin(_toAdd));
        emit AdminAdd(_toAdd);
        admins[_toAdd] = true;
    }

    function addToAdmins(address[] _toAdd) onlyAdmins public {
        for(uint256 i=0; i<_toAdd.length; i++){
            addToAdmins(_toAdd[i]);
        }
    }

    function removeFromAdmins(address _toRemove) onlyAdmins public {
        require(isAdmin(_toRemove));
        emit AdminRemove(_toRemove);
        admins[_toRemove] = false;
    }

    function removeFromAdmins(address[] _toRemove) onlyAdmins public {
        for(uint256 i=0; i<_toRemove.length; i++){
            removeFromAdmins(_toRemove[i]);
        }
    }

    function isAdmin(address _address) view public returns(bool) {
        return admins[_address];
    }
}
