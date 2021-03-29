actor ERC721{
    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    public query func balanceOf(_owner : Principal) : async Nat {
        switch (balances.get(_owner)) {
            case (?balance) {
                return balance;
            };
            case (_) {
                return 0;
            };
        }
    };

    public query func ownerOf(_tokenId : Principal) : async Principal {
        
    }

    public shared(msg) func safeTransferFrom(_from : Principal, _to : Principal, _tokenId : Nat, _data : bytes) {

    }

    public shared(msg) func transferFrom(_from : Principal, _to : Principal, _tokenId : Nat) {

    }

    public shared(msg) func approve(_approved : Principal, _tokenId : Nat) {

    }

    public query func getApproved(_tokenId : Nat) : async Principal {

    }

    public 

};
