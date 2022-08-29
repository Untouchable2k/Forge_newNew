// ForgeTH - Contract
//
// Distrubtion of Forge Token is as follows:
// 15% of Forge Token is Auctioned in the ForgeAuctions Contract which distributes tokens to users who use 0xBitcoin to buy tokens in fair price. Each auction lasts ~3 days. Using the Auctions contract
// +
// 57% of Forge Token is distributed as Liquidiy Pool rewards in the ForgeRewards Contract which distributes tokens to users who deposit the SpiritSwap Liquidity Pool tokens into the LPRewards contract.
// +
// 29% of Forge Token is distributed using Forge Contract(this Contract) which distributes tokens to users by using Proof of work. Computers solve a complicated problem to gain tokens!
//
// = 100% Of the Token is distributed to the users! No dev fee or premine!
//
// All distributions happen fairly using Bitcoins model of distribution using reward halvings and difficulty adjustments.  Distribution happens over 100 years!  
// 100%  on-chain, decentralized, trustless, ownerless contracts*!
//   The harder it is mined the less tokens that are awarded.
// Network: Polygon Chain 
// ChainID = 89
//
//
// Name: Forge
// Symbol: Fge
// Decimals: 18 
//
// Total supply: 73,500,001.000000000000000000
//   =
// 21,000,000 Mined over 100+ years using Bitcoins Distrubtion halvings every 4 years. Uses Proof-oF-Work to distribute the tokens. Public Miner is available.  Uses this contract.
//   +
// 10,500,000 Auctioned over 100+ years into 4 day auctions split fairly among all buyers. ALL 0xBitcoin proceeds go into THIS contract which it fairly distributes to miners.  Uses the ForgeAuctions contract
//   +
// 42,000,000 tokens goes to Liquidity Providers of the token over 100+ year using Bitcoins distribution!  Helps prevent LP losses!  Uses the ForgeRewards Contract
//
//  =
//
// 73,500,001 Tokens is the max Supply
//      
// 50% of the Ethereum from this contract goes to the Miner to pay for the transaction cost and if the token grows enough earn Ethereum per mint!!
// 50% of the Ethereum from this contract goes to the Liquidity Providers via ForgeRewards Contract.  Helps prevent Impermant Loss! Larger Liquidity!
//
// No premine, dev cut, or advantage taken at launch. Public miner available at launch.  100% of the token is given away fairly over 100+ years using Bitcoins model!
//
// Send this contract any ERC20 token and it will become instantly mineable and able to distribute using proof-of-work for 1 year!!!!
//
//Viva la Mineables!!! Send this contract any ERC20 complient token (Wrapped NFTs incoming!) and we will fairly to miners and Holders(
//  Each Mint prints (1/10000) of any ERC20.
//* 1 tokens in LP are burned to create the LP pool.
//
// Credits: 0xBitcoin, Vether, Synethix


pragma solidity ^0.8.11;

contract Ownable {
    address public owner;

    event TransferOwnership(address _from, address _to);

    constructor() public {
        owner = msg.sender;
        emit TransferOwnership(address(0), msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    function setOwner(address _owner) internal onlyOwner {
        emit TransferOwnership(owner, _owner);
        owner = _owner;
    }
}




library IsContract {
    function isContract(address _addr) internal view returns (bool) {
        bytes32 codehash;
        /* solium-disable-next-line */
        assembly { codehash := extcodehash(_addr) }
        return codehash != bytes32(0) && codehash != bytes32(0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470);
    }
}

// File: contracts/utils/SafeMath.sol

library SafeMath2 {
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 z = x + y;
        require(z >= x, "Add overflow");
        return z;
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256) {
        require(x >= y, "Sub underflow");
        return x - y;
    }

    function mult(uint256 x, uint256 y) internal pure returns (uint256) {
        if (x == 0) {
            return 0;
        }

        uint256 z = x * y;
        require(z / x == y, "Mult overflow");
        return z;
    }

    function div(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y != 0, "Div by zero");
        return x / y;
    }

    function divRound(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y != 0, "Div by zero");
        uint256 r = x / y;
        if (x % y != 0) {
            r = r + 1;
        }

        return r;
    }
}

// File: contracts/utils/Math.sol

library ExtendedMath2 {


    //return the smaller of the two inputs (a or b)
    function limitLessThan(uint a, uint b) internal pure returns (uint c) {

        if(a > b) return b;

        return a;

    }
}

// File: contracts/interfaces/IERC20.sol

interface IERC20 {
	function totalSupply() external view returns (uint256);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    function transfer(address _to, uint _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function balanceOf(address _owner) external view returns (uint256 balance);
    
}



interface IERC721 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

//Main contract

contract ArbiForge is Ownable, IERC20 {
	uint constant public targetTime = 60 * 6;
    uint public multipler = 0;
// SUPPORTING CONTRACTS
    address public AddressAuction;
    address public AddressLPReward;
    address public AddressZeroXBTC;
//Events
    using SafeMath2 for uint256;
    using ExtendedMath2 for uint;
    event Mint(address indexed from, uint reward_amount, uint epochCount, bytes32 newChallengeNumber);
    event MegaMint(address indexed from, uint epochCount, bytes32 newChallengeNumber, uint NumberOfTokensMinted, uint256 TokenMultipler);

// Managment events
    uint256 override public totalSupply = 73500001000000000000000000;
    bytes32 private constant BALANCE_KEY = keccak256("balance");

    //BITCOIN INITALIZE Start
	
    uint _totalSupply = 21000000000000000000000000;
    uint public latestDifficultyPeriodStarted2 = block.timestamp;
    uint public epochCount = 0;//number of 'blocks' mined

    uint public _BLOCKS_PER_READJUSTMENT = 8;

    //a little number
    uint public  _MINIMUM_TARGET = 2**16;
    
    uint public  _MAXIMUM_TARGET = 2**234;
    uint public miningTarget = _MAXIMUM_TARGET.div(200000000000*25);  //1000 million difficulty to start until i enable mining
    
    bytes32 public challengeNumber = blockhash(block.number - 1);   //generate a new one when a new reward is minted
    uint public rewardEra = 0;
    uint public maxSupplyForEra = (_totalSupply - _totalSupply.div( 2**(rewardEra + 1)));
    uint public reward_amount = 0;
    
    //Stuff for Functions
    uint oldecount = 0;
    uint public previousBlockTime  =  block.timestamp;
    uint public Token2Per=           1000000;
    uint Token2Min=                       88;
    uint public tokensMinted;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    mapping(address => uint) public divide;
    uint previousKingDiv;
    mapping(address => uint) public ownerAmt;
    mapping(address => address) public ownerOfDivide;
    uint give0x = 0;
    uint give = 1;
    // metadata
    string public name = "ArbiForge";
    string public constant symbol = "AFge";
    uint8 public constant decimals = 18;

    uint256 lastrun = block.timestamp;
    uint public latestDifficultyPeriodStarted = block.number;
    bool initeds = false;
    
    // mint 1 token to setup LPs
	    constructor() public {
    balances[msg.sender] = 1000000000000000000;
    emit Transfer(address(0), msg.sender, 1000000000000000000);
	}


function donateKing(address token, uint amt, uint divz) internal {
	previousKingDiv = whatDiv(token);
	require(amt > ownerAmt[token] || amt > IERC20(token).balanceOf(address(this)), "Must donate more than balance or last big send.");
	IERC20(token).transferFrom(msg.sender, address(this), amt);
	ownerAmt[token] = amt;
	require( divz >= 2500  && divz <= 250000, "Must be within 2500 - 250000");
	divide[token] = divz;
}

//Standard distribution is 6 months with 5000
function whatDiv(address token) public returns(uint suc){
	if(divide[token] == 0){
		return 5000;
	}else{
		return divide[token];
	}
}

function zinit(address AuctionAddress2, address LPGuild2, address _ZeroXBTCAddress) public onlyOwner{
        uint x = 21000000000000000000000000; 
        // Only init once
        assert(!initeds);
        initeds = true;
	    previousBlockTime = block.timestamp;
	    reward_amount = (24 * 10**uint(decimals) ).div( 2**rewardEra );
    	rewardEra = 0;
	    tokensMinted = 0;
	    epochCount = 0;
    	miningTarget = _MAXIMUM_TARGET.div(1); //5000000 = 31gh/s @ 7 min for FPGA mining
        latestDifficultyPeriodStarted2 = block.timestamp;
    	_startNewMiningEpoch();
        // Init contract variables and mint
        balances[AuctionAddress2] = x/2;
	
        emit Transfer(address(0), AuctionAddress2, x/2);
	
    	AddressAuction = AuctionAddress2;
        AddressLPReward = payable(LPGuild2);
        AddressZeroXBTC = _ZeroXBTCAddress;
	
        oldecount = epochCount;
	
		setOwner(address(0));
     
    }



	///
	// Managment
	///

	function ARewardSender() public {
		//runs every _BLOCKS_PER_READJUSTMENT / 4

		uint256 runs = block.timestamp - lastrun;

		uint256 epochsPast = epochCount - oldecount; //actually epoch
		uint256 runsperepoch = runs / epochsPast;

		reward_amount = (24 * 10**uint(decimals)).div( 2**rewardEra );
		uint256 x = (runsperepoch * 888).divRound(targetTime);
		uint256 ratio = x * 100 / 888;
		uint256 totalOwed;
		
		 if(ratio < 2000){
			totalOwed = (508606*(x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
		 }else {
			totalOwed = (400000000);
		} 

		if( balanceOf(address(this)) > (50 * 2 * (Token2Per * _BLOCKS_PER_READJUSTMENT)/4)){  // at least enough blocks to rerun this function for both LPRewards and Users
			//IERC20(AddressZeroXBTC).transfer(AddressLPReward, ((epochsPast) * totalOwed * Token2Per * give0xBTC).div(100000000));
			
            address payable to = payable(AddressLPReward);
            to.send(((epochsPast) * totalOwed * Token2Per * give0x).div(100000000));
            give0x = 1 * give;
		}else{
			give0x = 0;
		}
		oldecount = epochCount; //actually epoch

		lastrun = block.timestamp;
	}


	//comability function
	function mint(uint256 nonce, bytes32 challenge_digest) public returns (bool success) {
		mintTo(nonce, challenge_digest, msg.sender);
		return true;
	}
	
	///add a require statemnt
	function mintNFT(address nftaddy, uint nftNumber, uint256 nonce, bytes32 challenge_digest) public returns (bool success) {
		require(epochCount % 100 == 0, "Only mint on 100ths mints");
		mintTo(nonce, challenge_digest, msg.sender);
		IERC721(nftaddy).approve(msg.sender, nftNumber);
		IERC721(nftaddy).transferFrom(address(this), msg.sender, nftNumber);
		return true;
	}

	function mintTo(uint256 nonce, bytes32 challenge_digest,  address mintTo) public returns (uint256 owed) {

		bytes32 digest =  keccak256(abi.encodePacked(challengeNumber, msg.sender, nonce));

		//the challenge digest must match the expected
		require(digest == challenge_digest, "Old challenge_digest or wrong challenge_digest");

		//the digest must be smaller than the target
		require(uint256(digest) < miningTarget, "Digest must be smaller than miningTarget");
		_startNewMiningEpoch();

		require(block.timestamp > previousBlockTime, "No same second solves");

		//uint diff = block.timestamp - previousBlockTime;
		uint256 x = ((block.timestamp - previousBlockTime) * 888) / targetTime;
		uint ratio = x * 100 / 888 ;
		uint totalOwed = 0;
		if(ratio < 3000){
			totalOwed = (508606*(x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
		}else {
			totalOwed = (x*8000000).div(888)+475000000;
			
		}


		balances[mintTo] = balances[mintTo].add((reward_amount * totalOwed).div(100000000));
		balances[AddressLPReward] = balances[AddressLPReward].add((2 * reward_amount * totalOwed).div(100000000));
				
		tokensMinted = tokensMinted.add((reward_amount * totalOwed).div(100000000));
		previousBlockTime = block.timestamp;

		if(give0x > 0){
			if(ratio < 2000){
            			address payable to = payable(mintTo);
             			to.send((totalOwed * Token2Per * give0x).div(100000000));
				//IERC20(AddressZeroXBTC).transfer(mintTo, (totalOwed * Token2Per * give0xBTC).div(100000000 * 2));
			}else{
               			address payable to = payable(mintTo);
               			to.send((40 * Token2Per * give0x).div(10));
				//IERC20(AddressZeroXBTC).transfer(mintTo, (40 * Token2Per * give0xBTC).div(10 * 2));
			}
		}

		emit Mint(msg.sender, (reward_amount * totalOwed).div(100000000), epochCount, challengeNumber );

		return totalOwed;

	}


	function mintTokensArrayTo(uint256 nonce, bytes32 challenge_digest, address[] memory ExtraFunds, address[] memory MintTo) public returns (uint256 owed) {
		uint256 totalOd = mintTo(nonce,challenge_digest, MintTo[0]);
		require(totalOd > 0, "mint issue");

		require(MintTo.length == ExtraFunds.length + 1,"MintTo has to have an extra address compared to ExtraFunds");
		uint xy=0;
		for(xy = 0; xy< ExtraFunds.length; xy++)
		{
			if(epochCount % (2**(xy+1)) != 0){
				break;
			}
			require(ExtraFunds[xy] != address(this) && ExtraFunds[xy] != AddressZeroXBTC, "No base printing of tokens");
			for(uint y=xy+1; y< ExtraFunds.length; y++){
				require(ExtraFunds[y] != ExtraFunds[xy], "No printing The same tokens");
			}
		}
		
		uint256 totalOwed = 0;
		uint256 TotalOwned = 0;
		for(uint x=0; x<xy; x++)
		{
			//epoch count must evenly dividable by 2^n in order to get extra mints. 
			//ex. epoch 2 = 1 extramint, epoch 4 = 2 extra, epoch 8 = 3 extra mints, ..., epoch 32 = 5 extra mints w/ a divRound for the 5th mint(allows small balance token minting aka NFTs)
			if(epochCount % (2**(x+1)) == 0){
				TotalOwned = IERC20(ExtraFunds[x]).balanceOf(address(this));
				if(TotalOwned != 0){
					if( x % 5 == 0 && x != 0){
						totalOwed = (TotalOwned * totalOd).divRound(100000000 * whatDiv(ExtraFunds[x]));
					}else{
						totalOwed = (TotalOwned * totalOd).div(100000000 * whatDiv(ExtraFunds[x]));
					}
				}
			    IERC20(ExtraFunds[x]).transfer(MintTo[x+1], totalOwed);
			}
        }
        	
		emit MegaMint(msg.sender, epochCount, challengeNumber, xy, totalOd );

		return totalOd;

    }

	function mintTokensSameAddress(uint256 nonce, bytes32 challenge_digest, address[] memory ExtraFunds, address MintTo) public returns (bool success) {
		address[] memory dd = new address[](ExtraFunds.length + 1); 

		for(uint x=0; x< (ExtraFunds.length + 1); x++)
		{
			dd[x] = MintTo;
		}
		
		mintTokensArrayTo(nonce, challenge_digest, ExtraFunds, dd);

		return true;
	}


	function empty_mintTo(uint256 nonce, bytes32 challenge_digest, address[] memory ExtraFunds, address[] memory MintTo) public returns (uint256 owed) {
		bytes32 digest =  keccak256(abi.encodePacked(challengeNumber, msg.sender, nonce));

		//the challenge digest must match the expected
		require(digest == challenge_digest, "Old challenge_digest or wrong challenge_digest");

		//the digest must be smaller than the target
		require(uint256(digest) < miningTarget, "Digest must be smaller than miningTarget");
		_startNewMiningEpoch();

		require(block.timestamp > previousBlockTime, "No same second solves");
		require(MintTo.length == ExtraFunds.length,"MintTo has to have same number of addressses as ExtraFunds");
		uint xy=0;
		for(xy = 0; xy< ExtraFunds.length; xy++)
		{
			if(epochCount % (2**(xy+1)) != 0){
				break;
			}
			require(ExtraFunds[xy] != address(this) && ExtraFunds[xy] != AddressZeroXBTC, "No base printing of tokens");
			for(uint y=xy+1; y< ExtraFunds.length; y++){
				require(ExtraFunds[y] != ExtraFunds[xy], "No printing The same tokens");
			}
		}

		uint256 x = ((block.timestamp - previousBlockTime) * 888) / targetTime;
		uint ratio = x * 100 / 888;
		uint totalIN = 0;
		if(ratio < 314){
			totalIN = (61001200 * (x ** 2 )).div(888 ** 2)+ (40861500 * x).div(888);
		}else {
			totalIN = (x * 100000000).div(888) + (350000000);
		} 
		require(totalIN > 0, "mint issue");
		uint256 totalOwed;
		uint256 TotalOwned;
		for(uint x=0; x<xy; x++)
		{
			//epoch count must evenly dividable by 2^n in order to get extra mints. 
			//ex. epoch 2 = 1 extramint, epoch 4 = 2 extra, epoch 8 = 3 extra mints, epoch 16 = 4 extra mints w/ a divRound for the 4th mint(allows small balance token minting aka NFTs)
			if(epochCount % (2**(x+1)) == 0){
				TotalOwned = IERC20(ExtraFunds[x]).balanceOf(address(this));
				if(TotalOwned != 0){
					if( x % 3 == 0 && x != 0){
						totalOwed = (TotalOwned * totalIN).divRound(100000000 * whatDiv(ExtraFunds[x]) * 2);
					}else{
						totalOwed = (TotalOwned * totalIN).div(100000000 * whatDiv(ExtraFunds[x]) * 2 );
				    }
			    IERC20(ExtraFunds[x]).transfer(MintTo[x], totalOwed);
			    }
            }
        }

		previousBlockTime = block.timestamp;
		return totalIN;   
	}



	function _startNewMiningEpoch() internal {


		//if max supply for the era will be exceeded next reward round then enter the new era before that happens
		//59 is the final reward era, almost all tokens minted
		if( tokensMinted.add(reward_amount) > maxSupplyForEra && rewardEra < 60)
		{
			rewardEra = rewardEra + 1;
			maxSupplyForEra = _totalSupply - _totalSupply.div( 2**(rewardEra + 1));
		}

		//set the next minted supply at which the era will change
		// total supply of MINED tokens is 21000000000000000000000000  because of 16 decimal places

		epochCount = epochCount.add(1);

		//every so often, readjust difficulty. Dont readjust when deploying
		if((epochCount) % (_BLOCKS_PER_READJUSTMENT / 4) == 0)
		{
			ARewardSender();
			maxSupplyForEra = _totalSupply - _totalSupply.div( 2**(rewardEra + 1));

			if((epochCount % _BLOCKS_PER_READJUSTMENT== 0))
			{
                /*
				multipler = (IERC20(AddressZeroXBTC).balanceOf(address(this)) / (2000 * 10 ** 8));
				if(( IERC20(AddressZeroXBTC).balanceOf(address(this)) / Token2Per) <= (10000 + 10000*(multipler))) //chosen to give keep 250 days payouts in reserve at current payout
				{
					if(Token2Per.div(2) > Token2Min)
					{
						Token2Per = Token2Per.div(2);
					}
				}else{
					Token2Per = Token2Per.mult(3);
				}
				_reAdjustDifficulty();
			}
            */
			    multipler = balanceOf(address(this)) / (1 * 10 ** 18); //(IERC20(AddressZeroXBTC).balanceOf(address(this)) / (2000 * 10 ** 8));
			    if(( balanceOf(address(this)) / Token2Per) <= (15000 + 15000*(multipler))) //chosen to give keep 250 days payouts in reserve at current payout
				{
					if(Token2Per.div(2) > Token2Min)
					{
						Token2Per = Token2Per.div(2);
					}
				}else{
					Token2Per = Token2Per.mult(3);
				}
				_reAdjustDifficulty();
			}
		}

		challengeNumber = blockhash(block.number - 1);
        
 }


	function _reAdjustDifficulty() internal {
		uint256 blktimestamp = block.timestamp;
		uint TimeSinceLastDifficultyPeriod2 = blktimestamp - latestDifficultyPeriodStarted2;

		uint adjusDiffTargetTime = targetTime *  _BLOCKS_PER_READJUSTMENT; 

		//if there were less eth blocks passed in time than expected
		if( TimeSinceLastDifficultyPeriod2 < adjusDiffTargetTime )
		{
			uint excess_block_pct = (adjusDiffTargetTime.mult(100)).div( TimeSinceLastDifficultyPeriod2 );
			give = 1;
			uint excess_block_pct_extra = excess_block_pct.sub(100).limitLessThan(1000);
			//make it harder 
			miningTarget = miningTarget.sub(miningTarget.div(2000).mult(excess_block_pct_extra));   //by up to 50 %
		}else{
			uint shortage_block_pct = (TimeSinceLastDifficultyPeriod2.mult(100)).div( adjusDiffTargetTime );
			give = 2;
			uint shortage_block_pct_extra = shortage_block_pct.sub(100).limitLessThan(1000); //always between 0 and 1000
			//make it easier
			miningTarget = miningTarget.add(miningTarget.div(500).mult(shortage_block_pct_extra));   //by up to 200 %
		}

		latestDifficultyPeriodStarted2 = blktimestamp;
		latestDifficultyPeriodStarted = block.number;
		if(miningTarget < _MINIMUM_TARGET) //very difficult
		{
			miningTarget = _MINIMUM_TARGET;
		}
		if(miningTarget > _MAXIMUM_TARGET) //very easy
		{
			miningTarget = _MAXIMUM_TARGET;
		}
		
	}


		//42 m coins total
		// = 
		//21 million proof of work
		// + 
		//10.5 million proof of burn
		// +
		//10.5 million rewards for Liquidity Providers


	//help debug mining software
	function checkMintSolution(uint256 nonce, bytes32 challenge_digest, bytes32 challenge_number, uint testTarget) public view returns (bool success) {
		bytes32 digest = bytes32(keccak256(abi.encodePacked(challenge_number,msg.sender,nonce)));
		if(uint256(digest) > testTarget) revert();

		return (digest == challenge_digest);
	}


	//this is a recent ethereum block hash, used to prevent pre-mining future blocks
	function getChallengeNumber() public view returns (bytes32) {

		return challengeNumber;

	}


	//the number of zeroes the digest of the PoW solution requires.  Auto adjusts
	function getMiningDifficulty() public view returns (uint) {

		return _MAXIMUM_TARGET.div(miningTarget);
	}


	function getMiningTarget() public view returns (uint) {

		return miningTarget;

	}


	function getMiningMinted() public view returns (uint) {

		return tokensMinted;

	}


	//21m coins total
	//reward begins at 150 and is cut in half every reward era (as tokens are mined)
	function getMiningReward() public view returns (uint) {
		//once we get half way thru the coins, only get 25 per block
		//every reward era, the reward amount halves.

		return (100 * 10**uint(decimals) ).div( 2**rewardEra ) ;

		}


	function getEpoch() public view returns (uint) {

		return epochCount ;

	}


	//help debug mining software
	function getMintDigest(uint256 nonce, bytes32 challenge_digest, bytes32 challenge_number) public view returns (bytes32 digesttest) {

		bytes32 digest =  keccak256(abi.encodePacked(challengeNumber, msg.sender, nonce));

		return digest;

	}


		// ------------------------------------------------------------------------

		// Get the token balance for account `tokenOwner`

		// ------------------------------------------------------------------------

	function balanceOf(address tokenOwner) public override view returns (uint balance) {

		return balances[tokenOwner];

	}


		// ------------------------------------------------------------------------

		// Transfer the balance from token owner's account to `to` account

		// - Owner's account must have sufficient balance to transfer

		// - 0 value transfers are allowed

		// ------------------------------------------------------------------------


	function transfer(address to, uint tokens) public override returns (bool success) {

		balances[msg.sender] = balances[msg.sender].sub(tokens);
		balances[to] = balances[to].add(tokens);

		emit Transfer(msg.sender, to, tokens);

		return true;

	}


		// ------------------------------------------------------------------------

		// Token owner can approve for `spender` to transferFrom(...) `tokens`

		// from the token owner's account

		//

		// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md

		// recommends that there are no checks for the approval double-spend attack

		// as this should be implemented in user interfaces

		// ------------------------------------------------------------------------


	function approve(address spender, uint tokens) public override returns (bool success) {

		allowed[msg.sender][spender] = tokens;

		emit Approval(msg.sender, spender, tokens);

		return true;

	}


		// ------------------------------------------------------------------------

		// Transfer `tokens` from the `from` account to the `to` account

		//

		// The calling account must already have sufficient tokens approve(...)-d

		// for spending from the `from` account and

		// - From account must have sufficient balance to transfer

		// - Spender must have sufficient allowance to transfer

		// - 0 value transfers are allowed

		// ------------------------------------------------------------------------


	function transferFrom(address from, address to, uint tokens) public override returns (bool success) {

		balances[from] = balances[from].sub(tokens);
		allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
		balances[to] = balances[to].add(tokens);

		emit Transfer(from, to, tokens);

		return true;

	}


		// ------------------------------------------------------------------------

		// Returns the amount of tokens approved by the owner that can be

		// transferred to the spender's account

		// ------------------------------------------------------------------------


	function allowance(address tokenOwner, address spender) public override view returns (uint remaining) {

		return allowed[tokenOwner][spender];

	}




	  //Allow ETH to enter
	receive() external payable {

	}


	fallback() external payable {

	}
}

/*
*
* MIT License
* ===========
*
* Copyright (c) 2022 Forge
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.   
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
*/
