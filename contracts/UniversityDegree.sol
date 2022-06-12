// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract UniversityDegree is ERC721URIStorage  {
    using Counters for Counters.Counter;

    address owner;

    Counters.Counter private _tokenIds;

    constructor() ERC721("Soulbound Tokens", "SBTs") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    mapping(address => bool) public issuedDegrees;
    mapping(address => string) public personToDegree;

    function claimDegree(string memory tokenURI)
        public
        returns (uint256)
    {
        require(issuedDegrees[msg.sender], "Degree is not issued");

        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        personToDegree[msg.sender] = tokenURI;
        issuedDegrees[msg.sender] = false;

        return newItemId;
    }

    function checkDegreeOfPerson(address person) external view returns (string memory) {
        return personToDegree[person];
    }

    function issueDegree(address to) onlyOwner external {
        issuedDegrees[to] = true;
    }
}