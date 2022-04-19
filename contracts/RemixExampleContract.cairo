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

######### 
# General directives and imports
######### 
%lang starknet
%builtins pedersen range_check

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
# Declaring interfaces
######### 

# This describe how this contract can interact with other contracts
#
@contract_interface
namespace remix_game_day_nft:
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
# This is the final function call you'll have to make. Before doing that, make sure to customize the contract correctly!
@external
func mint_an_nft_for_me_please{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> ():

    # This function 
    return ()
end


# A simple ping function to check that you deployed indeed this contract
@external
func ping{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> (response: felt):
    return (1349480039)
end




