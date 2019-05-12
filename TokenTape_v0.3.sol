
// Copyright (c) 2019 NandemoToken
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

pragma solidity ^0.5.2;

import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";


contract TokenTape is ERC721Full  {

address manager;

    mapping (uint256 => string) public ownerinfo;
    address free = 0x1111111111111111111111111111111111111111;

    constructor(
        string memory name, 
        string memory symbol
    )
        ERC721Full(name, symbol)
        public
    {
       manager = msg.sender;
    }


    modifier onlyManager{
        require(msg.sender == manager);
        _;
    }
    
    modifier onlyFree(uint256 _tokenId){
        require(ownerOf(_tokenId) == free);
        _;
    }

       function newToken()  public onlyManager {
        _mint(free, totalSupply() + 1 );
        }

    function transferFrom_forRegister(address from, address to, uint256 tokenId) internal {
        _transferFrom(from, to, tokenId);
    }
       
       function firstOwnerRegister(uint256 _tokenId ) public  onlyFree(_tokenId) {
           transferFrom_forRegister(free , msg.sender , _tokenId );
       }
       
}
