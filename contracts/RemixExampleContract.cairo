######### Remix game day
# Using contract functions to manipulate contract variables
# In this exercice, you need to:
# - Understand the basic syntax of the contract
# - Customize it to mint a specific NFT on address XXX
# - Deploy your contract using the remix plugin
# - Interact with your contract on https://goerli.voyager.online/ in order to mint the desired NFT

## What you'll learn
# - How to read StarkNet contracts
# - How to deploy StarkNet contracts using remix
# - How to interact with a deployed contract on StarkNet

## Want to go further? Of course you do! Pick and chose what you want to learn
# - Learn to read Cairo and interact with contract, no code required! https://github.com/l-henri/starknet-cairo-101
# - Deploy your own ERC20 https://github.com/l-henri/starknet-erc20
# - Deploy your own ERC721 https://github.com/l-henri/starknet-erc721
# - Build a cross layer app https://github.com/l-henri/starknet-messaging-bridge

######### 
# General directives and imports
######### 
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin


######### 
# Declaring storage vars
######### 

# Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
# In Cairo, most numbers are represented as felt. Read more about felts here https://www.cairo-lang.org/docs/hello_cairo/intro.html#field-element
#

@storage_var
func nft_to_mint_address_internal() -> (nft_to_mint_address_internal: felt):
end

@storage_var
func nft_to_mint_recipient_internal() -> (nft_to_mint_recipient_internal: felt):
end

######### 
# Declaring getters
######### 

# Public variables should be declared explicitly with a getter
#
@view
func nft_to_mint_address{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (nft_to_mint_address: felt):
    let (nft_to_mint_address) = nft_to_mint_address_internal.read()
    return (nft_to_mint_address)
end

@view
func nft_to_mint_recipient{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (nft_to_mint_recipient: felt):
    let (nft_to_mint_recipient) = nft_to_mint_recipient_internal.read()
    return (nft_to_mint_recipient)
end


######### 
# Declaring events
######### 

# Like on Ethereum, events are not part of the state, but can be used to log things
#
@event
func set_nft_recipient(nft_recipient: felt):
end

######### 
# Declaring interfaces
######### 

# This describe how the current contract can interact with other contracts of type IRemix_game_day_nft
#
@contract_interface
namespace IRemix_game_day_nft:
    func mint_from_remix(to: felt) :
    end
end

######### 
# Constructor
######### 

# This function is called when the current contract is first deployed
#

@constructor
func constructor{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }():
    # Setting the target ERC721 to mint. Set the correct address here.
    nft_to_mint_address_internal.write(49)
   
    return ()
end


######### 
# External functions
######### 

# These functions can be called by other contracts
#

# This function will call the NFT contract stored in nft_to_mint_address and mint an NFT for nft_to_mint_recipient.
# This is the final function call you'll have to make. 
# Before doing that, make sure to customize the contract correctly!
@external
func mint_an_nft_for_me_please{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> ():

    # Reading the target NFT address
    let (nft_to_mint_address_local) = nft_to_mint_address_internal.read()
    # Reading the recipient of the NFT to mint
    let (nft_to_mint_recipient_local) = nft_to_mint_recipient_internal.read()
    # Minting the NFT. Sneakaaaaaay
    IRemix_game_day_nft.mint_from_remix(contract_address=nft_to_mint_recipient_local, to=nft_to_mint_address_local)
    return ()
end


# A simple ping function to check that you deployed indeed this contract
# It won't work as is; you need to make sure it returns "Pong" when it is called
# This function returns a felt though, so make sure you encode "Pong" as a felt
@external
func ping{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> (response: felt):
    return (310939380847)
end

# A function to let you set variable nft_to_mint_recipient_internal. 
# You don't have to use it, but it may be useful
@external
func set_recipient_address{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(recipient_address: felt ):
    nft_to_mint_recipient_internal.write(1234567890)
    set_nft_recipient.emit(recipient_address)
    return ()
end





