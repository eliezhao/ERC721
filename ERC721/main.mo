import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

actor ERC721 {

    //owner addr_ - number_of_NFT map
    private var assets = HashMap.HashMap<Principal, Nat>(10, Principal.equal, Principal.hash);
    
    //NFT_addr_  - Owner    map
    private var NFT_Owner = HashMap.HashMap<Principal, Principal>(10, Principal.equal, Principal.hash); 

    //NFT Operators
    private var NFT_Operators = HashMap.HashMap<Principal, HashMap.HashMap<Principal, Bool>>(10, Principal.equal, Principal.hash);

    //Approve for all map
    private var delegates = HashMap.HashMap<Principal, HashMap.HashMap<Principal, Bool>>(10, Principal.equal, Principal.hash);

    //Token name
    private let name : Text = "";

    //Token symbol
    private let symbol : Text = "";

    //Token URI
    private var NFT_URI : HashMap.HashMap<Principal, Text>(10, Principal.equal, Principal.hash);

    public query func name() : async Text{
        name;
    }

    public query func symbol() : async Text{
        symbol;
    }

    public query func tokenURI(_tokenId : Principal) : async ?Text{
        NFT_URI.get(_tokenId)
    }

    public query func balanceOf(addr_ : Principal) : async ?Nat{
        if Principal.equal(addr_, 0) {
            null;
        };

        switch (assets.get(addr_)){
            case (?number){
                ?number;
            };
            case (_){
                null;
            };
        };
    }; 

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    public query func ownerOf(Token_Id : Principal) : async ?Principal{
        switch (NFT_Owner.get(Token_Id)) {
            case(?addr_) {
                ?addr_;
            };
            case(_){
                null;
            };
        };
    };

    //function transferFrom
    //(address _from, address _to, uint256 _tokenId)
    public shared(msg) func TransferFrom(_from : Principal, _to : Principal, _tokenId : Principal) : async Bool{
        // only operator of NFT can transfer the NFT
        assert(NFT_Operators.get(_tokenId).get(msg.caller) | Principal.equal(delegates.get(ownerOf(_tokenId)).get(msg.caller)));
        switch(NFT_Owner.replace(_tokenId, _to)) {
            case(?addr_){
                true;
            };
            case(null){
                false;
            };
        };
        NFT_Operators.get(_tokenId).delete(_from);
        assets.replace(_to, assets.get(_approved)+1);        
        assets.replace(msg.caller, assets.get(msg.caller)-1);
    }; 



    public shared(msg) func approve(_approved : Principal, _tokenId : Principal) {
        assert(NFT_Operators.get(_tokenId).get(msg.caller) | Principal.equal(delegates.get(ownerOf(_tokenId)).get(msg.caller)));
        //should judge if the _approved in the hashmap <false> 
        NFT_Operators.get(_tokenId).put(_approved, true);
    }


    public shared(msg) func setApprovalForAll(_operator : Principal, _approved : Bool) : async Bool{        
        delegates.get(msg.caller).put(_operator, _approved);
    }

    public query func getApproved(_tokenID : Principal) : async Principal{
        
    }

    public query func isApprovedForAll(_owner : Principal, _operator : Principal) : async Bool{
        delegates.get(owner).get(_operator);
    }

};


    public 

};
